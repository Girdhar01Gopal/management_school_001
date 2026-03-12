class SearchDateTimeTableModel {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  SearchDateTimeTableModel(
      {this.message, this.data, this.statuscode, this.totalCount});

  SearchDateTimeTableModel.fromJson(Map<String, dynamic> json) {
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
  int? timetableID;
  int? classId;
  var classs;
  int? sectionId;
  var section;
  int? subjectId;
  var subject;
  var session;
  var monday;
  var tuesday;
  var wednesday;
  var thursday;
  var friday;
  var saturday;
  var sunday;
  var monday1;
  var tuesday1;
  var wednesday1;
  var thursday1;
  var friday1;
  var saturday1;
  var sunday1;
  var startTime;
  var endTime;
  var action;
  var status;
  var createBy;
  var updateBy;
  var createDate;
  var schoolId;
  var startDate1;
  var endDate1;
  var startDate;
  var endDate;
  var image;
  var teacherReg;
  int? tId;
  var title;
  var name;
  bool? isActive;
  var createdDate;
  var date;
  var modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.timetableID,
      this.classId,
      this.classs,
      this.sectionId,
      this.section,
      this.subjectId,
      this.subject,
      this.session,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday,
      this.monday1,
      this.tuesday1,
      this.wednesday1,
      this.thursday1,
      this.friday1,
      this.saturday1,
      this.sunday1,
      this.startTime,
      this.endTime,
      this.action,
      this.status,
      this.createBy,
      this.updateBy,
      this.createDate,
      this.schoolId,
      this.startDate1,
      this.endDate1,
      this.startDate,
      this.endDate,
      this.image,
      this.teacherReg,
      this.tId,
      this.title,
      this.name,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    timetableID = json['timetableID'];
    classId = json['ClassId'];
    classs = json['Classs'];
    sectionId = json['SectionId'];
    section = json['Section'];
    subjectId = json['SubjectId'];
    subject = json['Subject'];
    session = json['Session'];
    monday = json['Monday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
    sunday = json['Sunday'];
    monday1 = json['Monday1'];
    tuesday1 = json['Tuesday1'];
    wednesday1 = json['Wednesday1'];
    thursday1 = json['Thursday1'];
    friday1 = json['Friday1'];
    saturday1 = json['Saturday1'];
    sunday1 = json['Sunday1'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    action = json['Action'];
    status = json['Status'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    createDate = json['CreateDate'];
    schoolId = json['SchoolId'];
    startDate1 = json['StartDate1'];
    endDate1 = json['EndDate1'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    image = json['Image'];
    teacherReg = json['TeacherReg'];
    tId = json['TId'];
    title = json['Title'];
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
    data['timetableID'] = this.timetableID;
    data['ClassId'] = this.classId;
    data['Classs'] = this.classs;
    data['SectionId'] = this.sectionId;
    data['Section'] = this.section;
    data['SubjectId'] = this.subjectId;
    data['Subject'] = this.subject;
    data['Session'] = this.session;
    data['Monday'] = this.monday;
    data['Tuesday'] = this.tuesday;
    data['Wednesday'] = this.wednesday;
    data['Thursday'] = this.thursday;
    data['Friday'] = this.friday;
    data['Saturday'] = this.saturday;
    data['Sunday'] = this.sunday;
    data['Monday1'] = this.monday1;
    data['Tuesday1'] = this.tuesday1;
    data['Wednesday1'] = this.wednesday1;
    data['Thursday1'] = this.thursday1;
    data['Friday1'] = this.friday1;
    data['Saturday1'] = this.saturday1;
    data['Sunday1'] = this.sunday1;
    data['StartTime'] = this.startTime;
    data['EndTime'] = this.endTime;
    data['Action'] = this.action;
    data['Status'] = this.status;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
    data['CreateDate'] = this.createDate;
    data['SchoolId'] = this.schoolId;
    data['StartDate1'] = this.startDate1;
    data['EndDate1'] = this.endDate1;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['Image'] = this.image;
    data['TeacherReg'] = this.teacherReg;
    data['TId'] = this.tId;
    data['Title'] = this.title;
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
