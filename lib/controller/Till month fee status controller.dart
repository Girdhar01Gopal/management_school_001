import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:management_school/models/session_model.dart';

import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../models/Session month wise fee collection model till month.dart';

class TillMonthFeeStatusController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxString secUrl = "".obs;
  RxString schoolId = "".obs;
  RxString session = "".obs;

  // Label like "Till July 2026"
  RxString tillMonthLabel = "".obs;

  // The single "Total" row for the current session — this drives every card.
  Rx<MonthWiseFeeData?> totalRow = Rx<MonthWiseFeeData?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args["url"] != null) {
      secUrl.value = args["url"].toString().trim();
    }
    fetchTillMonthData();
  }

  Future<void> fetchTillMonthData() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      if (secUrl.value.isEmpty) {
        secUrl.value =
            await PrefManager().readValue(key: PrefConst.secUrlLocalSaved) ??
                "";
      }
      if (secUrl.value.isNotEmpty && !secUrl.value.endsWith('/')) {
        secUrl.value = "${secUrl.value}/";
      }

      if (schoolId.value.isEmpty) {
        schoolId.value =
            await PrefManager().readValue(key: PrefConst.SchoolId) ?? "";
      }

      await _fetchCurrentSession();

      if (secUrl.value.isEmpty) {
        errorMessage.value = "Base URL not found";
        return;
      }
      if (session.value.isEmpty) {
        errorMessage.value = "Session not found";
        return;
      }

      final now = DateTime.now();
      final int tillMonth = now.month; // calendar month, e.g. July => 7
      tillMonthLabel.value = "Till ${_monthName(tillMonth)} ${now.year}";

      final url = "${secUrl.value}api/FMSCoreApi/"
          "SessionWithMonthWiseFeeCollectionTillMonth/${session.value}/$tillMonth";

      debugPrint("TillMonthFeeStatus URL => $url");

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final model = SessionMonthWiseFeeCollectionModel.fromJson(
          jsonDecode(response.body),
        );

        final rows = model.data;

        // Prefer the exact "Total" row for the current session; fall back
        // to any "Total" row if the session string doesn't match exactly.
        MonthWiseFeeData? match;
        for (final row in rows) {
          if ((row.monthName?.trim().toUpperCase() == "TOTAL") &&
              row.session?.trim() == session.value.trim()) {
            match = row;
            break;
          }
        }
        match ??= rows.lastWhereOrNull(
              (row) => row.monthName?.trim().toUpperCase() == "TOTAL",
        );

        if (match == null) {
          totalRow.value = null;
          errorMessage.value = "No dashboard data found";
          return;
        }

        totalRow.value = match;
      } else {
        errorMessage.value =
        "Failed to load fee status: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Error loading fee status: $e";
      debugPrint("TillMonthFeeStatus error => $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchCurrentSession() async {
    try {
      final url = "${secUrl.value}api/FMSCoreApi/GetCurrentSession";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final sessionResponse =
        SessionResponseModel.fromJson(jsonDecode(response.body));

        if (sessionResponse.statuscode == 200 &&
            sessionResponse.data != null &&
            sessionResponse.data!.isNotEmpty) {
          session.value = sessionResponse.data!.first.session?.trim() ?? "";
        }
      } else {
        debugPrint("Session API failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("session error $e");
    }
  }

  String _monthName(int m) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December",
    ];
    return months[m - 1];
  }

  // ── Derived values used directly by the UI ──────────────────────────────
  double get totalAmount => totalRow.value?.totalFee ?? 0;
  double get totalAmountSchool => totalRow.value?.totalNetSchoolFee ?? 0;
  double get totalAmountTransport => totalRow.value?.totalNetTransportFee ?? 0;

  double get totalReceived => totalRow.value?.totalPaid ?? 0;
  double get totalReceivedSchool => totalRow.value?.totalSchoolFeePaid ?? 0;
  double get totalReceivedTransport =>
      totalRow.value?.totalTransportFeePaid ?? 0;

  double get totalPending =>
      (totalRow.value?.totalSchoolDue ?? 0) +
          (totalRow.value?.totalTransportDue ?? 0);
  double get totalPendingSchool => totalRow.value?.totalSchoolDue ?? 0;
  double get totalPendingTransport => totalRow.value?.totalTransportDue ?? 0;
}

extension _FirstWhereOrNullExt<T> on List<T> {
  T? lastWhereOrNull(bool Function(T) test) {
    for (var i = length - 1; i >= 0; i--) {
      if (test(this[i])) return this[i];
    }
    return null;
  }
}