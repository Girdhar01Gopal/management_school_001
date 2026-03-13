import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../utils/utils.dart';

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

  DashboardItemModel copyWith({
    String? name,
    IconData? image,
    Color? color,
    String? count,
    List<Color>? gradientColors,
  }) {
    return DashboardItemModel(
      name: name ?? this.name,
      image: image ?? this.image,
      color: color ?? this.color,
      count: count ?? this.count,
      gradientColors: gradientColors ?? this.gradientColors,
    );
  }
}

class DashboardScreenController extends GetxController {
  final ScrollController scrollController = ScrollController();

  RxBool isLoading = false.obs;
  RxBool isCountLoading = false.obs;
  RxDouble offset = 0.0.obs;

  RxString errorMessage = ''.obs;
  RxString totalCountError = ''.obs;

  RxString baseUrl = ''.obs;
  RxString secUrl = ''.obs;
  RxString session = ''.obs;
  RxString schoolId = ''.obs;
  RxString classId = ''.obs;
  RxString sectionId = ''.obs;
  RxString userName = ''.obs;
  RxString userPass = ''.obs;

  RxString fatherName = ''.obs;
  RxString fatherMobile = ''.obs;

  RxString schoolName = ''.obs;
  RxString schoolImage = ''.obs;
  RxString schoolPhone = ''.obs;
  RxString schoolEmail = ''.obs;

  RxString siblingCount = '0'.obs;
  RxString loginValue = ''.obs;

  RxMap<String, dynamic> totalCountData = <String, dynamic>{}.obs;

  /// Summary cards values
  RxString totalStudentCount = '0'.obs;
  RxString feeDueInMarch = '0'.obs;
  RxString totalTeacherCount = '0'.obs;
  RxString todayCollection = '0'.obs;
  RxString monthlyCollection = '0'.obs;
  RxString totalStaffCount = '0'.obs;
  RxString sessionCollection = '0'.obs;
  RxString sessionDue = '0'.obs;

