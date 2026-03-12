import 'dart:convert';


import 'package:get_storage/get_storage.dart';
import 'package:management_school/local_storage/pref_const.dart';

import '../models/attendence_calender_model.dart';
import '../models/attendence_model.dart';
import '../models/attendence_summary_model.dart';
import '../models/birthdaycardmodel.dart';
import '../models/duefees_model.dart';
import '../models/fees_model.dart';
import '../models/holiday_model.dart';
import '../models/homework_model.dart';
import '../models/notes_model.dart';
import '../models/notification_class_view_model.dart';
import '../models/photo_gallery_model.dart';
import '../models/school_detail_model.dart';
import '../models/syllabus_model.dart';
import '../models/teache_model.dart';
import '../models/timetable_model.dart';
import '../models/view_enquiry_model.dart';
import '../models/view_student_model.dart';

class PrefManager {
  late GetStorage _getStorage;
  initlizedStorage() {
    _getStorage = GetStorage();
  }

  Future<void> writeValue({required String key, required dynamic value}) async {
    await GetStorage().write(key, value);
  }

 /* Future<void> setUserData({required Student userData}) async {
    await GetStorage().write(
      PrefConst.userDetails,
      userData,
    );
    getUserDetails();
  }*/

  Future<void> setUserData({required Student userData}) async {
    await GetStorage().write(
      PrefConst.userDetails,
      userData.toJson(), // Convert Student object to JSON
    );
    getUserDetails();
  }

  Future<void> setSchool(
      {required SchoolDetailModel schoolDetailModel}) async {
    await GetStorage().write(
      PrefConst.schoolDetail,
      jsonEncode(schoolDetailModel),
    );
    getUserDetails();
  }

  Future<void> setNotes({required NotesModel notesData}) async {
    await GetStorage().write(
      PrefConst.notes,
      jsonEncode(notesData),
    );
    getnotes();
  }

  Future<void> setNotification(
      {required NotificationClassViewModel notificationData}) async {
    await GetStorage().write(
      PrefConst.notification,
      jsonEncode(notificationData),
    );
    getnotification();
  }

  Future<void> setHomework({required HomeworkModel homeworkData}) async {
    await GetStorage().write(
      PrefConst.homework,
      jsonEncode(homeworkData),
    );
    gethomework();
  }

  Future<void> setTimeTable({required TimeTableModel timetableData}) async {
    await GetStorage().write(
      PrefConst.timetable,
      jsonEncode(timetableData),
    );
    gettimetable();
  }

  Future<void> setSyllabus({required SyllabusModel syllabusData}) async {
    await GetStorage().write(
      PrefConst.syllabus,
      jsonEncode(syllabusData),
    );
    getsyllabus();
  }

  Future<void> setAttendence(
      {required AttendenceModelClass attendenceData}) async {
    await GetStorage().write(
      PrefConst.attendence,
      jsonEncode(attendenceData),
    );
    getattendence();
  }

  Future<void> setAttendenceCalender(
      {required AttendanceCalenderModel attendencecalenderData}) async {
    await GetStorage().write(
      PrefConst.attendencecalender,
      jsonEncode(attendencecalenderData),
    );
    getattendence();
  }

  Future<void> setHolidayCalender(
      {required HolidayModelClass holidaycalenderData}) async {
    await GetStorage().write(
      PrefConst.holidaycalender,
      jsonEncode(holidaycalenderData),
    );
    getholidayCalender();
  }

  Future<void> setAttendenceSummary(
      {required AttendanceSummaryModel attendencesummaryData}) async {
    await GetStorage().write(
      PrefConst.attendencesummary,
      jsonEncode(attendencesummaryData),
    );
    getattendence();
  }

  Future<void> setEnquiry({required ViewEnquiryModel enquiryData}) async {
    await GetStorage().write(
      PrefConst.enquiry,
      jsonEncode(enquiryData),
    );
    getenquiry();
  }

  Future<void> setFees({required FeesModelClass feeData}) async {
    await GetStorage().write(
      PrefConst.fees,
      jsonEncode(feeData),
    );
    getfees();
  }

  Future<void> setDuefees({required DueFeesModel duefeeData}) async {
    await GetStorage().write(
      PrefConst.duefee,
      jsonEncode(duefeeData),
    );
    getduefees();
  }

  Future<void> setTeachers({required TeacherModelClass teachersData}) async {
    await GetStorage().write(
      PrefConst.teachers,
      jsonEncode(teachersData),
    );
    getteachers();
  }

  Future<void> setImage({required PhotoGalleryModel photosGalleryData}) async {
    await GetStorage().write(
      PrefConst.photos,
      jsonEncode(photosGalleryData),
    );
    getphoto();
  }

  Future<void> setphoto({required PhotoGalleryModel photoData}) async {
    await GetStorage().write(
      PrefConst.photos,
      jsonEncode(photoData),
    );
    getteachers();
  }

 /* Future<dynamic> getUserDetails() async {
    final all = await GetStorage().read(
      PrefConst.userDetails,
    );
    return all;
  }*/

  Future<Student?> getUserDetails() async {
    final jsonData = GetStorage().read(PrefConst.userDetails);
    if (jsonData != null) {
      return Student.fromJson(jsonData);
    }
    return null;
  }
  Future<dynamic> getphoto() async {
    final all = await GetStorage().read(
      PrefConst.photos,
    );
    return all;
  }

  Future<dynamic> getnotification() async {
    final all = await GetStorage().read(
      PrefConst.notification,
    );
    return all;
  }

  Future<dynamic> gethomework() async {
    final all = await GetStorage().read(
      PrefConst.homework,
    );
    return all;
  }

  Future<dynamic> gettimetable() async {
    final all = await GetStorage().read(
      PrefConst.timetable,
    );
    return all;
  }

  Future<dynamic> getsyllabus() async {
    final all = await GetStorage().read(
      PrefConst.syllabus,
    );
    return all;
  }

  Future<dynamic> getattendence() async {
    final all = await GetStorage().read(
      PrefConst.attendence,
    );
    return all;
  }

  Future<dynamic> getattendencesummary() async {
    final all = await GetStorage().read(
      PrefConst.attendencesummary,
    );
    return all;
  }

  Future<dynamic> getattendenceCalender() async {
    final all = await GetStorage().read(
      PrefConst.attendencecalender,
    );
    return all;
  }

  Future<dynamic> getholidayCalender() async {
    final all = await GetStorage().read(
      PrefConst.holidaycalender,
    );
    return all;
  }

  Future<dynamic> getfees() async {
    final all = await GetStorage().read(
      PrefConst.fees,
    );
    return all;
  }

  Future<dynamic> getduefees() async {
    final all = await GetStorage().read(
      PrefConst.duefee,
    );
    return all;
  }

  Future<dynamic> getenquiry() async {
    final all = await GetStorage().read(
      PrefConst.enquiry,
    );
    return all;
  }

  Future<dynamic> getteachers() async {
    final all = await GetStorage().read(
      PrefConst.teachers,
    );
    return all;
  }

  Future<dynamic> getnotes() async {
    final all = await GetStorage().read(
      PrefConst.notes,
    );
    return all;
  }

  Future<dynamic>? readValue({required String key}) async {
    final all = await GetStorage().read(key);
    return all;
  }

  Future<void> clearPref() async {
    await GetStorage().erase();
  }
}
