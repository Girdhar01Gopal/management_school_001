import 'dart:convert';
import 'dart:core';


import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

import '../data/network/base_api_response.dart';
import '../data/network/network_api_response.dart';
import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../models/adacmiccalender.dart';
import '../models/attendence_calender_model.dart';
import '../models/attendence_model.dart';
import '../models/attendence_summary_model.dart';
import '../models/birthdaycardmodel.dart';
import '../models/duefees_model.dart';
import '../models/enquiry_post_model.dart';
import '../models/fees_model.dart';
import '../models/holiday_model.dart';
import '../models/homework_model.dart';
import '../models/image_model.dart';
import '../models/notes_model.dart';
import '../models/notification_class_view_model.dart';
import '../models/photo_gallery_model.dart';
import '../models/syllabus_model.dart';
import '../models/teache_model.dart';
import '../models/timetable_model.dart';
import '../models/video_gallery_model.dart';
import '../models/view_enquiry_model.dart';
import 'app_url.dart';


class LoginRepository {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<dynamic> loginApi({
    required var data,
    required var baseUrl,
  }) async {
    try {
      dynamic response =
          await _apiServices.postApi(data, "$baseUrl${AppUrl.loginUrl}", '');
      if (kDebugMode) {
        print(" ye too response hai bhai   ${response}");
        print(" api  $baseUrl${AppUrl.loginUrl}");
      }
      return response;
    } catch (e) {
      throw FormatException("Exception error in login repo  ${e.toString}");
    }
  }
}

class EnquiryRepository {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<dynamic> enquiryApi({
    required var data,
    required var baseUrl,
  }) async {
    try {
      dynamic response = await _apiServices.postApi(
        data,
        "$baseUrl${AppUrl.postenquiryUrl}",
        '',
      );
      if (kDebugMode) {
        print(" ye too response hai bhai   ${response}");
      }
      return response;
    } catch (e) {
      throw FormatException("Exception error in enquiry repo  ${e.toString}");
    }
  }
}

class HomeworkRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<HomeworkModel> homework(
    String baseURl,
    String session,
    String classID,
    String sectionID,
  ) async {
    try {
      dynamic response = await _apiServices
          .getApi("$baseURl${AppUrl.homeworkUrl}$session/$classID/$sectionID");
      if (kDebugMode) {
        print(
            " api data fee payment details   ${AppUrl.homeworkUrl}$session/$classID/$sectionID");
        print(
            " Homework api parsed data from model in get api   ${HomeworkModel.fromJson(response)}");
      }
      return HomeworkModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("this is error $e");
      }
      throw FormatException("Exception error in Homework repo  ${e.toString}");
    }
  }
}

// class SearchHOmeworkRepo {
//   BaseApiServices _apiServices = NetworkApiServices();
//   Future<AttendanceModel> attandence(
//       String registrationNo,
//       String startDate,
//       String endDate,
//       String session,
//       String schoolId,
//       String classIde,
//       String sectionIde,

//       ) async {
//     try {
//       dynamic response =
//       await _apiServices.getApi("${AppUrl.homeworksearchUrl}$registrationNo/$startDate/$endDate/$session/$schoolId/$classIde/$sectionIde");
//       print(
//           " attandence api detail  ${AppUrl.homeworksearchUrl}$registrationNo/$startDate/$endDate/$session/$schoolId/$classIde/$sectionIde");
//       print(
//           "   attandence api parsed data from model in get api   ${AttendanceModel.fromJson(response)}");
//       return AttendanceModel.fromJson(response);
//     } catch (e) {
//       print("this is error $e");
//       throw e;
//     }
//   }
// }

class NotesRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<NotesModel> notes(
    String baseURl,
    String session,
    String classID,
    String sectionID,
  ) async {
    try {
      dynamic response = await _apiServices
          .getApi("$baseURl${AppUrl.notesUrl}$session/$classID/$sectionID");
      if (kDebugMode) {
        print(
            " api data fee payment details   ${AppUrl.notesUrl}$session/$classID/$sectionID");
        print(
            " notes api parsed data from model in get api   ${NotesModel.fromJson(response)}");
      }
      return NotesModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("this is error $e");
      }
      throw FormatException("Exception error in notes repo  ${e.toString}");
    }
  }
}

class SyllabsuRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<SyllabusModel> syllabus(
    String baseURl,
    String session,
    String classID,
    String sectionID,
  ) async {
    try {
      dynamic response = await _apiServices
          .getApi("$baseURl${AppUrl.syllabusUrl}$session/$classID/$sectionID");
      if (kDebugMode) {
        print(
            " api data syllabus payment details   ${AppUrl.syllabusUrl}$session/$classID/$sectionID");
        print(
            " syllabus api parsed data from model in get api   ${SyllabusModel.fromJson(response)}");
      }
      return SyllabusModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("this is error $e");
      }
      throw FormatException("Exception error in syllabus repo  ${e.toString}");
    }
  }
}

class NotifiactionClassRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<NotificationClassViewModel> notificationclassview(
    String baseURl,
    String session,
    String schoolId,
    String classID,
    String sectionID,
  ) async {
    try {
      print("section id${sectionID}");
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.classtypeviewnotificationUrl}$session/$sectionID/$schoolId/$classID");
      if (kDebugMode) {
        print(
            " notification api   ${AppUrl.classtypeviewnotificationUrl}$session/$sectionID/$schoolId/$classID");
        print(
            " notification class api parsed data from model in get api   ${NotificationClassViewModel.fromJson(response)}");
      }
      return NotificationClassViewModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" notification this is error $e");
      }
      throw FormatException(
          "Exception error in notification repo  ${e.toString}");
    }
  }
}

class TimeTableClassRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<TimeTableModel> timetablelassview(
    String baseURl,
    String session,
    String classID,
    String sectionID,
  ) async {
    try {
      dynamic response = await _apiServices
          .getApi("$baseURl${AppUrl.timetableUrl}$classID/$sectionID/$session");
      if (kDebugMode) {
        print(
            " eqwdawftufastdvusvfusvfyuvasyfvyfvsyufbyu  ${AppUrl.timetableUrl}$classID/$sectionID/$session");
        print(
            " timatableclass api parsed data from model in get api   ${TimeTableModel.fromJson(response)}");
      }
      return TimeTableModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" timetable this is error $e");
      }
      throw FormatException("Exception error in timatble repo  ${e.toString}");
    }
  }
}

class TeacherClassRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<TeacherModelClass> techerclassview(
    String baseURl,
    String classID,
    String sectionID,
  ) async {
    try {
      dynamic response = await _apiServices
          .getApi("$baseURl${AppUrl.teacherUrl}$classID/$sectionID");
      if (kDebugMode) {
        print(" techer  ${AppUrl.teacherUrl}$classID/$sectionID");
        print(
            " techer api parsed data from model in get api   ${TeacherModelClass.fromJson(response)}");
      }
      return TeacherModelClass.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" techer this is error $e");
      }
      throw FormatException("Exception error in teacher repo  ${e.toString}");
    }
  }
}

class FessClassRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<FeesModelClass> feesclassview(
    String baseURl,
    String registrationNo,
    String session,
  ) async {
    try {
      dynamic response = await _apiServices
          .getApi("$baseURl${AppUrl.feesUrl}$registrationNo/$session");
      if (kDebugMode) {
        print(" techer  ${AppUrl.feesUrl}$registrationNo/$session");
        print(
            " techer api parsed data from model in get api   ${FeesModelClass.fromJson(response)}");
      }
      return FeesModelClass.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" techer this is error $e");
      }
      throw FormatException("Exception error in fees repo  ${e.toString}");
    }
  }
}

class DueFessClassRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<DueFeesModel> duefeesclassview(
    String baseURl,
    var classid,
    var sectionid,
    String session,
    String schoolId,
    String registrationNo,
   
  ) async {
    try {
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.duefeesUrl}$classid/$sectionid/$session/$schoolId/$registrationNo");
      if (kDebugMode) {
        print(
            " duefee  $baseURl${AppUrl.duefeesUrl}$classid/$sectionid/$session/$schoolId/$registrationNo");
        print(
            " duefee api parsed data from model in get api   ${DueFeesModel.fromJson(response)}");
      }
      return DueFeesModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" duefee this is error $e");
      }
      throw FormatException("Exception error in due fees repo  ${e.toString}");
    }
  }
}

class AttendenceClassRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<AttendenceModelClass> attendenceclassview(
    String baseURl,
    String session,
    String classId,
    String sectionId,
    String registrationNo,
  ) async {
    try {
      dynamic response = await _apiServices.getApi("$baseURl${AppUrl.attendenceUrl}$session/$classId/$sectionId/$registrationNo");
      if (kDebugMode) {
        print(
            " attendence  ${AppUrl.attendenceUrl}$session/$classId/$sectionId/$registrationNo");
        print(
            " attendence api parsed data from model in get api   ${AttendenceModelClass.fromJson(response)}");
      }
      return AttendenceModelClass.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" attendence this is error $e");
      }
      throw FormatException(
          "Exception error in attendnace repo  ${e.toString}");
    }
  }
}

class AttendenceSummaryRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<AttendanceSummaryModel> attendenceSummaryview(
    String baseURl,
    String session,
    String classId,
    String sectionId,
    String registrationNo,
  ) async {
    try {
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.attandenceSummary}$session/$classId/$sectionId/$registrationNo");
      if (kDebugMode) {
        print(
            " attendence  ${AppUrl.attendenceUrl}$session/$classId/$sectionId/$registrationNo");
        print(
            " attendence api parsed data from model in get api   ${AttendanceSummaryModel.fromJson(response)}");
      }
      return AttendanceSummaryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" attendence this is error $e");
      }
      throw FormatException(
          "Exception error in attendance summary repo  ${e.toString}");
    }
  }
}

class AttendenceCalenderRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<AttendanceCalenderModel> attendenceCalenderview(
    String baseURl,
    String session,
    String classId,
    String sectionId,
    String registrationNo,
  ) async {
    try {
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.attandenceCalender}$session/$classId/$sectionId/$registrationNo");
      if (kDebugMode) {
        print(
            " attendence calender ${AppUrl.attandenceCalender}$session/$classId/$sectionId/$registrationNo");
        print(
            " attendence api parsed data from model in get api ${AttendanceCalenderModel.fromJson(response)}");
      }
      return AttendanceCalenderModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" attendence this is error $e");
      }
      throw FormatException(
          "Exception error in attendance calender repo  ${e.toString}");
    }
  }
}

class PhotoGalleryClassRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<PhotoGalleryModel> photoGalleryclassview(
    String baseURl,
    String classId,
    String sectionId,
  ) async {
    try {
      dynamic response = await _apiServices
          .getApi("$baseURl${AppUrl.photogalleryUrl}$classId/$sectionId");
      if (kDebugMode) {
        print(" photo  ${AppUrl.photogalleryUrl}$classId/$sectionId");
        print(
            " photo api parsed data from model in get api   ${PhotoGalleryModel.fromJson(response)}");
      }
      return PhotoGalleryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" photo this is error $e");
      }
      throw FormatException(
          "Exception error in photo gallery repo  ${e.toString}");
    }
  }
}

class PhotoGalleryAllRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<PhotoGalleryModel> photoGalleryallview(
    String baseURl,
    String session,
    String classId,
    String sectionId,
    String categoryName,
  ) async {
    try {
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.viewPhotoGalleryAll}$session/$classId/$sectionId/$categoryName");
      if (kDebugMode) {
        print(
            " photo all ${AppUrl.viewPhotoGalleryAll}$session/$classId/$sectionId/$categoryName");
        print(
            " photo all api parsed data from model in get api   ${PhotoGalleryModel.fromJson(response)}");
      }
      return PhotoGalleryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" photo this is error $e");
      }
      throw FormatException(
          "Exception error in photo gallery all repo  ${e.toString}");
    }
  }
}

class VideoGalleryClassRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<VideoGalleryModel> videoGalleryclassview(
    String baseURl,
    String session,
    String classId,
    String sectionId,
  ) async {
    try {
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.videogalleryUrl}$session/$classId/$sectionId");
      if (kDebugMode) {
        print(" video  ${AppUrl.videogalleryUrl}$session/$classId/$sectionId");
        print(
            " video api parsed data from model in get api   ${VideoGalleryModel.fromJson(response)}");
      }
      return VideoGalleryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" video this is error $e");
      }
      throw FormatException("Exception error in gallery repo  ${e.toString}");
    }
  }
}

class SearchTimeTableByDateRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<TimeTableModel> searchTimeTableByDate(
    String baseURl,
    String registrationNo,
    String fromDate,
    String toDate,
    String session,
    String schoolId,
    String classId,
    String sectionId,
  ) async {
    try {
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.timeTableByDateUrl}$registrationNo/$fromDate/$toDate/$session/$schoolId/$classId/$sectionId");
      if (kDebugMode) {
        print(
            "searchTimeTable api  ${AppUrl.timeTableByDateUrl}$registrationNo/$fromDate/$toDate/$session/$schoolId/$classId/$sectionId");
        print(
            " video api parsed data from model in get api   ${TimeTableModel.fromJson(response)}");
      }
      return TimeTableModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("  this is error $e");
      }
      throw FormatException(
          "Exception error in search timetable bt date repo  ${e.toString}");
    }
  }
}

class SearchHomeworkByDateRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<HomeworkModel> searchHomeworkByDate(
    String baseURl,
    String registrationNo,
    String fromDate,
    String toDate,
    String session,
    String schoolId,
    String classId,
    String sectionId,
  ) async {
    try {
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.homeWorkByDateUrl}$registrationNo/$fromDate/$toDate/$session/$schoolId/$classId/$sectionId");
      if (kDebugMode) {
        print(
            "searchHomework api  $baseURl${AppUrl.homeWorkByDateUrl}$registrationNo/$fromDate/$toDate/$session/$schoolId/$classId/$sectionId");
        print(
            " homework api parsed data from model in get api   ${HomeworkModel.fromJson(response)}");
      }
      return HomeworkModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("  this is error $e");
      }
      throw FormatException(
          "Exception error in search homework by date repo  ${e.toString}");
    }
  }
}

class SearchSyllabusByDateRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<SyllabusModel> searchSyllabusByDate(
    String baseURl,
    String registrationNo,
    String fromDate,
    String toDate,
    String session,
    String schoolId,
    String classId,
    String sectionId,
  ) async {
    try {
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.syllabusByDateUrl}$registrationNo/$fromDate/$toDate/$session/$schoolId/$classId/$sectionId");
      if (kDebugMode) {
        print(
            "searchHomework api  ${AppUrl.homeWorkByDateUrl}$registrationNo/$fromDate/$toDate/$session/$schoolId/$classId/$sectionId");
        print(
            " homework api parsed data from model in get api   ${SyllabusModel.fromJson(response)}");
      }
      return SyllabusModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("  this is error $e");
      }
      throw FormatException(
          "Exception error in search syllabus by date repo  ${e.toString}");
    }
  }
}

class SearchNotesByDateRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<NotesModel> searchNotesByDate(
    String baseURl,
    String registrationNo,
    String fromDate,
    String toDate,
    String session,
    String schoolId,
    String classId,
    String sectionId,
  ) async {
    try {
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.notesByDateUrl}$registrationNo/$fromDate/$toDate/$session/$schoolId/$classId/$sectionId");
      if (kDebugMode) {
        print(
            "searchHomework api  ${AppUrl.notesByDateUrl}$registrationNo/$fromDate/$toDate/$session/$schoolId/$classId/$sectionId");
        print(
            " homework api parsed data from model in get api   ${NotesModel.fromJson(response)}");
      }
      return NotesModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print("  this is error $e");
      }
      throw FormatException(
          "Exception error in search notes by date repo  ${e.toString}");
    }
  }
}

class ViewEnquiryClassRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<ViewEnquiryModel> viewenquiryclassview(String baseURl, String session,
      String classId, String sectionId, String parentId) async {
    try {
      dynamic response = await _apiServices.getApi(
          "$baseURl${AppUrl.viewenquiryUrl}$session/$classId/$sectionId/$parentId");
      if (kDebugMode) {
        print(
            " viewenquiry  ${AppUrl.viewenquiryUrl}$session/$classId/$sectionId/$parentId");
        print(
            " viewenquiry api parsed data from model in get api   ${ViewEnquiryModel.fromJson(response)}");
      }
      return ViewEnquiryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" viewenquiry this is error $e");
      }
      throw FormatException(
          "Exception error in view enquiry repo  ${e.toString}");
    }
  }
}

class PostEnquiry {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<List<EnquiryPostModelClass>> grievance(
    String baseURl,
  ) async {
    List<EnquiryPostModelClass> dataList = <EnquiryPostModelClass>[];
    try {
      dynamic response =
          await _apiServices.getApi("$baseURl${AppUrl.postenquiryUrl}");
      if (kDebugMode) {
        print(" api data post enquiry  ${AppUrl.postenquiryUrl}");
      }
      final data = response["data"];
      // print( "  fees payment api parsed data from model in get api   ${GrievanceTypeModel.fromJson(response)}");
      for (final ele in data) {
        dataList.add(EnquiryPostModelClass.fromJson(ele));
      }
      return dataList;
    } catch (e) {
      if (kDebugMode) {
        print("this is error $e");
      }
      throw FormatException(
          "Exception error in post enquiry repo  ${e.toString}");
    }
  }
}

class HolidayClassRepo {
  final String baseUrl = "http://school.eduagentapp.com"; // Ensure this is correct

  Future<HolidayModelClass> holidayclassview(String secUrl) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/FMSCoreApi/ViewHolidays"));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return HolidayModelClass.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to load holidays: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error in holiday repo: $e");
      throw Exception("Exception error in holiday repo: $e");
    }
  }
}

class acadmicCalender{
  BaseApiServices _apiServices = NetworkApiServices();
  Future<acadmiccalender> acadmic(
  ) async {
    try {
      dynamic response =
          await _apiServices.getApi("${AppUrl.acadmic}");
      if (kDebugMode) {
        print(" acadmic calender  ${AppUrl.acadmic}");
        print(
            " acadmic api parsed data from model in get api   ${acadmiccalender.fromJson(response)}");
      }
      return acadmiccalender.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" holiday this is error $e");
      }
      throw FormatException("Exception error in holiday repo  ${e.toString}");
    }
  }
}
// Future<StudentResponse?> fetchTodayBirthdays() async {
//   final String baseUrl =
//       await PrefManager().readValue(key: PrefConst.baseUrlLocalSaved);
//
//   final String apiUrl =
//       '$baseUrl/api/FMSCoreApi/GettodayB/2024-25/415126';
//
//   try {
//     final response = await http.get(Uri.parse(apiUrl));
//
//     if (response.statusCode == 200) {
//       return StudentResponse.fromJson(json.decode(response.body));
//     } else {
//       print('Failed to load data: ${response.statusCode}');
//       return null;
//     }
//   } catch (e) {
//     print('Error fetching data: $e');
//     return null;
//   }
// }


class AppImageRepo {
  BaseApiServices _apiServices = NetworkApiServices();
  Future<ImageModel> appImagerepo() async {
    try {
      dynamic response = await _apiServices.getApi(AppUrl.icon_url);
      if (kDebugMode) {
        print(" Image api  ${AppUrl.icon_url}");
        print(
            " Image api parsed data from model in get api   ${ImageModel.fromJson(response)}");
      }
      return ImageModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(" Image  this is error $e");
      }
      throw FormatException("Exception error in image repo  ${e.toString}");
    }
  }
}
