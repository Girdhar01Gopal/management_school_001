import 'dart:convert';

NotificationDashboardModel notificationDashboardModelFromJson(String str) =>
    NotificationDashboardModel.fromJson(json.decode(str));

String notificationDashboardModelToJson(NotificationDashboardModel data) =>
    json.encode(data.toJson());

class NotificationDashboardModel {
  String? message;
  List<NotificationItem>? data;
  int? statuscode;
  int? totalCount;

  NotificationDashboardModel({
    this.message,
    this.data,
    this.statuscode,
    this.totalCount,
  });

  factory NotificationDashboardModel.fromJson(Map<String, dynamic> json) {
    return NotificationDashboardModel(
      message: _parseString(json["message"]),
      data: json["data"] == null
          ? []
          : List<NotificationItem>.from(
        (json["data"] as List).map((x) => NotificationItem.fromJson(x)),
      ),
      statuscode: _parseInt(json["statuscode"]),
      totalCount: _parseInt(json["totalCount"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "statuscode": statuscode,
    "totalCount": totalCount,
  };

  static String _parseString(dynamic value) {
    if (value == null) return "";
    final v = value.toString().trim();
    if (v.toLowerCase() == "null") return "";
    return v;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }
}

class NotificationItem {
  int? notificationId;
  String? title;
  String? message;
  String? createDate;
  String? session;
  String? action;
  String? createBy;
  String? updateBy;
  String? notificationFile;
  String? name;
  String? schoolId;
  String? subject;
  int? classId;
  int? sectionId;
  String? teacherReg;
  String? admissionNo;
  String? type;
  String? className;
  String? names;
  int? communicationId;
  int? status;
  int? replyId;
  String? parentId;
  int? totalInboxMsg;
  String? studentName;
  int? id;
  String? section;
  String? reply;
  bool? isActive;
  String? createdDate;
  String? date;
  String? modifiedDate;
  int? createdby;
  int? updatedby;

  NotificationItem({
    this.notificationId,
    this.title,
    this.message,
    this.createDate,
    this.session,
    this.action,
    this.createBy,
    this.updateBy,
    this.notificationFile,
    this.name,
    this.schoolId,
    this.subject,
    this.classId,
    this.sectionId,
    this.teacherReg,
    this.admissionNo,
    this.type,
    this.className,
    this.names,
    this.communicationId,
    this.status,
    this.replyId,
    this.parentId,
    this.totalInboxMsg,
    this.studentName,
    this.id,
    this.section,
    this.reply,
    this.isActive,
    this.createdDate,
    this.date,
    this.modifiedDate,
    this.createdby,
    this.updatedby,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      notificationId: _parseInt(json["NotificationId"]),
      title: _parseString(json["Title"]),
      message: _parseString(json["Message"]),
      createDate: _parseString(json["CreateDate"]),
      session: _parseString(json["Session"]),
      action: _parseString(json["Action"]),
      createBy: _parseString(json["CreateBy"]),
      updateBy: _parseString(json["UpdateBy"]),
      notificationFile: _parseString(json["NotificationFile"]),
      name: _parseString(json["Name"]),
      schoolId: _parseString(json["SchoolId"]),
      subject: _parseString(json["Subject"]),
      classId: _parseInt(json["ClassId"]),
      sectionId: _parseInt(json["SectionId"]),
      teacherReg: _parseString(json["TeacherReg"]),
      admissionNo: _parseString(json["AdmissionNo"]),
      type: _parseString(json["Type"]),
      className: _parseString(json["Class"]),
      names: _parseString(json["Names"]),
      communicationId: _parseInt(json["CommunicationId"]),
      status: _parseInt(json["Status"]),
      replyId: _parseInt(json["ReplyId"]),
      parentId: _parseString(json["ParentID"]),
      totalInboxMsg: _parseInt(json["TotalInboxMsg"]),
      studentName: _parseString(json["StudentName"]),
      id: _parseInt(json["Id"]),
      section: _parseString(json["Section"]),
      reply: _parseString(json["Reply"]),
      isActive: _parseBool(json["IsActive"]),
      createdDate: _parseString(json["CreatedDate"]),
      date: _parseString(json["Date"]),
      modifiedDate: _parseString(json["ModifiedDate"]),
      createdby: _parseInt(json["Createdby"]),
      updatedby: _parseInt(json["Updatedby"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "NotificationId": notificationId,
    "Title": title,
    "Message": message,
    "CreateDate": createDate,
    "Session": session,
    "Action": action,
    "CreateBy": createBy,
    "UpdateBy": updateBy,
    "NotificationFile": notificationFile,
    "Name": name,
    "SchoolId": schoolId,
    "Subject": subject,
    "ClassId": classId,
    "SectionId": sectionId,
    "TeacherReg": teacherReg,
    "AdmissionNo": admissionNo,
    "Type": type,
    "Class": className,
    "Names": names,
    "CommunicationId": communicationId,
    "Status": status,
    "ReplyId": replyId,
    "ParentID": parentId,
    "TotalInboxMsg": totalInboxMsg,
    "StudentName": studentName,
    "Id": id,
    "Section": section,
    "Reply": reply,
    "IsActive": isActive,
    "CreatedDate": createdDate,
    "Date": date,
    "ModifiedDate": modifiedDate,
    "Createdby": createdby,
    "Updatedby": updatedby,
  };

  static String _parseString(dynamic value) {
    if (value == null) return "";
    final v = value.toString().trim();
    if (v.toLowerCase() == "null") return "";
    return v;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static bool _parseBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    final v = value.toString().toLowerCase();
    return v == "true" || v == "1";
  }
}