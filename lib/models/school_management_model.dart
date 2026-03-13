import 'dart:convert';

SchoolManagementModel schoolManagementModelFromJson(String str) =>
    SchoolManagementModel.fromJson(json.decode(str));

String schoolManagementModelToJson(SchoolManagementModel data) =>
    json.encode(data.toJson());

class SchoolManagementModel {
  final String? message;
  final List<SchoolManagementData>? data;
  final int? statuscode;
  final int? totalCount;

  SchoolManagementModel({
    this.message,
    this.data,
    this.statuscode,
    this.totalCount,
  });

  factory SchoolManagementModel.fromJson(Map<String, dynamic> json) {
    return SchoolManagementModel(
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<SchoolManagementData>.from(
        json["data"].map((x) => SchoolManagementData.fromJson(x)),
      ),
      statuscode: json["statuscode"],
      totalCount: json["totalCount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "data": data == null
          ? []
          : List<dynamic>.from(data!.map((x) => x.toJson())),
      "statuscode": statuscode,
      "totalCount": totalCount,
    };
  }
}

class SchoolManagementData {
  final int? totalstudents;
  final int? totalteacher;
  final int? totalStaff;
  final int? todayBirthday;
  final int? todaylead;
  final int? todayTotelFee;
  final int? totelmonthsFee;
  final int? totalPresent;
  final int? totalAbsent;
  final int? totalBoys;
  final int? totalGirls;
  final int? todayPayAmount;
  final int? todayAmount;
  final int? dueAmount;
  final int? totalBalance;
  final int? transportstudents;
  final int? totalResult;
  final int? defaulterStudents;
  final bool? isActive;
  final DateTime? createdDate;
  final DateTime? date;
  final DateTime? modifiedDate;
  final int? createdby;
  final int? updatedby;

  SchoolManagementData({
    this.totalstudents,
    this.totalteacher,
    this.totalStaff,
    this.todayBirthday,
    this.todaylead,
    this.todayTotelFee,
    this.totelmonthsFee,
    this.totalPresent,
    this.totalAbsent,
    this.totalBoys,
    this.totalGirls,
    this.todayPayAmount,
    this.todayAmount,
    this.dueAmount,
    this.totalBalance,
    this.transportstudents,
    this.totalResult,
    this.defaulterStudents,
    this.isActive,
    this.createdDate,
    this.date,
    this.modifiedDate,
    this.createdby,
    this.updatedby,
  });

  factory SchoolManagementData.fromJson(Map<String, dynamic> json) {
    return SchoolManagementData(
      totalstudents: json["Totalstudents"],
      totalteacher: json["Totalteacher"],
      totalStaff: json["totalStaff"],
      todayBirthday: json["TodayBirthday"],
      todaylead: json["Todaylead"],
      todayTotelFee: json["TodayTotelFee"],
      totelmonthsFee: json["TotelmonthsFee"],
      totalPresent: json["TotalPresent"],
      totalAbsent: json["TotalAbsent"],
      totalBoys: json["TotalBoys"],
      totalGirls: json["TotalGirls"],
      todayPayAmount: json["TodayPayAmount"],
      todayAmount: json["TodayAmount"],
      dueAmount: json["DueAmount"],
      totalBalance: json["TotalBalance"],
      transportstudents: json["Transportstudents"],
      totalResult: json["TotalResult"],
      defaulterStudents: json["DefaulterStudents"],
      isActive: json["IsActive"],
      createdDate: _parseDate(json["CreatedDate"]),
      date: _parseDate(json["Date"]),
      modifiedDate: _parseDate(json["ModifiedDate"]),
      createdby: json["Createdby"],
      updatedby: json["Updatedby"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Totalstudents": totalstudents,
      "Totalteacher": totalteacher,
      "totalStaff": totalStaff,
      "TodayBirthday": todayBirthday,
      "Todaylead": todaylead,
      "TodayTotelFee": todayTotelFee,
      "TotelmonthsFee": totelmonthsFee,
      "TotalPresent": totalPresent,
      "TotalAbsent": totalAbsent,
      "TotalBoys": totalBoys,
      "TotalGirls": totalGirls,
      "TodayPayAmount": todayPayAmount,
      "TodayAmount": todayAmount,
      "DueAmount": dueAmount,
      "TotalBalance": totalBalance,
      "Transportstudents": transportstudents,
      "TotalResult": totalResult,
      "DefaulterStudents": defaulterStudents,
      "IsActive": isActive,
      "CreatedDate": createdDate?.toIso8601String(),
      "Date": date?.toIso8601String(),
      "ModifiedDate": modifiedDate?.toIso8601String(),
      "Createdby": createdby,
      "Updatedby": updatedby,
    };
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value.toString().isEmpty) return null;
    if (value.toString() == "0001-01-01T00:00:00") return null;
    return DateTime.tryParse(value.toString());
  }
}