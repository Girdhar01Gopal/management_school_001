import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../models/session22_model.dart';
import '../models/session_month_wise_fee.dart';

class SessionMonthWiseFeeController extends GetxController {
  // ── Observables ─────────────────────────────────────────────────────────────
  RxBool isLoading = false.obs;
  RxBool isSessionLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxString secUrl = ''.obs;
  RxString selectedSession = ''.obs;
  RxString schoolId = ''.obs;

  // Full objects from ViewSession API
  RxList<SessionModel2> sessionList = <SessionModel2>[].obs;

  // Convenience getter — strings only for the dropdown
  List<String> get sessionStrings =>
      sessionList.map((s) => s.session).toList();

  RxList<SessionMonthWiseFee> feeDataList = <SessionMonthWiseFee>[].obs;

  /// Groups the flat API list by MonthName so a month (APR/MAY/JUN..) is
  /// shown only once, even when the API returns rows for more than one
  /// session for that same month.
  ///
  /// IMPORTANT: entries are kept in the SAME order the API returned them
  /// (i.e. NOT re-sorted by selectedSession). This matches the live site:
  /// the "Total Fee" and "Total Due / Advance" cards always read from
  /// group.entries.first — the first session-row the API sent for that
  /// month — regardless of which session is picked in the dropdown.
  /// "Total Paid" is the only card that combines every session, so its
  /// value/breakdown is order-independent.
  List<SessionMonthWiseFeeGroup> get groupedFeeData {
    final Map<String, SessionMonthWiseFeeGroup> grouped = {};

    for (final item in feeDataList) {
      final key = item.monthName;
      if (!grouped.containsKey(key)) {
        grouped[key] = SessionMonthWiseFeeGroup(
          monthName: item.monthName,
          tillMonth: item.tillMonth,
          entries: [],
        );
      }
      grouped[key]!.entries.add(item);
    }

    return grouped.values.toList();
  }

  // ── Summary totals (computed from feeDataList) ───────────────────────────
  RxDouble summaryTotalFee = 0.0.obs;
  RxDouble summaryTotalPaid = 0.0.obs;
  RxDouble summaryTotalDue = 0.0.obs;
  RxDouble summaryTotalAdvance = 0.0.obs;

