import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../data/response/status.dart';
import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../models/get_school_detail_model.dart';
import '../models/school_detail_model.dart';
import '../utils/utils.dart';

class LogInPageController extends GetxController {
  final scrollController = ScrollController();

  RxDouble offset = 0.0.obs;
  var isBaseUrl = false.obs;
  var isGetBaseUrl = false.obs;

  var schoolDetail = SchoolDetailModel().obs;
  var getSchoolDetail = GetSchoolDetailModel().obs;

  final isLoading = false.obs;
  final rxRequestStatus = Status.Loading.obs;

  RxString error = "".obs;
  RxBool isSelected = false.obs;
  RxBool isChecked = false.obs;
  RxString login = ''.obs;
  RxString password = ''.obs;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  RxBool loading = false.obs;

  TextEditingController userNamecontroller = TextEditingController();
  TextEditingController userPasswordcontroller = TextEditingController();
  TextEditingController schoolIdController = TextEditingController();

  var baseUrl = "".obs;
  var secUrl = "".obs;
  var schoolemail = "".obs;
  var schoolphone = "".obs;
  var schoolImage = "".obs;
  var schoolname = "".obs;

  final RxBool isObscure = true.obs;

  void setError(String value) => error.value = value;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);
    isLoading.value = false;
  }

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  @override
  void onClose() {
    scrollController.dispose();
    userNamecontroller.dispose();
    userPasswordcontroller.dispose();
    schoolIdController.dispose();
    super.onClose();
  }

  Future<int?> getBaseUrl({required String schoolId}) async {
    try {
      final cleanSchoolId = schoolId.trim().replaceAll(" ", "");

      if (cleanSchoolId.length != 8) {
        isBaseUrl.value = false;
        isGetBaseUrl.value = false;
        return 1;
      }

      if (kDebugMode) {
        print('Fetching school details for $cleanSchoolId');
      }

      final url =
          "http://scherplst.eduagentapp.com/api/FMSCoreApi/GetSchoolById/$cleanSchoolId";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode != 200) {
        ShortMessage.toast(title: "Unable to fetch school details");
        return 1;
      }

      final data = jsonDecode(res.body);

      if (data['message'] == 'Data found' &&
          data["data"] != null &&
          data["data"].isNotEmpty) {
        schoolDetail.value = SchoolDetailModel.fromJson(data["data"][0]);

        await PrefManager().setSchool(schoolDetailModel: schoolDetail.value);

        if (schoolDetail.value.applicationURL != null &&
            schoolDetail.value.applicationURL.toString().isNotEmpty) {
          await PrefManager().writeValue(
            key: PrefConst.getBaseUrl,
            value: schoolDetail.value.applicationURL.toString(),
          );

          final dynamicBase = await PrefManager().readValue(
            key: PrefConst.getBaseUrl,
          );

          final url1 =
              "$dynamicBase/Api/FMSCoreApi/ViewUrldetails/$cleanSchoolId";
          final res1 = await http.get(Uri.parse(url1));

          if (res1.statusCode != 200) {
            ShortMessage.toast(title: "Unable to verify school URL");
            return 1;
          }

          final data1 = jsonDecode(res1.body);

          if (data1['message'] == 'Data found' &&
              data1["data"] != null &&
              data1["data"].isNotEmpty) {
            getSchoolDetail.value =
                GetSchoolDetailModel.fromJson(data1["data"][0]);

            await PrefManager().writeValue(
              key: PrefConst.SchoolId,
              value: cleanSchoolId,
            );

            await PrefManager().writeValue(
              key: PrefConst.baseUrlLocalSaved,
              value: getSchoolDetail.value.appurl.toString(),
            );

            await PrefManager().writeValue(
              key: PrefConst.secUrlLocalSaved,
              value: getSchoolDetail.value.applicationURL.toString(),
            );

            await PrefManager().writeValue(
              key: PrefConst.schoolphone,
              value: getSchoolDetail.value.phoneNumber1.toString(),
            );

            await PrefManager().writeValue(
              key: PrefConst.schoolname,
              value: getSchoolDetail.value.schoolName.toString(),
            );

            await PrefManager().writeValue(
              key: PrefConst.schoolemail,
              value: getSchoolDetail.value.schoolEmailID.toString(),
            );

            await PrefManager().writeValue(
              key: PrefConst.schoolImage,
              value: getSchoolDetail.value.uploadLogo1.toString(),
            );

            baseUrl.value = await PrefManager().readValue(
              key: PrefConst.baseUrlLocalSaved,
            ) ??
                "";

            secUrl.value = await PrefManager().readValue(
              key: PrefConst.secUrlLocalSaved,
            ) ??
                "";

            schoolImage.value = await PrefManager().readValue(
              key: PrefConst.schoolImage,
            ) ??
                "";

            schoolemail.value = await PrefManager().readValue(
              key: PrefConst.schoolemail,
            ) ??
                "";

            schoolname.value = await PrefManager().readValue(
              key: PrefConst.schoolname,
            ) ??
                "";

            schoolphone.value = await PrefManager().readValue(
              key: PrefConst.schoolphone,
            ) ??
                "";

            isBaseUrl.value = true;
            isGetBaseUrl.value = true;

            ShortMessage.toast(title: "School ID Matched");

            if (kDebugMode) {
              print("baseUrl => ${baseUrl.value}");
              print("secUrl => ${secUrl.value}");
              print("schoolImage => ${schoolImage.value}");
              print("schoolname => ${schoolname.value}");
            }

            return 0;
          } else {
            await PrefManager().writeValue(
              key: PrefConst.getBaseUrl,
              value: '',
            );

            isGetBaseUrl.value = false;
            ShortMessage.toast(title: data1['message'] ?? "Invalid School ID");
            return 1;
          }
        }
      } else {
        await PrefManager().writeValue(key: PrefConst.getBaseUrl, value: '');
        isBaseUrl.value = false;
        isGetBaseUrl.value = false;
        ShortMessage.toast(title: data['message'] ?? "Invalid School ID");
        return 1;
      }
    } catch (e) {
      Logger().e(e);
      ShortMessage.toast(title: "Something went wrong");
      return 1;
    }
    return 1;
  }

  void onScroll() {
    offset.value = scrollController.hasClients ? scrollController.offset : 0;
  }

  void radio() {
    isSelected.value = !isSelected.value;
  }
}