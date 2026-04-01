import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../models/notification_model.dart';
import '../models/session_model.dart';

class NotificationDashboardController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxString schoolName = "".obs;
  RxString session = "".obs;
  RxString schoolId = "".obs;
  RxString userName = "".obs;

  RxString schoolLogo = "".obs;
  RxString secUrl = "".obs;

  RxList<NotificationItem> notificationList = <NotificationItem>[].obs;
  RxList<NotificationItem> filteredNotificationList = <NotificationItem>[].obs;

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
    await fetchNotifications();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
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

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      if (secUrl.value.isEmpty) {
        errorMessage.value = "Base URL not found";
        notificationList.clear();
        filteredNotificationList.clear();
        return;
      }

      if (secUrl.value.isNotEmpty && !secUrl.value.endsWith('/')) {
        secUrl.value = "${secUrl.value}/";
      }

      if (schoolId.value.isEmpty) {
        errorMessage.value = "School ID not found";
        notificationList.clear();
        filteredNotificationList.clear();
        return;
      }

      if (session.value.isEmpty) {
        errorMessage.value = "Session not found";
        notificationList.clear();
        filteredNotificationList.clear();
        return;
      }

      final String url =
          "${secUrl.value}api/FMSCoreApi/NotificationDashboard/${session.value}/${schoolId.value}";

      debugPrint("Notification API URL => $url");

      final response = await http.get(Uri.parse(url));

      debugPrint("Notification response code => ${response.statusCode}");
      debugPrint("Notification response body => ${response.body}");

      if (response.statusCode == 200) {
        final model = NotificationDashboardModel.fromJson(
          jsonDecode(response.body),
        );

        if (model.data != null && model.data!.isNotEmpty) {
          notificationList.assignAll(model.data!);
          filteredNotificationList.assignAll(model.data!);
        } else {
          notificationList.clear();
          filteredNotificationList.clear();
          errorMessage.value = "No notifications found";
        }
      } else {
        notificationList.clear();
        filteredNotificationList.clear();
        errorMessage.value =
        "Failed to load notifications: ${response.statusCode}";
      }
    } catch (e) {
      notificationList.clear();
      filteredNotificationList.clear();
      errorMessage.value = "Error loading notifications: $e";
      debugPrint("Error loading notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNotifications() async {
    searchController.clear();
    isSearchVisible.value = false;
    filteredNotificationList.assignAll(notificationList);

    await fetchCurrentSession();
    await fetchNotifications();
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
      filteredNotificationList.assignAll(notificationList);
      return;
    }

    final result = notificationList.where((item) {
      final name = getSenderName(item).toLowerCase();
      final title = (item.title ?? "").toLowerCase();
      final msg = (item.message ?? "").toLowerCase();
      final rawDate = (item.createDate ?? "").toLowerCase();
      final formattedDate = formatDate(item.createDate ?? "").toLowerCase();

      return name.contains(search) ||
          title.contains(search) ||
          msg.contains(search) ||
          rawDate.contains(search) ||
          formattedDate.contains(search);
    }).toList();

    filteredNotificationList.assignAll(result);
  }

  Future<void> shareNotification(NotificationItem item) async {
    final text = buildShareText(item);
    await Share.share(text);
  }

  String buildShareText(NotificationItem item) {
    final fileUrl = getFullFileUrl(item.notificationFile ?? "");

    final buffer = StringBuffer();
    buffer.writeln("📢 Notification Details");
    buffer.writeln("");
    buffer.writeln("Title: ${(item.title ?? "").isEmpty ? "N/A" : item.title}");
    buffer.writeln("Message: ${(item.message ?? "").isEmpty ? "N/A" : item.message}");
    buffer.writeln("Date: ${formatDate(item.createDate ?? "")}");
    buffer.writeln("Session: ${(item.session ?? "").isEmpty ? "N/A" : item.session}");
    buffer.writeln("Type: ${(item.type ?? "").isEmpty ? "N/A" : item.type}");
    buffer.writeln("By: ${getSenderName(item)}");
    buffer.writeln("Class: ${getClassSection(item)}");

    if ((item.teacherReg ?? "").isNotEmpty) {
      buffer.writeln("Teacher Reg: ${item.teacherReg}");
    }

    if ((item.admissionNo ?? "").isNotEmpty) {
      buffer.writeln("Admission No: ${item.admissionNo}");
    }

    if ((item.notificationFile ?? "").isNotEmpty) {
      buffer.writeln("Attachment: $fileUrl");
    }

    return buffer.toString();
  }

  String formatDate(String value) {
    if (value.trim().isEmpty || value == "0001-01-01T00:00:00") {
      return "N/A";
    }

    try {
      final dt = DateTime.parse(value).toLocal();
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      final year = dt.year.toString();
      final hour = _formatHour(dt.hour);
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour >= 12 ? 'PM' : 'AM';

      return "$day-$month-$year $hour:$minute $period";
    } catch (e) {
      return value;
    }
  }

  String _formatHour(int hour) {
    final h = hour % 12;
    return (h == 0 ? 12 : h).toString().padLeft(2, '0');
  }

  bool isImageFile(String path) {
    final file = path.toLowerCase();
    return file.endsWith('.png') ||
        file.endsWith('.jpg') ||
        file.endsWith('.jpeg') ||
        file.endsWith('.webp');
  }

  String getFullFileUrl(String path) {
    if (path.trim().isEmpty) return '';

    final cleanPath = path.trim();

    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      return cleanPath;
    }

    if (cleanPath.startsWith('upload/')) {
      return "${secUrl.value}$cleanPath";
    }

    return "${secUrl.value}upload/Notificationimage/$cleanPath";
  }

  String getSenderName(NotificationItem item) {
    if ((item.name ?? "").isNotEmpty) return item.name!;
    if ((item.studentName ?? "").isNotEmpty) return item.studentName!;
    if ((item.createBy ?? "").isNotEmpty) return item.createBy!;
    return "Unknown";
  }

  String getClassSection(NotificationItem item) {
    if ((item.className ?? "").isNotEmpty && (item.section ?? "").isNotEmpty) {
      return "${item.className} - ${item.section}";
    }
    if ((item.classId ?? 0) != 0 && (item.sectionId ?? 0) != 0) {
      return "Class ${item.classId} / Section ${item.sectionId}";
    }
    if ((item.classId ?? 0) != 0) {
      return "Class ${item.classId}";
    }
    return "N/A";
  }
}