class SessionResponseModel {
  String? message;
  List<SessionModel>? data;
  int? statuscode;
  int? totalCount;

  SessionResponseModel({
    this.message,
    this.data,
    this.statuscode,
    this.totalCount,
  });

  SessionResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
    statuscode = json['statuscode'] is int
        ? json['statuscode']
        : int.tryParse(json['statuscode']?.toString() ?? '');
    totalCount = json['totalCount'] is int
        ? json['totalCount']
        : int.tryParse(json['totalCount']?.toString() ?? '');

    if (json['data'] != null && json['data'] is List) {
      data = (json['data'] as List)
          .map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.map((e) => e.toJson()).toList() ?? [],
      'statuscode': statuscode,
      'totalCount': totalCount,
    };
  }
}

class SessionModel {
  int? sessionId;
  String? session;
  String? action;
  dynamic createBy;
  DateTime? createDate;
  dynamic updateBy;
  String? schoolId;
  DateTime? updatedate;
  bool? isActive;
  DateTime? createdDate;
  DateTime? date;
  DateTime? modifiedDate;
  int? createdby;
  int? updatedby;

  SessionModel({
    this.sessionId,
    this.session,
    this.action,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.schoolId,
    this.updatedate,
    this.isActive,
    this.createdDate,
    this.date,
    this.modifiedDate,
    this.createdby,
    this.updatedby,
  });

  SessionModel.fromJson(Map<String, dynamic> json) {
    sessionId = json['SessionId'] is int
        ? json['SessionId']
        : int.tryParse(json['SessionId']?.toString() ?? '');
    session = json['Session']?.toString();
    action = json['Action']?.toString();
    createBy = json['CreateBy'];
    createDate = DateTime.tryParse(json['CreateDate']?.toString() ?? '');
    updateBy = json['UpdateBy'];
    schoolId = json['SchoolId']?.toString();
    updatedate = DateTime.tryParse(json['Updatedate']?.toString() ?? '');
    isActive = json['IsActive'] is bool
        ? json['IsActive']
        : json['IsActive']?.toString().toLowerCase() == 'true';
    createdDate = DateTime.tryParse(json['CreatedDate']?.toString() ?? '');
    date = DateTime.tryParse(json['Date']?.toString() ?? '');
    modifiedDate = DateTime.tryParse(json['ModifiedDate']?.toString() ?? '');
    createdby = json['Createdby'] is int
        ? json['Createdby']
        : int.tryParse(json['Createdby']?.toString() ?? '');
    updatedby = json['Updatedby'] is int
        ? json['Updatedby']
        : int.tryParse(json['Updatedby']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'SessionId': sessionId,
      'Session': session,
      'Action': action,
      'CreateBy': createBy,
      'CreateDate': createDate?.toIso8601String(),
      'UpdateBy': updateBy,
      'SchoolId': schoolId,
      'Updatedate': updatedate?.toIso8601String(),
      'IsActive': isActive,
      'CreatedDate': createdDate?.toIso8601String(),
      'Date': date?.toIso8601String(),
      'ModifiedDate': modifiedDate?.toIso8601String(),
      'Createdby': createdby,
      'Updatedby': updatedby,
    };
  }
}