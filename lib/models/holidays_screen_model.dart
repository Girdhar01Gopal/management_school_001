class HolidayResponseModel {
  final String? message;
  final List<HolidayItem>? data;
  final int? statuscode;
  final int? totalCount;

  HolidayResponseModel({
    this.message,
    this.data,
    this.statuscode,
    this.totalCount,
  });

  factory HolidayResponseModel.fromJson(Map<String, dynamic> json) {
    return HolidayResponseModel(
      message: json['message']?.toString(),
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => HolidayItem.fromJson(e))
          .toList()
          : [],
      statuscode: _parseInt(json['statuscode']),
      totalCount: _parseInt(json['totalCount']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "data": data?.map((e) => e.toJson()).toList(),
      "statuscode": statuscode,
      "totalCount": totalCount,
    };
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}

class HolidayItem {
  final int? hdId;
  final String? dateHoliday;
  final String? dateHoliday1;
  final String? occasion;
  final int? action;
  final String? createBy;
  final String? updateBy;
  final bool? isActive;
  final String? createdDate;
  final String? date;
  final String? modifiedDate;
  final int? createdby;
  final int? updatedby;

  HolidayItem({
    this.hdId,
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
    this.updatedby,
  });

  factory HolidayItem.fromJson(Map<String, dynamic> json) {
    return HolidayItem(
      hdId: _parseInt(json['HdId']),
      dateHoliday: json['DateHoliday']?.toString(),
      dateHoliday1: json['DateHoliday1']?.toString(),
      occasion: json['Occasion']?.toString(),
      action: _parseInt(json['Action']),
      createBy: json['CreateBy']?.toString(),
      updateBy: json['UpdateBy']?.toString(),
      isActive: _parseBool(json['IsActive']),
      createdDate: json['CreatedDate']?.toString(),
      date: json['Date']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      createdby: _parseInt(json['Createdby']),
      updatedby: _parseInt(json['Updatedby']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "HdId": hdId,
      "DateHoliday": dateHoliday,
      "DateHoliday1": dateHoliday1,
      "Occasion": occasion,
      "Action": action,
      "CreateBy": createBy,
      "UpdateBy": updateBy,
      "IsActive": isActive,
      "CreatedDate": createdDate,
      "Date": date,
      "ModifiedDate": modifiedDate,
      "Createdby": createdby,
      "Updatedby": updatedby,
    };
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static bool? _parseBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value.toString().toLowerCase() == 'true') return true;
    if (value.toString().toLowerCase() == 'false') return false;
    return null;
  }
}