class HolidayModelClass {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  HolidayModelClass(
      {this.message, this.data, this.statuscode, this.totalCount});

  HolidayModelClass.fromJson(Map<String, dynamic> json) {
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
  int? hdId;
  String? dateHoliday;
  var dateHoliday1;
  String? occasion;
  int? action;
  String? createBy;
  String? updateBy;
  bool? isActive;
  String? createdDate;
  String? date;
  String? modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.hdId,
      this.dateHoliday,
      this.dateHoliday1,
      this.occasion,
      this.action,
      this.createBy,
      this.updateBy,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    hdId = json['HdId'];
    dateHoliday = json['DateHoliday'];
    dateHoliday1 = json['DateHoliday1'];
    occasion = json['Occasion'];
    action = json['Action'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HdId'] = this.hdId;
    data['DateHoliday'] = this.dateHoliday;
    data['DateHoliday1'] = this.dateHoliday1;
    data['Occasion'] = this.occasion;
    data['Action'] = this.action;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
