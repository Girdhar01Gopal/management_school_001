class VideoGalleryModel {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  VideoGalleryModel(
      {this.message, this.data, this.statuscode, this.totalCount});

  VideoGalleryModel.fromJson(Map<String, dynamic> json) {
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
  int? vId;
  var classs;
  int? classId;
  var section;
  int? sectionId;
  var session;
  var videoUrl;
  var action;
  var createBy;
  var updateBy;
  var createDate;
  var schoolId;
  bool? isActive;
  var createdDate;
  var date;
  var modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.vId,
      this.classs,
      this.classId,
      this.section,
      this.sectionId,
      this.session,
      this.videoUrl,
      this.action,
      this.createBy,
      this.updateBy,
      this.createDate,
      this.schoolId,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    vId = json['VId'];
    classs = json['Classs'];
    classId = json['ClassId'];
    section = json['Section'];
    sectionId = json['SectionId'];
    session = json['Session'];
    videoUrl = json['VideoUrl'];
    action = json['Action'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    createDate = json['CreateDate'];
    schoolId = json['SchoolId'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VId'] = this.vId;
    data['Classs'] = this.classs;
    data['ClassId'] = this.classId;
    data['Section'] = this.section;
    data['SectionId'] = this.sectionId;
    data['Session'] = this.session;
    data['VideoUrl'] = this.videoUrl;
    data['Action'] = this.action;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
    data['CreateDate'] = this.createDate;
    data['SchoolId'] = this.schoolId;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
