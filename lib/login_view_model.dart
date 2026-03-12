import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:management_school/repo/repo.dart';
import 'package:management_school/utils/utils.dart';

import 'controller/enquiry_page_controller.dart';
import 'controller/login_page_controller.dart';
import 'infrastructures/routes/page_constants.dart';
import 'local_storage/local_storage.dart';
import 'local_storage/pref_const.dart';
import 'models/birthdaycardmodel.dart';
import 'models/enquiry_post_model.dart';
import 'models/login_model.dart';
import 'models/view_student_model.dart';



class LoginViewModel with ChangeNotifier {
  final myRepo = LoginRepository();
  final enquiryRepo = EnquiryRepository();
  final controller = Get.find<LogInPageController>();

  Future<void> loginApi(dynamic data, url) async {
    controller.isLoading.value = true;
    myRepo.loginApi(data: data, baseUrl: url).then((value) async {
      var data = Login_Model.fromJson(value);
      if(data.data!.action == "0"){
        PrefManager().clearPref();
        ShortMessage.toast(title: "Cannot Login User is In-active");
        Get.offNamed(
          RouteName.login_screen,
        );
      }else {
        if (kDebugMode) {
          print(
              "data is in post method and in loign api  ${data.data!
                  .studentName} ");
        }
        ShortMessage.toast(
          title: data.message.toString(),
        );
        ///
        /*
        PrefManager().writeValue(
            key: PrefConst.profile_photo,
            value:
            "${controller.baseUrl.value}${AppUrl.profile_image_baseurl}${data
                .data!.uploadLogo1!}");
        */
        if (data.data == null) {
          ShortMessage.toast(
            title: data.message.toString(),
          );
          controller.isLoading.value = false;
        } else if (data.data != null) {
          ShortMessage.toast(
            title: data.message.toString(),
          );

          debugPrint("please proceed ! path is clear");
          PrefManager().writeValue(key: PrefConst.Session, value: data.data!.session.toString());
                    PrefManager().writeValue(key: PrefConst.fatherName, value: data.data!.fatherName.toString());
                    PrefManager().writeValue(key: PrefConst.fathenumber, value: data.data!.fMobileno.toString());

           PrefManager().writeValue(key: PrefConst.classid, value: data.data!.classId.toString());
            PrefManager().writeValue(key: PrefConst.sectionid, value: data.data!.sectionId.toString());

          await fetchStudentData();
          // Get.offAllNamed(RouteName.dashboard_screen);
          // Get.offAllNamed(RouteName.selectStudent_screen);
          controller.isLoading.value = false;

          if (kDebugMode) {
            print(" no error this side");
          }
          controller.isLoading.value = false;
        } else if (data.statuscode == 400) {
          debugPrint("chakkar hai yahi pr re ");
          ShortMessage.toast(
            title: data.message.toString(),
          );
        }

        if (kDebugMode) {
          print(" value in post method    ${value.toString()}");
        }
      }
    }).onError((error, stackTrace) {
      ShortMessage.toast(title: "Something went wrong!\n Please Try again ");
      controller.isLoading.value = false;
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  var students = <Student>[].obs;



  Future<void> fetchStudentData() async {
    try {
      // Retrieve stored values from PrefManager
      final parentID = await PrefManager().readValue(key: PrefConst.UserName);
      final pass = await PrefManager().readValue(key: PrefConst.UserPass);
      final session = await PrefManager().readValue(key: PrefConst.Session);
     final baseUrl =
      await PrefManager().readValue(key: PrefConst.baseUrlLocalSaved);

      // Construct the API URL
      final url =
          "${baseUrl}api/ParentApp/ViewStudentDetails/$parentID/$pass/$session";
      print("sibling url :${url}");
      // Make the API request
      final response = await http.get(Uri.parse(url));

      // Check if the response is successful
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final apiResponse = ApiResponse.fromJson(jsonResponse);

        // Ensure `data` is not null and update students list
        students.assignAll((apiResponse.data ?? []) as Iterable<Student>);
        PrefManager().writeValue(key: PrefConst.loginValue, value: "yes");
        // Handle single student scenario
        if (students.isNotEmpty && students.length == 1) {
          // Save student data and navigate to the dashboard
          await PrefManager().setUserData(userData: students.first);
          Get.offAllNamed(RouteName.dashboard_screen);
          PrefManager().writeValue(key: PrefConst.siblingCount, value:students.length.toString());
        }
        else{
          Get.offAllNamed(RouteName.dashboard_screen);
        }

        // Return the count of students as a string
      } else {
        // Handle non-200 status codes gracefully
        throw Exception('Failed to fetch student data: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging
      if (kDebugMode) {
        print("Error fetching student data: $e");
        print("Stack trace: $stackTrace");
      }
    } finally {
      // Ensure loading status is updated to complete

    }
  }

}

class EnquiryViewModel with ChangeNotifier {
  final enquiryRepo = EnquiryRepository();

  final controller = Get.find<EnquiryPageController>();
  Future<void> enquiryApi(dynamic data, BuildContext context, url) async {
    controller.isLoading.value = true;
    enquiryRepo.enquiryApi(data: data, baseUrl: url).then((value) async {
      var data = EnquiryPostModelClass.fromJson(value);

      if (kDebugMode) {
        print(
            "data is in post method and in enquiry api  ${data.data!.studentName} ");
      }
      ShortMessage.toast(
        title: "Enquiry Submitted Succesfully",
      );
      if (data.data == null) {
        ShortMessage.toast(
          title: "Enquiry Submitted Succesfully",
        );
        controller.isLoading.value = false;
      } else if (data.data != null) {
        ShortMessage.toast(
          title: "Enquiry Submitted Succesfully",
        );
        Get.back();
        controller.isLoading.value = false;

        debugPrint("everything is fine here ");
        if (kDebugMode) {
          print(" no error this side");
        }
        controller.isLoading.value = false;
      } else if (data.statuscode == 400) {
        debugPrint("chakkar hai yahi pr re ");
        ShortMessage.toast(
          title: data.message.toString(),
        );
      }

      if (kDebugMode) {
        print(" value in post method    ${value.toString()}");
      }
    }).onError((error, stackTrace) {
      ShortMessage.toast(title: error.toString());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
