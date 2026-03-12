import 'dart:async';
import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../data/response/status.dart';
import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../models/birthdaycardmodel.dart';
import '../models/enquiry_post_model.dart';
import '../models/enquiry_vieww_model.dart';
import '../models/view_enquiry_model.dart';
import '../models/view_student_model.dart';
import '../repo/repo.dart';
import '../utils/utils.dart';
import 'connection_controller.dart';

class EnquiryPageController extends GetxController {
  var userDetails = Student().obs;
  final _api = ViewEnquiryClassRepo();

  final isLoading = false.obs;
  RxBool isChecked1 = false.obs;
  final postEnquiryRepo = PostEnquiry();
  final postEnquiryVariable = EnquiryPostModelClass().obs;
  final postEnquiryDataList = <EnquiryPostModelClass>[].obs;
  final savedEnquiryDataList = ViewEnquiryModel().obs;

  final connectionController = Get.find<ConnectionManagerController>();
  void setDataList1(ViewEnquiryModel _value) =>
      savedEnquiryDataList.value = _value; //

  final rxRequestStatus = Status.Loading.obs;
  final enquiryDataList = ViewEnquiryModel().obs;
  RxString error = "".obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value; //
  void setDataList(ViewEnquiryModel _value) =>
      enquiryDataList.value = _value; //
  void setDataListPost(EnquiryPostModelClass _value) =>
      postEnquiryVariable.value = _value; //
  void setError(String _value) => error.value = _value; //
  RxString session = "".obs; //
  RxInt classID = 0.obs; //
  RxInt sectionID = 0.obs; //
  RxString parentId = "".obs;
  RxString type = "".obs;
  RxString schoolId = "".obs;
  RxString id = "".obs;
  RxString subject = "".obs;
  RxString teacherReg = "".obs;
  RxString studentId = "".obs;
  RxString apiDate = "".obs;
  RxString formattedDate = "".obs;
  RxString parentsID = "".obs;
  RxBool isChatLoaded = false.obs;
  var baseUrl = "".obs;
  @override
  void onInit() async {
    super.onInit();
    baseUrl.value =
        await PrefManager().readValue(key: PrefConst.baseUrlLocalSaved);
    if (kDebugMode) {
      print("object in enquiry page");
    }
    await setUserData();
    if (kDebugMode) {
      print("Data value in init ${enquiryDataList.value.data}");
    }
    if (enquiryDataList.value.data != null) {
      for (var a in enquiryDataList.value.data!) {
        if (kDebugMode) {
          print("this is also condition working");
        }
        // messageList.value.add(
        //   Message(
        //     message: a.message == null ? "" : a.message.toString(),
        //     createdAt: DateTime.parse(
        //       a.createDate == null ? "" : a.createDate.toString(),
        //     ),
        //     sendBy: a.name ?? "ffff",
        //   ),
        // );
      }
      // chatController = ChatController(
      //   initialMessageList: messageList.value,
      //   scrollController: ScrollController(),
      //   chatUsers: [
      //     ChatUser(
      //       id: '4',
      //       name: 'S. Sashmitha',
      //       profilePhoto: "",
      //     ),
      //     ChatUser(
      //       id: '3',
      //       name: 'RANJANI.S',
      //       profilePhoto: "",
      //     ),
      //   ],
      // );
      isChatLoaded.value = true;
    }
  }

  Future<void> getEnquiry() async {
    var data = await PrefManager().getenquiry();
    if (kDebugMode) {
      print("abcd notes data  ${data}");
    }
    savedEnquiryDataList.value = ViewEnquiryModel.fromJson(jsonDecode(data));
    if (kDebugMode) {
      print(" saved data ${savedEnquiryDataList.value}");
    }
  }