  // ── Lifecycle ────────────────────────────────────────────────────────────
  @override
  void onInit() async {
    super.onInit();

    // Accept URL passed as argument (same pattern as DashboardScreenController)
    final args = Get.arguments;
    if (args != null && args['url'] != null) {
      secUrl.value = args['url'].toString().trim();
    }

    await _loadSecUrl();

    // schoolId needed for ViewSession API endpoint
    schoolId.value =
        await PrefManager().readValue(key: PrefConst.SchoolId) ?? '';

    await _loadSessionDropdown();
    if (selectedSession.value.isNotEmpty) {
      await fetchFeeData();
    }
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  /// Ensures secUrl is populated (from args or SharedPreferences).
  Future<void> _loadSecUrl() async {
    if (secUrl.value.isEmpty) {
      secUrl.value =
          await PrefManager().readValue(key: PrefConst.secUrlLocalSaved) ?? '';
    }
    _normaliseUrl();
  }

  void _normaliseUrl() {
    if (secUrl.value.isNotEmpty && !secUrl.value.endsWith('/')) {
      secUrl.value = '${secUrl.value}/';
    }
  }

  /// Fetches all sessions for this school from ViewSession API.
  /// URL pattern: {secUrl}api/FMSCoreApi/ViewSession/{schoolId}
  /// Also sets selectedSession to the most recent session in the list.
  Future<void> _loadSessionDropdown() async {
    isSessionLoading.value = true;
    try {
      await _loadSecUrl();

      if (secUrl.value.isEmpty || schoolId.value.isEmpty) {
        debugPrint('_loadSessionDropdown: secUrl or schoolId empty');
        return;
      }

      final url =
          '${secUrl.value}api/FMSCoreApi/ViewSession/${schoolId.value}';
      debugPrint('ViewSession URL => $url');

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final parsed =
        SessionModel2Response.fromJson(jsonDecode(response.body));

        if (parsed.statusCode == 200 && parsed.data.isNotEmpty) {
          // Sort descending by sessionId so newest is first
          final sorted = [...parsed.data]
            ..sort((a, b) => b.sessionId.compareTo(a.sessionId));

          sessionList.value = sorted;

          // Default selected = first (most recent) session
          selectedSession.value = sorted.first.session;

          debugPrint(
              'Sessions loaded: ${sessionStrings} | selected: ${selectedSession.value}');
        } else {
          debugPrint('ViewSession: no data — ${parsed.message}');
        }
      } else {
        debugPrint('ViewSession API failed: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('_loadSessionDropdown error => $e');
    } finally {
      isSessionLoading.value = false;
    }
  }

  // ── Public actions ────────────────────────────────────────────────────────

  /// Called when user picks a different session from the dropdown.
  void onSessionChanged(String? value) {
    if (value == null || value == selectedSession.value) return;
    selectedSession.value = value;
    fetchFeeData();
  }

  /// Main data fetch — uses selected session + secUrl.
  Future<void> fetchFeeData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      feeDataList.clear();
      _resetSummary();

      await _loadSecUrl();

      if (secUrl.value.isEmpty) {
        errorMessage.value = 'Base URL not configured';
        return;
      }
      if (selectedSession.value.isEmpty) {
        errorMessage.value = 'Please select a session';
        return;
      }

      final url =
          '${secUrl.value}api/FMSCoreApi/SessionWithMonthWiseFeeCollection/${selectedSession.value}';
      debugPrint('Fee Collection URL => $url');

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final parsed =
        SessionMonthWiseFeeResponse.fromJson(jsonDecode(response.body));

        if (parsed.statusCode == 200 && parsed.data.isNotEmpty) {
          feeDataList.value = parsed.data;
          _sortCurrentMonthFirst();
          _computeSummary();
        } else {
          errorMessage.value =
          parsed.message.isNotEmpty ? parsed.message : 'No data found';
        }
      } else {
        errorMessage.value =
        'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: $e';
      debugPrint('fetchFeeData error => $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Current month (tillMonth == now.month) sabse upar aaye, baaki same order.
  /// Uses List.sort's stable ordering, so within the same month the
  /// session-row order coming from the API is preserved.
  void _sortCurrentMonthFirst() {
    final currentMonth = DateTime.now().month;
    final list = [...feeDataList];
    list.sort((a, b) {
      final aIs = a.tillMonth == currentMonth ? 0 : 1;
      final bIs = b.tillMonth == currentMonth ? 0 : 1;
      return aIs.compareTo(bIs);
    });
    feeDataList.value = list;
  }

  /// NOTE: TotalDue / TotalAdvance fields in the API response are currently
  /// always 0 (a data quirk on the backend) — actual due/advance is only
  /// correct via (SchoolDue+TransportDue) / (SchoolAdvance+TransportAdvance).
  /// The summary strip therefore sums those computed values, same as each
  /// month's card does, instead of trusting the raw TotalDue/TotalAdvance
  /// fields.
  void _computeSummary() {
    double fee = 0, paid = 0, due = 0, advance = 0;
    for (final item in feeDataList) {
      fee += item.totalFee;
      paid += item.totalPaid;
      due += (item.totalSchoolDue + item.totalTransportDue);
      advance += (item.totalSchoolAdvance + item.totalTransportAdvance);
    }
    summaryTotalFee.value = fee;
    summaryTotalPaid.value = paid;
    summaryTotalDue.value = due;
    summaryTotalAdvance.value = advance;
  }

  void _resetSummary() {
    summaryTotalFee.value = 0;
    summaryTotalPaid.value = 0;
    summaryTotalDue.value = 0;
    summaryTotalAdvance.value = 0;
  }

  /// Formatted currency helper used by the UI.
  /// Indian numbering format: last 3 digits ek group, uske baad har 2-2
  /// digits ka group (e.g. 8435055 -> 84,35,055; 100000 -> 1,00,000).
  /// ".00" nahi dikhta — hamesha whole number.
  String fmt(double value) {
    final isNegative = value < 0;
    final wholeNumber = value.abs().round().toString();

    String formatted;
    if (wholeNumber.length <= 3) {
      formatted = wholeNumber;
    } else {
      final lastThree = wholeNumber.substring(wholeNumber.length - 3);
      final remaining = wholeNumber.substring(0, wholeNumber.length - 3);
      final buffer = StringBuffer();
      for (int i = 0; i < remaining.length; i++) {
        final posFromEnd = remaining.length - i;
        buffer.write(remaining[i]);
        if (posFromEnd > 1 && posFromEnd % 2 == 1) {
          buffer.write(',');
        }
      }
      formatted = '${buffer.toString()},$lastThree';
    }

    return isNegative ? '-$formatted' : formatted;
  }
}