  /// Grid items
  RxList<DashboardItemModel> filteredList = <DashboardItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      await loadDashboardSessionData();
      await getTotalCount();
      buildDashboardItems();
    } catch (e) {
      errorMessage.value = "Unable to load dashboard data";
      if (kDebugMode) {
        print("fetchDashboardData error => $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadDashboardSessionData() async {
    try {
      baseUrl.value =
          await PrefManager().readValue(key: PrefConst.baseUrlLocalSaved) ?? '';

      secUrl.value =
          await PrefManager().readValue(key: PrefConst.secUrlLocalSaved) ?? '';

      session.value =
          await PrefManager().readValue(key: PrefConst.Session) ?? '';

      /// YAHAN YE FIX HAI
      schoolId.value =
          await PrefManager().readValue(key: PrefConst.SchoolId) ?? '';

      classId.value =
          await PrefManager().readValue(key: PrefConst.classid) ?? '';

      sectionId.value =
          await PrefManager().readValue(key: PrefConst.sectionid) ?? '';

      userName.value =
          await PrefManager().readValue(key: PrefConst.UserName) ?? '';

      userPass.value =
          await PrefManager().readValue(key: PrefConst.UserPass) ?? '';

      fatherName.value =
          await PrefManager().readValue(key: PrefConst.fatherName) ?? '';

      fatherMobile.value =
          await PrefManager().readValue(key: PrefConst.fathenumber) ?? '';

      schoolName.value =
          await PrefManager().readValue(key: PrefConst.schoolname) ?? '';

      schoolImage.value =
          await PrefManager().readValue(key: PrefConst.schoolImage) ?? '';

      schoolPhone.value =
          await PrefManager().readValue(key: PrefConst.schoolphone) ?? '';

      schoolEmail.value =
          await PrefManager().readValue(key: PrefConst.schoolemail) ?? '';

      siblingCount.value =
          await PrefManager().readValue(key: PrefConst.siblingCount) ?? '0';

      loginValue.value =
          await PrefManager().readValue(key: PrefConst.loginValue) ?? '';

      if (kDebugMode) {
        print("===== DASHBOARD LOGIN DATA =====");
        print("baseUrl => ${baseUrl.value}");
        print("session => ${session.value}");
        print("schoolId => ${schoolId.value}");
        print("userName => ${userName.value}");
        print("schoolName => ${schoolName.value}");
        print("================================");
      }
    } catch (e) {
      if (kDebugMode) {
        print("loadDashboardSessionData error => $e");
      }
      rethrow;
    }
  }

  Future<void> getTotalCount() async {
    try {
      isCountLoading.value = true;
      totalCountError.value = '';

      if (baseUrl.value.isEmpty) {
        totalCountError.value = "Base URL missing";
        errorMessage.value = totalCountError.value;
        return;
      }

      if (session.value.isEmpty) {
        totalCountError.value = "Session missing";
        errorMessage.value = totalCountError.value;
        return;
      }

      if (schoolId.value.isEmpty) {
        totalCountError.value = "School ID missing";
        errorMessage.value = totalCountError.value;
        return;
      }

      final String url =
          "${baseUrl.value}api/FMSCoreApi/GetTotalCount/${session.value}/${schoolId.value}";

      if (kDebugMode) {
        print("GetTotalCount URL => $url");
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is Map<String, dynamic>) {
          totalCountData.value = jsonResponse;
        } else {
          totalCountData.value = {"data": jsonResponse};
        }

        if (kDebugMode) {
          print("GetTotalCount response => $jsonResponse");
        }

        mapApiDataToCards();
      } else {
        totalCountError.value = "Failed to load count: ${response.statusCode}";
        errorMessage.value = totalCountError.value;
        ShortMessage.toast(title: totalCountError.value);
      }
    } catch (e) {
      totalCountError.value = "Unable to load total count";
      errorMessage.value = totalCountError.value;
      if (kDebugMode) {
        print("getTotalCount error => $e");
      }
      ShortMessage.toast(title: totalCountError.value);
    } finally {
      isCountLoading.value = false;
    }
  }

  void mapApiDataToCards() {
    try {
      dynamic item;

      if (totalCountData["data"] is List &&
          (totalCountData["data"] as List).isNotEmpty) {
        item = totalCountData["data"][0];
      } else if (totalCountData["data"] is Map<String, dynamic>) {
        item = totalCountData["data"];
      } else {
        item = totalCountData;
      }

      if (item == null || item is! Map<String, dynamic>) {
        return;
      }

      /// API field names alag ho sakte hain.
      /// Isliye multiple possible keys use ki hain.
      totalStudentCount.value = _readAny(item, [
        "TotalStudent",
        "TotalStudents",
        "StudentCount",
        "totalStudent",
        "totalStudents",
      ]);

      feeDueInMarch.value = _readAny(item, [
        "FeeDueInMarch",
        "FeesDueInMarch",
        "MarchDue",
        "DueInMarch",
        "feeDueInMarch",
      ]);

      totalTeacherCount.value = _readAny(item, [
        "TotalTeacher",
        "TotalTeachers",
        "TeacherCount",
        "teacherCount",
      ]);

      todayCollection.value = _readAny(item, [
        "TodayCollection",
        "TodaysCollection",
        "TodayFeeCollection",
        "todayCollection",
      ]);

      monthlyCollection.value = _readAny(item, [
        "MonthlyCollection",
        "MonthCollection",
        "CurrentMonthCollection",
        "monthlyCollection",
      ]);

      totalStaffCount.value = _readAny(item, [
        "TotalStaff",
        "TotalStaffs",
        "StaffCount",
        "staffCount",
      ]);

      sessionCollection.value = _readAny(item, [
        "SessionCollection",
        "TotalSessionCollection",
        "sessionCollection",
      ]);

      sessionDue.value = _readAny(item, [
        "SessionDue",
        "TotalSessionDue",
        "sessionDue",
      ]);

      if (kDebugMode) {
        print("===== CARD VALUES =====");
        print("totalStudentCount => ${totalStudentCount.value}");
        print("feeDueInMarch => ${feeDueInMarch.value}");
        print("totalTeacherCount => ${totalTeacherCount.value}");
        print("todayCollection => ${todayCollection.value}");
        print("monthlyCollection => ${monthlyCollection.value}");
        print("totalStaffCount => ${totalStaffCount.value}");
        print("sessionCollection => ${sessionCollection.value}");
        print("sessionDue => ${sessionDue.value}");
        print("=======================");
      }
    } catch (e) {
      if (kDebugMode) {
        print("mapApiDataToCards error => $e");
      }
    }
  }

  String _readAny(Map<String, dynamic> json, List<String> possibleKeys) {
    for (final key in possibleKeys) {
      if (json.containsKey(key) && json[key] != null) {
        return json[key].toString();
      }
    }
    return '0';
  }

  void buildDashboardItems() {
    filteredList.value = [
      DashboardItemModel(
        name: "Total Students",
        image: Icons.school_rounded,
        color: const Color(0xFF6F42C1),
        count: totalStudentCount.value,
        gradientColors: const [
          Color(0xFF7E57C2),
          Color(0xFF5E35B1),
        ],
      ),
      DashboardItemModel(
        name: "Fee Due in March",
        image: Icons.calendar_month_rounded,
        color: const Color(0xFFF57C00),
        count: feeDueInMarch.value,
        gradientColors: const [
          Color(0xFFFFB74D),
          Color(0xFFF57C00),
        ],
      ),
      DashboardItemModel(
        name: "Total Teacher",
        image: Icons.person_rounded,
        color: const Color(0xFF1E88E5),
        count: totalTeacherCount.value,
        gradientColors: const [
          Color(0xFF42A5F5),
          Color(0xFF1565C0),
        ],
      ),
      DashboardItemModel(
        name: "Today Collection",
        image: Icons.today_rounded,
        color: const Color(0xFF00897B),
        count: todayCollection.value,
        gradientColors: const [
          Color(0xFF26A69A),
          Color(0xFF00796B),
        ],
      ),
      DashboardItemModel(
        name: "Monthly Collection",
        image: Icons.bar_chart_rounded,
        color: const Color(0xFF43A047),
        count: monthlyCollection.value,
        gradientColors: const [
          Color(0xFF66BB6A),
          Color(0xFF2E7D32),
        ],
      ),
      DashboardItemModel(
        name: "Fees Staff",
        image: Icons.people_alt_rounded,
        color: const Color(0xFFE53935),
        count: totalStaffCount.value,
        gradientColors: const [
          Color(0xFFEF5350),
          Color(0xFFC62828),
        ],
      ),
      DashboardItemModel(
        name: "Session Collection",
        image: Icons.account_balance_wallet_rounded,
        color: const Color(0xFF3949AB),
        count: sessionCollection.value,
        gradientColors: const [
          Color(0xFF5C6BC0),
          Color(0xFF283593),
        ],
      ),
      DashboardItemModel(
        name: "Session Due",
        image: Icons.pending_actions_rounded,
        color: const Color(0xFFD81B60),
        count: sessionDue.value,
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

  bool get isLoginDataReady {
    return baseUrl.value.isNotEmpty &&
        session.value.isNotEmpty &&
        schoolId.value.isNotEmpty;
  }

  void onSelectedBottom(int index) {
    if (index < 0 || index >= filteredList.length) return;

    final selectedItem = filteredList[index];

    if (kDebugMode) {
      print("Selected Dashboard Item => ${selectedItem.name}");
    }

    /// Yahan apne routes/navigation lagao
    switch (selectedItem.name) {
      case "Total Students":
      // Get.toNamed(RouteName.totalStudentsScreen);
        break;
      case "Fee Due in March":
      // Get.toNamed(RouteName.feeDueScreen);
        break;
      case "Total Teacher":
      // Get.toNamed(RouteName.teacherScreen);
        break;
      case "Today Collection":
      // Get.toNamed(RouteName.todayCollectionScreen);
        break;
      case "Monthly Collection":
      // Get.toNamed(RouteName.monthlyCollectionScreen);
        break;
      case "Fees Staff":
      // Get.toNamed(RouteName.staffScreen);
        break;
      case "Session Collection":
      // Get.toNamed(RouteName.sessionCollectionScreen);
        break;
      case "Session Due":
      // Get.toNamed(RouteName.sessionDueScreen);
        break;
      default:
        break;
    }
  }

  void _onScroll() {
    offset.value = scrollController.hasClients ? scrollController.offset : 0.0;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}