class SyllabusModel {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  SyllabusModel({this.message, this.data, this.statuscode, this.totalCount});

  SyllabusModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? syllabusId;
  var classs;
  int? classId;
  var section;
  int? sectionId;
  var subject;
  int? subjectId;
  var session;
  var remarks;
  var syllabusFile;
  var action;
  var createDate;
  var createBy;
  var updateBy;
  var schoolId;
  var teacherReg;
  int? teacherId;
  var name;
  bool? isActive;
  var createdDate;
  var date;
  var modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.syllabusId,
      this.classs,
      this.classId,
      this.section,
      this.sectionId,
      this.subject,
      this.subjectId,
      this.session,
      this.remarks,
      this.syllabusFile,
      this.action,
      this.createDate,
      this.createBy,
      this.updateBy,
      this.schoolId,
      this.teacherReg,
      this.teacherId,
      this.name,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    syllabusId = json['SyllabusId'];
    classs = json['Classs'];
    classId = json['ClassId'];
    section = json['Section'];
    sectionId = json['SectionId'];
    subject = json['Subject'];
    subjectId = json['SubjectId'];
    session = json['Session'];
    remarks = json['Remarks'];
    syllabusFile = json['SyllabusFile'];
    action = json['Action'];
    createDate = json['CreateDate'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    schoolId = json['SchoolId'];
    teacherReg = json['TeacherReg'];
    teacherId = json['TeacherId'];
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
    data['SyllabusId'] = this.syllabusId;
    data['Classs'] = this.classs;
    data['ClassId'] = this.classId;
    data['Section'] = this.section;
    data['SectionId'] = this.sectionId;
    data['Subject'] = this.subject;
    data['SubjectId'] = this.subjectId;
    data['Session'] = this.session;
    data['Remarks'] = this.remarks;
    data['SyllabusFile'] = this.syllabusFile;
    data['Action'] = this.action;
    data['CreateDate'] = this.createDate;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
    data['SchoolId'] = this.schoolId;
    data['TeacherReg'] = this.teacherReg;
    data['TeacherId'] = this.teacherId;
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
