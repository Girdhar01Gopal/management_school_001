class EnquiryPostModelClass {
  String? message;
  Data? data;
  int? statuscode;
  int? totalCount;

  EnquiryPostModelClass(
      {this.message, this.data, this.statuscode, this.totalCount});

  EnquiryPostModelClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statuscode = json['statuscode'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statuscode'] = this.statuscode;
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class Data {
  int? id;
  var parentID;
  var classs;
  int? classId;
  var section;
  int? sectionId;
  var session;
  String? createDate;
  var subject;
  var message;
  var action;
  var createBy;
  var updateBy;
  var reply;
  String? replyDate;
  var studentName;
  var schoolId;
  var name;
  bool? isActive;
  String? createdDate;
  String? date;
  String? modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.id,
      this.parentID,
      this.classs,
      this.classId,
      this.section,
      this.sectionId,
      this.session,
      this.createDate,
      this.subject,
      this.message,
      this.action,
      this.createBy,
      this.updateBy,
      this.reply,
      this.replyDate,
      this.studentName,
      this.schoolId,
      this.name,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    parentID = json['ParentID'];
    classs = json['Classs'];
    classId = json['ClassId'];
    section = json['Section'];
    sectionId = json['SectionId'];
    session = json['Session'];
    createDate = json['CreateDate'];
    subject = json['Subject'];
    message = json['Message'];
    action = json['Action'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    reply = json['Reply'];
    replyDate = json['ReplyDate'];
    studentName = json['StudentName'];
    schoolId = json['SchoolId'];
    name = json['Name'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  get length => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ParentID'] = this.parentID;
    data['Classs'] = this.classs;
    data['ClassId'] = this.classId;
    data['Section'] = this.section;
    data['SectionId'] = this.sectionId;
    data['Session'] = this.session;
    data['CreateDate'] = this.createDate;
    data['Subject'] = this.subject;
    data['Message'] = this.message;
    data['Action'] = this.action;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
    data['Reply'] = this.reply;
    data['ReplyDate'] = this.replyDate;
    data['StudentName'] = this.studentName;
    data['SchoolId'] = this.schoolId;
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
