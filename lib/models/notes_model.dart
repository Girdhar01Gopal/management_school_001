class NotesModel {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  NotesModel({this.message, this.data, this.statuscode, this.totalCount});

  NotesModel.fromJson(Map<String, dynamic> json) {
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
  var nId;
  var classs;
  var classId;
  var section;
  var sectionId;
  var subject;
  var subjectId;
  var session;
  var remarks;
  var notesFile;
  var action;
  var createDate;
  var createBy;
  var updateBy;
  var schoolId;
  var name;
  bool? isActive;
  var createdDate;
  var date;
  var modifiedDate;
  var createdby;
  var updatedby;

  Data(
      {this.nId,
      this.classs,
      this.classId,
      this.section,
      this.sectionId,
      this.subject,
      this.subjectId,
      this.session,
      this.remarks,
      this.notesFile,
      this.action,
      this.createDate,
      this.createBy,
      this.updateBy,
      this.schoolId,
      this.name,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    nId = json['NId'];
    classs = json['Classs'];
    classId = json['ClassId'];
    section = json['Section'];
    sectionId = json['SectionId'];
    subject = json['Subject'];
    subjectId = json['SubjectId'];
    session = json['Session'];
    remarks = json['Remarks'];
    notesFile = json['NotesFile'];
    action = json['Action'];
    createDate = json['CreateDate'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    schoolId = json['SchoolId'];
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
    data['NId'] = this.nId;
    data['Classs'] = this.classs;
    data['ClassId'] = this.classId;
    data['Section'] = this.section;
    data['SectionId'] = this.sectionId;
    data['Subject'] = this.subject;
    data['SubjectId'] = this.subjectId;
    data['Session'] = this.session;
    data['Remarks'] = this.remarks;
    data['NotesFile'] = this.notesFile;
    data['Action'] = this.action;
    data['CreateDate'] = this.createDate;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
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
