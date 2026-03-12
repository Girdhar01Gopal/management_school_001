import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../infrastructures/routes/page_constants.dart';

class DashboardScreenController extends GetxController {
  // Static Data for total students and due amount
  RxInt totalStudentCount = 1200.obs; // Static count for total students
  var schoolname = "Edubloom School".obs; // Static school name
  RxDouble totaldueamount = 15000.0.obs; // Static due amount

  int selectedIndex = 0;
  Future<dynamic>? selectedWidget = null;

  // Reactive List for Dashboard Cards
  RxList<DhashboardItemsModel> vehicleDocumentList = RxList<DhashboardItemsModel>();

  // Filtered list for cards excluding Master's and Dashboard
  List<DhashboardItemsModel> get filteredList =>
      vehicleDocumentList.where((item) => item.name != "Master's" && item.name != "Dashboard").toList();

  @override
  void onInit() async {
    super.onInit();
    dashboardCategory(); // Load static dashboard items
  }

  // Navigate to selected screen based on card selection
  void onSelectedBottom(int index) {
    selectedIndex = index;
    // Static navigation for the selected items (will not rely on API data)
    switch (filteredList[index].name) {
      case "Total Teacher":
        //selectedWidget = Get.toNamed(RouteName.total_teacher);
        break;
      case "Today-Coll":
       // selectedWidget = Get.toNamed(RouteName.today_collection);
        break;
      case "Monthly_Coll":
        //selectedWidget = Get.toNamed(RouteName.monthly_collection);
        break;
      case "Fees's":
       // selectedWidget = Get.toNamed(RouteName.fees_screen);
        break;
      case "Staff":
        //selectedWidget = Get.toNamed(RouteName.staff_screen);
        break;
      case "Session Coll":
       // selectedWidget = Get.toNamed(RouteName.session_wise_collection);
        break;
      case "Session Due":
        //selectedWidget = Get.toNamed(RouteName.session_wise_due_screen);
        break;

    }
  }

  // Static items for Dashboard Cards
  void dashboardCategory() {
    // Use .value to update RxList
    vehicleDocumentList.value = [
      DhashboardItemsModel(
        "Total Teacher",
        CupertinoIcons.person_2_fill,
        const Color(0xFF6F42C1),
        gradientColors: [Color(0xFF6F42C1), Color(0xFF9B59B6)],
        count: 1500,  // Adding count for each card
      ),
      DhashboardItemsModel(
        "Today-Coll",
        CupertinoIcons.bubble_left_bubble_right_fill,
        const Color(0xFF2980B9),
        gradientColors: [Color(0xFF2980B9), Color(0xFF3498DB)],
        count: 5,  // Adding count
      ),
      DhashboardItemsModel(
        "Monthly_Coll",
        CupertinoIcons.creditcard_fill,
        const Color(0xFFF39C12),
        gradientColors: [Color(0xFFF39C12), Color(0xFFF1C40F)],
        count: 25,  // Adding count
      ),
      DhashboardItemsModel(
        "Fees's",
        CupertinoIcons.paintbrush_fill,
        const Color(0xFF1ABC9C),
        gradientColors: [Color(0xFF1ABC9C), Color(0xFF16A085)],
        count: 10,  // Adding count
      ),
      // DhashboardItemsModel(
      //   "Teacher's",
      //   CupertinoIcons.text_badge_checkmark,
      //   const Color.fromARGB(255, 101, 168, 19),
      //   gradientColors: [Color(0xFF34495E), Color(0xFF2C3E50)],
      //   count: 30,  // Adding count
      // ),
      DhashboardItemsModel(
        "Staff",
        CupertinoIcons.person,
        const Color(0xFF34495E),
        gradientColors: [Color.fromARGB(255, 201, 229, 208), Color.fromARGB(255, 101, 180, 44)],
        count: 12,  // Adding count
      ),
      DhashboardItemsModel(
        "Session Coll",
        CupertinoIcons.book_fill,
        const Color(0xFF8E44AD),
        gradientColors: [Color(0xFF8E44AD), Color(0xFF9B59B6)],
        count: 20,  // Adding count
      ),
      DhashboardItemsModel(
        "Session Due",
        CupertinoIcons.book_fill,
        const Color(0xFF34495E),
        gradientColors: [Color(0xFF34495E), Color(0xFF2C3E50)],
        count: 0,  // Adding count
      ),
    ];
  }
}

class DhashboardItemsModel {
  String name;
  IconData? image;
  Color color;
  List<Color>? gradientColors;
  int count; // Added count property for displaying count below the name

  DhashboardItemsModel(
      this.name,
      this.image,
      this.color, {
        this.gradientColors,
        required this.count,  // Make sure count is passed
      });
}