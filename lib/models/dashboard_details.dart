class DashboardDetail {
  String? message;
  List<DashboardData>? data;
  int? statuscode;
  int? totalCount;

  DashboardDetail({
    this.message,
    this.data,
    this.statuscode,
    this.totalCount,
  });

  DashboardDetail.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();

    if (json['data'] != null && json['data'] is List) {
      data = (json['data'] as List)
          .map((e) => DashboardData.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      data = [];
    }

    statuscode = _toInt(json['statuscode']);
    totalCount = _toInt(json['totalCount']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.map((v) => v.toJson()).toList() ?? [],
      'statuscode': statuscode,
      'totalCount': totalCount,
    };
  }
}

class DashboardData {
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
  dynamic defaulterStudents;
  bool? isActive;
  String? createdDate;
  String? date;
  String? modifiedDate;
  int? createdby;
  int? updatedby;

  DashboardData({
    this.totalstudents,
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
    this.updatedby,
  });

  DashboardData.fromJson(Map<String, dynamic> json) {
    totalstudents = _toInt(json['Totalstudents']);
    totalteacher = _toInt(json['Totalteacher']);
    totalStaff = _toInt(json['totalStaff']);
    todayBirthday = _toInt(json['TodayBirthday']);
    todaylead = _toInt(json['Todaylead']);
    todayTotelFee = _toInt(json['TodayTotelFee']);
    totelmonthsFee = _toInt(json['TotelmonthsFee']);
    totalPresent = _toInt(json['TotalPresent']);
    totalAbsent = _toInt(json['TotalAbsent']);
    totalBoys = _toInt(json['TotalBoys']);
    totalGirls = _toInt(json['TotalGirls']);
    todayPayAmount = _toInt(json['TodayPayAmount']);
    todayAmount = _toInt(json['TodayAmount']);
    dueAmount = _toInt(json['DueAmount']);
    totalBalance = _toInt(json['TotalBalance']);
    transportstudents = _toInt(json['Transportstudents']);
    totalResult = _toInt(json['TotalResult']);
    defaulterStudents = json['DefaulterStudents'];
    isActive = _toBool(json['IsActive']);
    createdDate = json['CreatedDate']?.toString();
    date = json['Date']?.toString();
    modifiedDate = json['ModifiedDate']?.toString();
    createdby = _toInt(json['Createdby']);
    updatedby = _toInt(json['Updatedby']);
  }

  Map<String, dynamic> toJson() {
    return {
      'Totalstudents': totalstudents,
      'Totalteacher': totalteacher,
      'totalStaff': totalStaff,
      'TodayBirthday': todayBirthday,
      'Todaylead': todaylead,
      'TodayTotelFee': todayTotelFee,
      'TotelmonthsFee': totelmonthsFee,
      'TotalPresent': totalPresent,
      'TotalAbsent': totalAbsent,
      'TotalBoys': totalBoys,
      'TotalGirls': totalGirls,
      'TodayPayAmount': todayPayAmount,
      'TodayAmount': todayAmount,
      'DueAmount': dueAmount,
      'TotalBalance': totalBalance,
      'Transportstudents': transportstudents,
      'TotalResult': totalResult,
      'DefaulterStudents': defaulterStudents,
      'IsActive': isActive,
      'CreatedDate': createdDate,
      'Date': date,
      'ModifiedDate': modifiedDate,
      'Createdby': createdby,
      'Updatedby': updatedby,
    };
  }
}

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  return int.tryParse(value.toString());
}

bool? _toBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) {
    final v = value.toLowerCase();
    if (v == 'true' || v == '1') return true;
    if (v == 'false' || v == '0') return false;
  }
  return null;
}