  Future<void> setUserData() async {
    var data = await PrefManager().getUserDetails();
    userDetails.value = data!;
    session.value = userDetails.value.session.toString();

    classID.value = int.parse(userDetails.value.classId.toString());
    sectionID.value = int.parse(userDetails.value.sectionId.toString());
    parentId.value = userDetails.value.parentId.toString();

    setRxRequestStatus(Status.Complete);
    enquiryDataList.value = await _api.viewenquiryclassview(
        baseUrl.value.toString(),
        session.value.toString(),
        classID.value.toString(),
        sectionID.value.toString(),
        parentId.value.toString());
    if (kDebugMode) {
      print("parents id ${enquiryDataList.value.data}");
    }
    dataListApi();
    final ab = await connectionController.checkConnectivity();
    if (kDebugMode) {
      print(" ab is connection ${ab}");
    }
    if (ab == true) {
      _api
          .viewenquiryclassview(
              baseUrl.value.toString(),
              session.value.toString(),
              classID.value.toString(),
              sectionID.value.toString(),
              parentId.value.toString())
          .then((value) async {
        setRxRequestStatus(Status.Complete);
        setDataList1(value);
        PrefManager().setEnquiry(enquiryData: value);
        await getEnquiry();
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print("error in notes ${error.toString()}");
        }
        setError(error.toString());
        setRxRequestStatus(Status.Error);
      });
    } else {
      setRxRequestStatus(Status.Complete);
      await getEnquiry();
    }
  }

  void dataListApi() {
    _api
        .viewenquiryclassview(
            baseUrl.value.toString(),
            session.value.toString(),
            classID.value.toString(),
            sectionID.value.toString(),
            parentId.value.toString())
        .then((value) {
      setRxRequestStatus(Status.Complete);
      setDataList(value);
      if (kDebugMode) {
        print("enquiry page controler working${value.message}");
      }
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.Error);
    });
  }

  Future<void> updateDataListApi() async {
    setRxRequestStatus(Status.Loading);

    _api
        .viewenquiryclassview(
            baseUrl.value.toString(),
            session.value.toString(),
            classID.value.toString(),
            sectionID.value.toString(),
            parentId.value.toString())
        .then((value) {
      setRxRequestStatus(Status.Complete);
      setDataList(value);
      if (kDebugMode) {
        print(" this is printing value in enquiry contoller ${value.message}");
      }
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.Error);
    });
  }

  @override
  void onReady() async {
    // TODO: implement onInit
    super.onReady();
    // studentId.value = Get.arguments[0];
    studentId.value = await PrefManager().readValue(key: PrefConst.userDetails);
    if (kDebugMode) {
      print("init printing ");
      print("student id value ${studentId.value}");
    }
    // postEnquiryVariable.value = postEnquiryDataList.first;
    enquiryDataList();
  }

  Future<void> uploadData() async {
    const apiUrl =
        'https://chetpetparenttest.mvmerp.com/api/ParentApp/EnquiryPost';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "ParentID": parentId.value.toString(),
          "Subject": detailsubjectTextcontroller.value.text.toString(),
          'Message': detailTextcontroller.value.text.toString(),
        }),
      );
      var data = EnquiryPostModel.fromJson(response as Map<String, dynamic>);
      if (response.statusCode == 200) {
        ShortMessage.toast(title: "Submit succesfully");
        if (kDebugMode) {
          print(" abcdefgh  ${response.body}");
        }
      } else {
        ShortMessage.toast(title: "Upload Failed");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> dataListApipost() async {
    postEnquiryDataList.value = await postEnquiryRepo.grievance(
      baseUrl.value.toString(),
    );
    if (kDebugMode) {
      print(" dfdfdfd ${postEnquiryDataList.value}  ");
    }
    // .then((value) {
    setRxRequestStatus(Status.Complete);
    // final keysToSave = ;
    // print(" this is printing value in grievance contoller ${value}");

    // }).onError((error, stackTrace) {
    //   setError(error.toString());
    //   setRxRequestStatus(Status.Error);
    // });
  }

  void updateDataListApipost() {
    setRxRequestStatus(Status.Loading);

    postEnquiryRepo
        .grievance(
      baseUrl.value.toString(),
    )
        .then((value) {
      setRxRequestStatus(Status.Complete);
      // setDataList(value);
      if (kDebugMode) {
        print(
            " this is printing value in  grievance timetable contoller ${value}");
      }
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.Error);
    });
  }

  TextEditingController detailTextcontroller = TextEditingController();
  TextEditingController detailsubjectTextcontroller = TextEditingController();
  var replyId = 0.obs;
  var p_id = 0.obs;
  var teacher_reg = "".obs;

  Rx<DateTime> selectedFromDate = DateTime.now().obs;
  Rx<DateTime> selectedToDate = DateTime.now().obs;
  RxString formattedFromDate = ''.obs;
  RxString formattedToDate = ''.obs;

  Future<void> selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate.value,
      currentDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
    );

    if (picked != null && picked != selectedFromDate.value) {
      selectedFromDate.value = picked;
      formattedFromDate.value =
          DateFormat('MM-dd-yyyy').format(selectedFromDate.value);
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate.value,
      currentDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
    );

    if (picked != null && picked != selectedToDate.value) {
      selectedToDate.value = picked;
      formattedToDate.value =
          DateFormat('MM-dd-yyyy').format(selectedToDate.value);
    }
  }
}
