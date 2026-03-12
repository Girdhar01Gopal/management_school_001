class acadmiccalender {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  acadmiccalender({this.message, this.data, this.statuscode, this.totalCount});

  acadmiccalender.fromJson(Map<String, dynamic> json) {
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
  int? acdmiId;
  String? dateAcdmi;
  Null? dateAcdmi1;
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
      {this.acdmiId,
      this.dateAcdmi,
      this.dateAcdmi1,
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
    acdmiId = json['AcdmiId'];
    dateAcdmi = json['DateAcdmi'];
    dateAcdmi1 = json['DateAcdmi1'];
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
    data['AcdmiId'] = this.acdmiId;
    data['DateAcdmi'] = this.dateAcdmi;
    data['DateAcdmi1'] = this.dateAcdmi1;
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