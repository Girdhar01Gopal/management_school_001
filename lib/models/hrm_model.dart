class HRMModel {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  HRMModel({this.message, this.data, this.statuscode, this.totalCount});

  HRMModel.fromJson(Map<String, dynamic> json) {
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
  int? totaltEmployees;
  int? totaltProject;
  int? totalPendingProject;
  int? totalCompleteProject;
  bool? isActive;
  String? createdDate;
  String? date;
  String? modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.totaltEmployees,
        this.totaltProject,
        this.totalPendingProject,
        this.totalCompleteProject,
        this.isActive,
        this.createdDate,
        this.date,
        this.modifiedDate,
        this.createdby,
        this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    totaltEmployees = json['TotaltEmployees'];
    totaltProject = json['TotaltProject'];
    totalPendingProject = json['TotalPendingProject'];
    totalCompleteProject = json['TotalCompleteProject'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotaltEmployees'] = this.totaltEmployees;
    data['TotaltProject'] = this.totaltProject;
    data['TotalPendingProject'] = this.totalPendingProject;
    data['TotalCompleteProject'] = this.totalCompleteProject;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
