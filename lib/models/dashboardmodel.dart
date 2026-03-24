class dashboardmodel {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  dashboardmodel({this.message, this.data, this.statuscode, this.totalCount});

  dashboardmodel.fromJson(Map<String, dynamic> json) {
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
  int? totalstudents;
  int? totalteacher;
  int? totalStaff;
  int? todayBirthday;
  int? todaylead;
  int? todayTotelFee;
  int? totelmonthsFee;
  int? totalPresent;
  int? totalAbsent;
  int? totalBoys;
  int? totalGirls;
  int? todayPayAmount;
  int? todayAmount;
  int? dueAmount;
  int? totalBalance;
  int? transportstudents;
  int? totalResult;
  Null? defaulterStudents;
  bool? isActive;
  String? createdDate;
  String? date;
  String? modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.totalstudents,
      this.totalteacher,
      this.totalStaff,
      this.todayBirthday,
      this.todaylead,
      this.todayTotelFee,
      this.totelmonthsFee,
      this.totalPresent,
      this.totalAbsent,
      this.totalBoys,
      this.totalGirls,
      this.todayPayAmount,
      this.todayAmount,
      this.dueAmount,
      this.totalBalance,
      this.transportstudents,
      this.totalResult,
      this.defaulterStudents,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    totalstudents = json['Totalstudents'];
    totalteacher = json['Totalteacher'];
    totalStaff = json['totalStaff'];
    todayBirthday = json['TodayBirthday'];
    todaylead = json['Todaylead'];
    todayTotelFee = json['TodayTotelFee'];
    totelmonthsFee = json['TotelmonthsFee'];
    totalPresent = json['TotalPresent'];
    totalAbsent = json['TotalAbsent'];
    totalBoys = json['TotalBoys'];
    totalGirls = json['TotalGirls'];
    todayPayAmount = json['TodayPayAmount'];
    todayAmount = json['TodayAmount'];
    dueAmount = json['DueAmount'];
    totalBalance = json['TotalBalance'];
    transportstudents = json['Transportstudents'];
    totalResult = json['TotalResult'];
    defaulterStudents = json['DefaulterStudents'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Totalstudents'] = this.totalstudents;
    data['Totalteacher'] = this.totalteacher;
    data['totalStaff'] = this.totalStaff;
    data['TodayBirthday'] = this.todayBirthday;
    data['Todaylead'] = this.todaylead;
    data['TodayTotelFee'] = this.todayTotelFee;
    data['TotelmonthsFee'] = this.totelmonthsFee;
    data['TotalPresent'] = this.totalPresent;
    data['TotalAbsent'] = this.totalAbsent;
    data['TotalBoys'] = this.totalBoys;
    data['TotalGirls'] = this.totalGirls;
    data['TodayPayAmount'] = this.todayPayAmount;
    data['TodayAmount'] = this.todayAmount;
    data['DueAmount'] = this.dueAmount;
    data['TotalBalance'] = this.totalBalance;
    data['Transportstudents'] = this.transportstudents;
    data['TotalResult'] = this.totalResult;
    data['DefaulterStudents'] = this.defaulterStudents;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}