import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../models/holiday_model.dart';
import '../models/holidays_screen_model.dart';
import '../models/session_model.dart';

class HolidayDashboardController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxString schoolName = "".obs;
  RxString session = "".obs;
  RxString schoolId = "".obs;
  RxString userName = "".obs;
  RxString schoolLogo = "".obs;
  RxString secUrl = "".obs;

  RxList<HolidayItem> holidayList = <HolidayItem>[].obs;
  RxList<HolidayItem> filteredHolidayList = <HolidayItem>[].obs;

  TextEditingController searchController = TextEditingController();
  RxBool isSearchVisible = false.obs;

  @override
  void onInit() async {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args["url"] != null) {
      secUrl.value = args["url"].toString();
    }

    await loadSchoolHeaderData();
    await fetchCurrentSession();
    await fetchHolidays();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadSchoolHeaderData() async {
    schoolName.value =
        await PrefManager().readValue(key: PrefConst.schoolname) ?? "";

    schoolId.value =
        await PrefManager().readValue(key: PrefConst.SchoolId) ?? "";

    userName.value =
        await PrefManager().readValue(key: PrefConst.UserName) ?? "";

    schoolLogo.value =
        await PrefManager().readValue(key: PrefConst.schoolImage) ?? "";

    if (secUrl.value.isEmpty) {
      secUrl.value =
          await PrefManager().readValue(key: PrefConst.secUrlLocalSaved) ?? "";
    }

    if (secUrl.value.isNotEmpty && !secUrl.value.endsWith('/')) {
      secUrl.value = "${secUrl.value}/";
    }

    debugPrint("schoolName => ${schoolName.value}");
    debugPrint("schoolId => ${schoolId.value}");
    debugPrint("schoolLogo => ${schoolLogo.value}");
    debugPrint("secUrl => ${secUrl.value}");
  }

  Future<void> fetchCurrentSession() async {
    try {
      if (secUrl.value.isEmpty) {
        secUrl.value =
            await PrefManager().readValue(key: PrefConst.secUrlLocalSaved) ?? "";
      }

      if (secUrl.value.isNotEmpty && !secUrl.value.endsWith('/')) {
        secUrl.value = "${secUrl.value}/";
      }

      final url = "${secUrl.value}api/FMSCoreApi/GetCurrentSession";
      debugPrint("Session URL => $url");

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final sessionResponse =
        SessionResponseModel.fromJson(jsonDecode(response.body));

        if (sessionResponse.statuscode == 200 &&
            sessionResponse.data != null &&
            sessionResponse.data!.isNotEmpty) {
          session.value = sessionResponse.data!.first.session?.trim() ?? "";
        }

        debugPrint("Current Session => ${session.value}");
      } else {
        debugPrint("Session API failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("session error => $e");
    }
  }

  Future<void> fetchHolidays() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      if (secUrl.value.isEmpty) {
        errorMessage.value = "Base URL not found";
        holidayList.clear();
        filteredHolidayList.clear();
        return;
      }

      if (secUrl.value.isNotEmpty && !secUrl.value.endsWith('/')) {
        secUrl.value = "${secUrl.value}/";
      }

      // Tumhari API ke hisab se फिलहाल schoolId/session path me nahi chahiye
      final String url = "${secUrl.value}api/FMSCoreApi/ViewHolidays";

      debugPrint("Holiday API URL => $url");

      final response = await http.get(Uri.parse(url));

      debugPrint("Holiday response code => ${response.statusCode}");
      debugPrint("Holiday response body => ${response.body}");

      if (response.statusCode == 200) {
        final model =
        HolidayResponseModel.fromJson(jsonDecode(response.body));

        if (model.statuscode == 200 &&
            model.data != null &&
            model.data!.isNotEmpty) {
          holidayList.assignAll(model.data!);

          final sortedList = [...holidayList];
          sortedList.sort((a, b) {
            final aDate = _safeDate(a.dateHoliday);
            final bDate = _safeDate(b.dateHoliday);
            return bDate.compareTo(aDate);
          });

          filteredHolidayList.assignAll(sortedList);
        } else {
          holidayList.clear();
          filteredHolidayList.clear();
          errorMessage.value = "No holidays found";
        }
      } else {
        holidayList.clear();
        filteredHolidayList.clear();
        errorMessage.value = "Failed to load holidays: ${response.statusCode}";
      }
    } catch (e) {
      holidayList.clear();
      filteredHolidayList.clear();
      errorMessage.value = "Error loading holidays: $e";
      debugPrint("Error loading holidays: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshHolidays() async {
    searchController.clear();
    isSearchVisible.value = false;
    filteredHolidayList.assignAll(holidayList);

    await fetchCurrentSession();
    await fetchHolidays();
  }

  void toggleSearch() {
    isSearchVisible.value = !isSearchVisible.value;
    if (!isSearchVisible.value) {
      searchController.clear();
      applySearch('');
    }
  }

  void applySearch(String query) {
    final search = query.trim().toLowerCase();

    if (search.isEmpty) {
      final sortedList = [...holidayList];
      sortedList.sort((a, b) {
        final aDate = _safeDate(a.dateHoliday);
        final bDate = _safeDate(b.dateHoliday);
        return bDate.compareTo(aDate);
      });
      filteredHolidayList.assignAll(sortedList);
      return;
    }

    final result = holidayList.where((item) {
      final occasion = (item.occasion ?? "").toLowerCase();
      final createBy = (item.createBy ?? "").toLowerCase();
      final updateBy = (item.updateBy ?? "").toLowerCase();
      final rawDate = (item.dateHoliday ?? "").toLowerCase();
      final formattedDate = formatDate(item.dateHoliday ?? "").toLowerCase();

      return occasion.contains(search) ||
          createBy.contains(search) ||
          updateBy.contains(search) ||
          rawDate.contains(search) ||
          formattedDate.contains(search);
    }).toList();

    result.sort((a, b) {
      final aDate = _safeDate(a.dateHoliday);
      final bDate = _safeDate(b.dateHoliday);
      return bDate.compareTo(aDate);
    });

    filteredHolidayList.assignAll(result);
  }

  String formatDate(String value) {
    if (value.trim().isEmpty || value == "0001-01-01T00:00:00") {
      return "N/A";
    }

    try {
      final dt = DateTime.parse(value);
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      final year = dt.year.toString();
      return "$day-$month-$year";
    } catch (e) {
      return value;
    }
  }

  String getCreatedBy(HolidayItem item) {
    if ((item.createBy ?? "").trim().isNotEmpty) return item.createBy!;
    if ((item.updateBy ?? "").trim().isNotEmpty) return item.updateBy!;
    return "N/A";
  }

  String getStatusText(HolidayItem item) {
    if (item.isActive == true) return "Active";
    return "Inactive";
  }

  DateTime _safeDate(String? value) {
    if (value == null || value.trim().isEmpty || value == "0001-01-01T00:00:00") {
      return DateTime(1900);
    }
    return DateTime.tryParse(value) ?? DateTime(1900);
  }
}