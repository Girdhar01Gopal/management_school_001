import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../infrastructures/routes/page_constants.dart';
import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../repo/app_url.dart';

class DashboardItemModel {
  final String name;
  final IconData image;
  final Color color;
  final String count;
  final List<Color>? gradientColors;

  DashboardItemModel({
    required this.name,
    required this.image,
    required this.color,
    required this.count,
    this.gradientColors,
  });
}

class DashboardScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxString schoolName = "".obs;
  RxString session = "2025-26".obs;
  RxString schoolId = "".obs;
  RxString userName = "".obs;
  RxString siblingCount = "".obs;

  RxString schoolLogo = "".obs;
  RxString secUrl = "".obs;

  RxList<DashboardItemModel> filteredList = <DashboardItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await loadSchoolHeaderData();
      await Future.delayed(const Duration(milliseconds: 300));

      loadStaticDashboardData();
    } catch (e) {
      errorMessage.value = "Unable to load dashboard data";
    } finally {
      isLoading.value = false;
    }
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

    secUrl.value =
        await PrefManager().readValue(key: PrefConst.secUrlLocalSaved) ?? "";

    debugPrint("schoolName => ${schoolName.value}");
    debugPrint("schoolId => ${schoolId.value}");
    debugPrint("schoolLogo => ${schoolLogo.value}");
    debugPrint("secUrl => ${secUrl.value}");
    debugPrint("finalLogoUrl => $schoolLogoUrl");
  }

  String get schoolLogoUrl {
    if (secUrl.value.isEmpty || schoolLogo.value.isEmpty) return "";
    return "${secUrl.value}${AppUrl.imageSecUrl}${schoolLogo.value}";
  }

  Future<void> logoutUser() async {
    try {
      await PrefManager().writeValue(key: PrefConst.UserName, value: "");
      await PrefManager().writeValue(key: PrefConst.UserPass, value: "");
      await PrefManager().writeValue(key: PrefConst.SchoolId, value: "");
      await PrefManager().writeValue(key: PrefConst.baseUrlLocalSaved, value: "");
      await PrefManager().writeValue(key: PrefConst.secUrlLocalSaved, value: "");
      await PrefManager().writeValue(key: PrefConst.schoolImage, value: "");
      await PrefManager().writeValue(key: PrefConst.schoolname, value: "");
      await PrefManager().writeValue(key: PrefConst.schoolphone, value: "");
      await PrefManager().writeValue(key: PrefConst.schoolemail, value: "");
      await PrefManager().writeValue(key: PrefConst.getBaseUrl, value: "");

      schoolName.value = "";
      schoolId.value = "";
      userName.value = "";
      schoolLogo.value = "";
      secUrl.value = "";

      Get.offAllNamed(RouteName.login_screen);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Logout failed",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    }
  }

  void loadStaticDashboardData() {
    filteredList.value = [
      DashboardItemModel(
        name: "Total Students",
        image: Icons.school_rounded,
        color: const Color(0xFF6F42C1),
        count: "1250",
        gradientColors: const [
          Color(0xFF7E57C2),
          Color(0xFF5E35B1),
        ],
      ),
      DashboardItemModel(
        name: "Fee Due in March",
        image: Icons.calendar_month_rounded,
        color: const Color(0xFFF57C00),
        count: "₹ 2.45L",
        gradientColors: const [
          Color(0xFFFFB74D),
          Color(0xFFF57C00),
        ],
      ),
      DashboardItemModel(
        name: "Total Teacher",
        image: Icons.person_rounded,
        color: const Color(0xFF1E88E5),
        count: "85",
        gradientColors: const [
          Color(0xFF42A5F5),
          Color(0xFF1565C0),
        ],
      ),
      DashboardItemModel(
        name: "Today Collection",
        image: Icons.today_rounded,
        color: const Color(0xFF00897B),
        count: "₹ 35.5K",
        gradientColors: const [
          Color(0xFF26A69A),
          Color(0xFF00796B),
        ],
      ),
      DashboardItemModel(
        name: "Monthly Collection",
        image: Icons.bar_chart_rounded,
        color: const Color(0xFF43A047),
        count: "₹ 8.75L",
        gradientColors: const [
          Color(0xFF66BB6A),
          Color(0xFF2E7D32),
        ],
      ),
      DashboardItemModel(
        name: "Total Staff",
        image: Icons.people_alt_rounded,
        color: const Color(0xFFE53935),
        count: "42",
        gradientColors: const [
          Color(0xFFEF5350),
          Color(0xFFC62828),
        ],
      ),
      DashboardItemModel(
        name: "Session Collection",
        image: Icons.account_balance_wallet_rounded,
        color: const Color(0xFF3949AB),
        count: "₹ 58.4L",
        gradientColors: const [
          Color(0xFF5C6BC0),
          Color(0xFF283593),
        ],
      ),
      DashboardItemModel(
        name: "Session Due",
        image: Icons.pending_actions_rounded,
        color: const Color(0xFFD81B60),
        count: "₹ 6.2L",
        gradientColors: const [
          Color(0xFFEC407A),
          Color(0xFFAD1457),
        ],
      ),
    ];
  }

  Future<void> refreshDashboard() async {
    await fetchDashboardData();
  }

  void onSelectedBottom(int index) {
    if (index < 0 || index >= filteredList.length) return;

    final selectedItem = filteredList[index];

    Get.snackbar(
      "Selected",
      selectedItem.name,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }
}