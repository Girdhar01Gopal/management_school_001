import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  /// Top info
  RxString schoolName = "Edubloom Public School".obs;
  RxString session = "2025-26".obs;
  RxString schoolId = "SCH-1025".obs;
  RxString userName = "Admin User".obs;
  RxString siblingCount = "2".obs;

  /// Dashboard grid items
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

      await Future.delayed(const Duration(milliseconds: 500));

      loadStaticDashboardData();
    } catch (e) {
      errorMessage.value = "Unable to load dashboard data";
    } finally {
      isLoading.value = false;
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
        name: "Fees Staff",
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