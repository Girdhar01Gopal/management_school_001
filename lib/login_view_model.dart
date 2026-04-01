import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'controller/enquiry_page_controller.dart';
import 'controller/login_page_controller.dart';
import 'infrastructures/routes/page_constants.dart';
import 'local_storage/local_storage.dart';
import 'local_storage/pref_const.dart';
import 'models/enquiry_post_model.dart';
import 'models/login_model.dart';
import 'models/view_student_model.dart';
import 'repo/repo.dart';
import 'utils/utils.dart';

class LoginViewModel with ChangeNotifier {
  final LoginRepository myRepo = LoginRepository();
  final EnquiryRepository enquiryRepo = EnquiryRepository();
  final LogInPageController controller = Get.find<LogInPageController>();

  var students = <Student>[].obs;

  Future<void> loginApi(dynamic data, String url) async {
    controller.isLoading.value = true;

    try {
      final value = await myRepo.loginApi(data: data, baseUrl: url);
      final loginResponse = Login_Model.fromJson(value);

      if (loginResponse.data == null) {
        ShortMessage.toast(
          title: loginResponse.message?.toString() ?? "Login failed",
        );
        controller.isLoading.value = false;
        return;
      }

      if (loginResponse.data!.schoolId.toString() != "0") {
        ShortMessage.toast(title: "Login Successfully");

        controller.isLoading.value = false;

        await PrefManager().writeValue(
          key: PrefConst.islogin,
          value: "true",
        );

        await PrefManager().writeValue(
          key: PrefConst.SchoolId,
          value: loginResponse.data!.schoolId.toString(),
        );

        await PrefManager().writeValue(
          key: PrefConst.UserName,
          value: controller.userNamecontroller.text.trim(),
        );

        await PrefManager().writeValue(
          key: PrefConst.UserPass,
          value: controller.userPasswordcontroller.text.trim(),
        );

        Get.offAllNamed(
          RouteName.dashboard_screen,
          arguments: {"url": url},
        );
        return;
      }

      final username = controller.userNamecontroller.text.trim();
      final password = controller.userPasswordcontroller.text.trim();
      final schoolId = controller.schoolIdController.text.trim();

      await PrefManager().writeValue(
        key: PrefConst.UserName,
        value: username,
      );

      await PrefManager().writeValue(
        key: PrefConst.UserPass,
        value: password,
      );

      await PrefManager().writeValue(
        key: PrefConst.SchoolId,
        value: schoolId,
      );

      await PrefManager().writeValue(
        key: PrefConst.loginValue,
        value: "yes",
      );

      ShortMessage.toast(
        title: loginResponse.message?.toString() ?? "Login successful",
      );

      if (kDebugMode) {
        print("Login Success");
   
        print("SchoolId => $schoolId");
   
        print("BaseUrl => ${controller.baseUrl.value}");
      }

      await fetchStudentData();

      controller.isLoading.value = false;
      notifyListeners();
    } catch (error, stackTrace) {
      controller.isLoading.value = false;

      ShortMessage.toast(
        title: "Something went wrong! Please try again.",
      );

      if (kDebugMode) {
        print("loginApi error => $error");
        print("stackTrace => $stackTrace");
      }
    }
  }

  Future<void> fetchStudentData() async {
    try {
      final parentID =
          await PrefManager().readValue(key: PrefConst.UserName) ?? "";
      final pass =
          await PrefManager().readValue(key: PrefConst.UserPass) ?? "";
      final session =
          await PrefManager().readValue(key: PrefConst.Session) ?? "";
      final baseUrl =
          await PrefManager().readValue(key: PrefConst.baseUrlLocalSaved) ?? "";

      if (parentID.isEmpty ||
          pass.isEmpty ||
          session.isEmpty ||
          baseUrl.isEmpty) {
        ShortMessage.toast(title: "Login data missing");
        return;
      }

      final url =
          "${baseUrl}api/ParentApp/ViewStudentDetails/$parentID/$pass/$session";

      if (kDebugMode) {
        print("Student details URL => $url");
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final apiResponse = ApiResponse.fromJson(jsonResponse);

        students.assignAll(apiResponse.data ?? []);

        await PrefManager().writeValue(
          key: PrefConst.siblingCount,
          value: students.length.toString(),
        );

        if (students.isNotEmpty && students.length == 1) {
          await PrefManager().setUserData(userData: students.first);
        }

        Get.offAllNamed(RouteName.dashboard_screen);
      } else {
        throw Exception(
          'Failed to fetch student data: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("fetchStudentData error => $e");
        print("stackTrace => $stackTrace");
      }
      ShortMessage.toast(title: "Unable to load student data");
    }
  }
}

class EnquiryViewModel with ChangeNotifier {
  final EnquiryRepository enquiryRepo = EnquiryRepository();
  final EnquiryPageController controller = Get.find<EnquiryPageController>();

  Future<void> enquiryApi(dynamic data, BuildContext context, String url) async {
    controller.isLoading.value = true;

    try {
      final value = await enquiryRepo.enquiryApi(data: data, baseUrl: url);
      final response = EnquiryPostModelClass.fromJson(value);

      ShortMessage.toast(title: "Enquiry Submitted Successfully");

      if (response.data != null) {
        Get.back();
      }

      controller.isLoading.value = false;
      notifyListeners();
    } catch (error) {
      controller.isLoading.value = false;
      ShortMessage.toast(title: error.toString());

      if (kDebugMode) {
        print(error.toString());
      }
    }
  }
}