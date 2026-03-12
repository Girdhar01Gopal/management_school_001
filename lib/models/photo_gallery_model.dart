class PhotoGalleryModel {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  PhotoGalleryModel(
      {this.message, this.data, this.statuscode, this.totalCount});

  PhotoGalleryModel.fromJson(Map<String, dynamic> json) {
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
  int? uploadImageId;
  var classs;
  int? classId;
  String? session;
  String? categoryName;
  String? imageHeading;
  String? date;
  String? uploadImage;
  var action;
  var section;
  int? sectionId;
  String? createBy;
  var updateBy;
  String? schoolId;
  bool? isActive;
  String? createdDate;
  String? modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.uploadImageId,
      this.classs,
      this.classId,
      this.session,
      this.categoryName,
      this.imageHeading,
      this.date,
      this.uploadImage,
      this.action,
      this.section,
      this.sectionId,
      this.createBy,
      this.updateBy,
      this.schoolId,
      this.isActive,
      this.createdDate,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    uploadImageId = json['UploadImageId'];
    classs = json['Classs'];
    classId = json['ClassId'];
    session = json['Session'];
    categoryName = json['CategoryName'];
    imageHeading = json['ImageHeading'];
    date = json['Date'];
    uploadImage = json['UploadImage'];
    action = json['Action'];
    section = json['Section'];
    sectionId = json['SectionId'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    schoolId = json['SchoolId'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UploadImageId'] = this.uploadImageId;
    data['Classs'] = this.classs;
    data['ClassId'] = this.classId;
    data['Session'] = this.session;
    data['CategoryName'] = this.categoryName;
    data['ImageHeading'] = this.imageHeading;
    data['Date'] = this.date;
    data['UploadImage'] = this.uploadImage;
    data['Action'] = this.action;
    data['Section'] = this.section;
    data['SectionId'] = this.sectionId;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
    data['SchoolId'] = this.schoolId;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
