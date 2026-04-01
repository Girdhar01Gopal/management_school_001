import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management_school/models/school_management_model.dart';
import 'package:management_school/models/session_model.dart';
import 'package:http/http.dart' as http;

import '../infrastructures/routes/page_constants.dart';
import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../repo/app_url.dart';

class DashboardTile {
  final String name;
  final String count;
  final IconData image;
  final Color color;
  final List<Color>? gradientColors;

  DashboardTile({
    required this.name,
    required this.count,
    required this.image,
    required this.color,
    this.gradientColors,
  });
}

class DashboardScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxString schoolName = "".obs;
  RxString session = "".obs;
  RxString schoolId = "".obs;
  RxString userName = "".obs;
  RxString siblingCount = "".obs;

  RxString schoolLogo = "".obs;
  RxString secUrl = "".obs;

  RxList<DashboardTile> filteredList = <DashboardTile>[].obs;



  @override
  void onInit() async {
    super.onInit();

    final args = Get.arguments;

    if (args != null && args["url"] != null) {
      secUrl.value = args["url"].toString().trim();
    }

    await loadSchoolHeaderData();

    schoolId.value =
        await PrefManager().readValue(key: PrefConst.SchoolId) ?? "";

    await fetchCurrentSession();
    await fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      if (schoolId.value.isEmpty) {
        schoolId.value =
            await PrefManager().readValue(key: PrefConst.SchoolId) ?? "";
      }

      if (secUrl.value.isEmpty) {
        secUrl.value =
            await PrefManager().readValue(key: PrefConst.secUrlLocalSaved) ?? "";
      }

      if (secUrl.value.isNotEmpty && !secUrl.value.endsWith('/')) {
        secUrl.value = "${secUrl.value}/";
      }

      await fetchCurrentSession();
      await loadDashboardData();
    } catch (e) {
      errorMessage.value = "Error: $e";
      debugPrint("fetchDashboardData error => $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      if (schoolId.value.isEmpty) {
        schoolId.value =
            await PrefManager().readValue(key: PrefConst.SchoolId) ?? "";
      }

      if (secUrl.value.isEmpty) {
        secUrl.value =
            await PrefManager().readValue(key: PrefConst.secUrlLocalSaved) ?? "";
      }

      if (secUrl.value.isNotEmpty && !secUrl.value.endsWith('/')) {
        secUrl.value = "${secUrl.value}/";
      }



      if (secUrl.value.isEmpty) {
        filteredList.clear();
        errorMessage.value = "Base URL not found";
        return;
      }

      if (schoolId.value.isEmpty) {
        filteredList.clear();
        errorMessage.value = "SchoolId not found";
        return;
      }

      if (session.value.isEmpty) {
        filteredList.clear();
        errorMessage.value = "Session not found";
        return;
      }

      final url =
          "${secUrl.value}api/FMSCoreApi/GetTotalCount/${session.value}/${schoolId.value}";

      print("Dashboard URL => $url");

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final dashboardResponse =
        SchoolManagementModel.fromJson(jsonDecode(response.body));

        final SchoolManagementData? dashboardData =
        (dashboardResponse.data != null &&
            dashboardResponse.data!.isNotEmpty)
            ? dashboardResponse.data!.first
            : null;

        if (dashboardData == null) {
          filteredList.clear();
          errorMessage.value = "No dashboard data found";
          return;
        }

        filteredList.value = _buildDashboardTiles(dashboardData);
      } else {
        filteredList.clear();
        errorMessage.value =
        "Failed to load dashboard data: ${response.statusCode}";
      }
    } catch (e) {
      filteredList.clear();
      errorMessage.value = "Error loading dashboard data: $e";
      debugPrint("Error loading dashboard data: $e");
    } finally {
      isLoading.value = false;
    }
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
      print("Session URL => $url");

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final sessionResponse =
        SessionResponseModel.fromJson(jsonDecode(response.body));

        if (sessionResponse.statuscode == 200 &&
            sessionResponse.data != null &&
            sessionResponse.data!.isNotEmpty) {
          session.value = sessionResponse.data!.first.session?.trim() ?? "";
        }

        print("Current Session => ${session.value}");
      } else {
        debugPrint("Session API failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("session error $e");
    }
  }

  List<DashboardTile> _buildDashboardTiles(SchoolManagementData item) {
    return [
      DashboardTile(
        name: "Today Collection",
        count: (item.todayTotelFee ?? 0).toString(),
        image: Icons.payments_rounded,
        color: const Color(0xFF16A34A),
        gradientColors: const [Color(0xFF22C55E), Color(0xFF15803D)],
      ),
      DashboardTile(
        name: "Monthly Collection",
        count: (item.totelmonthsFee ?? 0).toString(),
        image: Icons.calendar_month_rounded,
        color: const Color(0xFFD97706),
        gradientColors: const [Color(0xFFF59E0B), Color(0xFFB45309)],
      ),
      DashboardTile(
        name: "Total Students",
        count: (item.totalstudents ?? 0).toString(),
        image: Icons.groups_rounded,
        color: const Color(0xFF2563EB),
        gradientColors: const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
      ),
      DashboardTile(
        name: "Total Teachers",
        count: (item.totalteacher ?? 0).toString(),
        image: Icons.person_pin_rounded,
        color: const Color(0xFF9333EA),
        gradientColors: const [Color(0xFFA855F7), Color(0xFF7E22CE)],
      ),
      DashboardTile(
        name: "Total Staff",
        count: (item.totalStaff ?? 0).toString(),
        image: Icons.badge_rounded,
        color: const Color(0xFF0891B2),
        gradientColors: const [Color(0xFF06B6D4), Color(0xFF0E7490)],
      ),
      DashboardTile(
        name: "Today's Birthday",
        count: (item.todayBirthday ?? 0).toString(),
        image: Icons.cake_rounded,
        color: const Color(0xFFF97316),
        gradientColors: const [Color(0xFFFB923C), Color(0xFFEA580C)],
      ),
      DashboardTile(
        name: "Total Boys",
        count: (item.totalBoys ?? 0).toString(),
        image: Icons.boy_rounded,
        color: const Color(0xFF0F766E),
        gradientColors: const [Color(0xFF14B8A6), Color(0xFF115E59)],
      ),
      DashboardTile(
        name: "Total Girls",
        count: (item.totalGirls ?? 0).toString(),
        image: Icons.girl_rounded,
        color: const Color(0xFFDB2777),
        gradientColors: const [Color(0xFFEC4899), Color(0xFFBE185D)],
      ),
      DashboardTile(
        name: "Transport Students",
        count: (item.transportstudents ?? 0).toString(),
        image: Icons.directions_bus_rounded,
        color: const Color(0xFF6366F1),
        gradientColors: const [Color(0xFF818CF8), Color(0xFF4F46E5)],
      ),
      DashboardTile(
        name: "Due Amount",
        count: (item.dueAmount ?? 0).toString(),
        image: Icons.account_balance_wallet_rounded,
        color: const Color(0xFF0D9488),
        gradientColors: const [Color(0xFF14B8A6), Color(0xFF0F766E)],
      ),
    ];
  }

  void onSelectedBottom(int index) {
    if (index < 0 || index >= filteredList.length) return;
    final selected = filteredList[index];
    Get.snackbar(
      selected.name,
      "Count: ${selected.count}",
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> logoutUser() async {
    await PrefManager().clearPref();
    Get.offAllNamed(RouteName.login_screen);
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

  String get schoolLogoUrl {
    if (secUrl.value.isEmpty || schoolLogo.value.isEmpty) return "";
    return "${secUrl.value}${AppUrl.imageSecUrl}${schoolLogo.value}";
  }
}