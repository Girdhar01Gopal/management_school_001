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

class

LogInPageController extends GetxController {
  final scrollController = ScrollController();
  RxDouble offset = 0.0.obs;
  var isBaseUrl = false.obs;
  var isGetBaseUrl = false.obs;
  var schoolDetail = SchoolDetailModel().obs;
  var getSchoolDetail = GetSchoolDetailModel().obs;
  final isLoading = false.obs;
  final rxRequestStatus = Status.Loading.obs;

  void setError(String _value) => error.value = _value;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  RxString error = "".obs;
  RxBool isSelected = false.obs;
  RxBool isChecked = false.obs;
  RxString login = ''.obs;
  RxString password = ''.obs;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  RxBool loading = false.obs;
  TextEditingController userNamecontroller = TextEditingController(text: "MSPSP295938634" ); //EDUP27779
  TextEditingController userPasswordcontroller = TextEditingController(text: "MSPS@123"); //EDU@123
  TextEditingController schoolIdController = TextEditingController(text: "MSPSFBD8"); //EDVAUP01
  var baseUrl = "".obs;
  var secUrl = "".obs;
  var schoolemail = "".obs;
  var schoolphone = "".obs;
  var schoolImage = "".obs;
  var schoolname = "".obs;
  final RxBool isObscure = true.obs;
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);

    isLoading.value = true;
  }
  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<int?> getBaseUrl({String? schoolId}) async {
    if (kDebugMode) {
      print('get school details for $schoolId');
    }
    try {
      if (schoolId!.length == 8) {
        var url =
            "http://scherplst.eduagentapp.com/api/FMSCoreApi/GetSchoolById/$schoolId";
        var res = await http.get(Uri.parse(url));
        var data = jsonDecode(res.body);
        if (data['message'] == 'Data found') {
          schoolDetail.value = SchoolDetailModel.fromJson(data["data"][0]);
          PrefManager().setSchool(schoolDetailModel: schoolDetail.value);
          if (schoolDetail.value.applicationURL != null) {
            await PrefManager().writeValue(
                key: PrefConst.getBaseUrl,
                value: schoolDetail.value.applicationURL.toString());
            var a = await PrefManager().readValue(
              key: PrefConst.getBaseUrl,
            );

            try {
              if (schoolId.length >= 3) {
                var url1 = "$a/Api/FMSCoreApi/ViewUrldetails/$schoolId";
                var res1 = await http.get(Uri.parse(url1));
                var data1 = jsonDecode(res1.body);
                if (data1['message'] == 'Data found') {
                  ShortMessage.toast(title: "School Id Matched");
                  getSchoolDetail.value =
                      GetSchoolDetailModel.fromJson(data1["data"][0]);
                  PrefManager()
                      .setSchool(schoolDetailModel: schoolDetail.value);
                  if (getSchoolDetail.value.applicationURL != null) {
                    await PrefManager().writeValue(
                      key: PrefConst.baseUrlLocalSaved,
                      value: getSchoolDetail.value.appurl.toString(),
                    );
                    await PrefManager().writeValue(
                      key: PrefConst.secUrlLocalSaved,
                      value: getSchoolDetail.value.applicationURL.toString(),
                    );
                    baseUrl.value = await PrefManager().readValue(
                      key: PrefConst.baseUrlLocalSaved,
                    );
                    secUrl.value = await PrefManager().readValue(
                      key: PrefConst.secUrlLocalSaved,
                    );
                    await PrefManager().writeValue(
                      key: PrefConst.schoolphone,
                      value: getSchoolDetail.value.phoneNumber1.toString(),
                    );
                     await PrefManager().writeValue(
                      key: PrefConst.fatherName,
                      value: getSchoolDetail.value.phoneNumber1.toString(),
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
                    schoolImage.value = await PrefManager().readValue(
                      key: PrefConst.schoolImage,
                    );
                    schoolemail.value = await PrefManager().readValue(
                      key: PrefConst.schoolemail,
                    );
                    schoolname.value = await PrefManager().readValue(
                      key: PrefConst.schoolname,
                    );
                    schoolphone.value = await PrefManager().readValue(
                      key: PrefConst.schoolphone,
                    );
                    if (kDebugMode) {
                      print("b read value ${baseUrl.value} ");
                      print("b read value ${secUrl.value} ");
                      print("b read value ${schoolImage.value} ");
                      print("b read value ${schoolemail.value} ");
                      print("b read value ${schoolname.value} ");
                      print("b read value ${schoolphone.value} ");
                    }
                    isGetBaseUrl.value = true;
                    return 0;
                  }
                } else {
                  ShortMessage.toast(title: data1['message']);
                  PrefManager()
                      .writeValue(key: PrefConst.getBaseUrl, value: '');
                  isGetBaseUrl.value = false;
                  if (kDebugMode) {
                    print(
                        'is BaseUrl available inside else:==>${isGetBaseUrl.value}');
                  }
                  return 1;
                }
              }
            } catch (e) {
              Logger().e(e);
            }
            if (kDebugMode) {
              print("read value of base url $a");
            }
            isBaseUrl.value = true;
            return 0;
          }
        } else {
          ShortMessage.toast(title: data['message']);
          PrefManager().writeValue(key: PrefConst.getBaseUrl, value: '');
          isBaseUrl.value = false;
          if (kDebugMode) {
            print('is BaseUrl available inside else:==>${isBaseUrl.value}');
          }
          return 1;
        }
      }
    } catch (e) {
      Logger().e(e);
    }
    return 1;
  }

  void onScroll() {
    offset.value = (scrollController.hasClients) ? scrollController.offset : 0;
  }

  void radio() {
    isSelected.value = !isSelected.value;
  }
}
