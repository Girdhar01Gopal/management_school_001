class ViewEnquiryModel {
  String? message;
  List<EnquiryData>? data;
  int? statuscode;
  int? totalCount;

  ViewEnquiryModel({this.message, this.data, this.statuscode, this.totalCount});

  ViewEnquiryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <EnquiryData>[];
      json['data'].forEach((v) {
        data!.add(new EnquiryData.fromJson(v));
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

class EnquiryData {
  var id;
  var parentID;
  var classs;
  var classId;
  var section;
  var sectionId;
  var session;
  var createDate;
  var subject;
  var message;
  var action;
  var createBy;
  var updateBy;
  var replyBy;
  var reply;
  var replyDate;
  var studentName;
  var schoolId;
  var name;
  var teacherReg;
  var admissionNo;
  var type;
  var replyId;
  var status;
  var title;
  bool? isActive;
  var createdDate;
  var date;
  var modifiedDate;
  var createdby;
  var updatedby;

  EnquiryData(
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
      this.replyBy,
      this.reply,
      this.replyDate,
      this.studentName,
      this.schoolId,
      this.name,
      this.teacherReg,
      this.admissionNo,
      this.type,
      this.replyId,
      this.status,
      this.title,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  EnquiryData.fromJson(Map<String, dynamic> json) {
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
    replyBy = json['ReplyBy'];
    reply = json['Reply'];
    replyDate = json['ReplyDate'];
    studentName = json['StudentName'];
    schoolId = json['SchoolId'];
    name = json['Name'];
    teacherReg = json['TeacherReg'];
    admissionNo = json['AdmissionNo'];
    type = json['Type'];
    replyId = json['ReplyId'];
    status = json['Status'];
    title = json['Title'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

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
    data['ReplyBy'] = this.replyBy;
    data['Reply'] = this.reply;
    data['ReplyDate'] = this.replyDate;
    data['StudentName'] = this.studentName;
    data['SchoolId'] = this.schoolId;
    data['Name'] = this.name;
    data['TeacherReg'] = this.teacherReg;
    data['AdmissionNo'] = this.admissionNo;
    data['Type'] = this.type;
    data['ReplyId'] = this.replyId;
    data['Status'] = this.status;
    data['Title'] = this.title;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
