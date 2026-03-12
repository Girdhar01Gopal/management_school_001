class NotificationClassViewModel {
  String? message;
  List<NotificationData>? data;
  int? statuscode;
  int? totalCount;

  NotificationClassViewModel(
      {this.message, this.data, this.statuscode, this.totalCount});

  NotificationClassViewModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
      });
    }
    statuscode = json['statuscode'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statuscode'] = this.statuscode;
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class NotificationData {
  int? notificationId;
  String? title;
  String? message;
  String? createDate;
  String? session;
  String? notificationFile;
  String? action;
  String? createBy;
  Null? updateBy;
  String? schoolId;
  int? classId;
  int? sectionId;
  Null? types;
  int? status;
  String? teacherReg;
  Null? name;
  bool? isActive;
  String? createdDate;
  String? date;
  String? modifiedDate;
  int? createdby;
  int? updatedby;

  NotificationData(
      {this.notificationId,
        this.title,
        this.message,
        this.createDate,
        this.session,
        this.notificationFile,
        this.action,
        this.createBy,
        this.updateBy,
        this.schoolId,
        this.classId,
        this.sectionId,
        this.types,
        this.status,
        this.teacherReg,
        this.name,
        this.isActive,
        this.createdDate,
        this.date,
        this.modifiedDate,
        this.createdby,
        this.updatedby});

  NotificationData.fromJson(Map<String, dynamic> json) {
    notificationId = json['NotificationId'];
    title = json['Title'];
    message = json['Message'];
    createDate = json['CreateDate'];
    session = json['Session'];
    notificationFile = json['NotificationFile'];
    action = json['Action'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    schoolId = json['SchoolId'];
    classId = json['ClassId'];
    sectionId = json['SectionId'];
    types = json['Types'];
    status = json['Status'];
    teacherReg = json['TeacherReg'];
    name = json['Name'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationId'] = this.notificationId;
    data['Title'] = this.title;
    data['Message'] = this.message;
    data['CreateDate'] = this.createDate;
    data['Session'] = this.session;
    data['NotificationFile'] = this.notificationFile;
    data['Action'] = this.action;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
    data['SchoolId'] = this.schoolId;
    data['ClassId'] = this.classId;
    data['SectionId'] = this.sectionId;
    data['Types'] = this.types;
    data['Status'] = this.status;
    data['TeacherReg'] = this.teacherReg;
    data['Name'] = this.name;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}