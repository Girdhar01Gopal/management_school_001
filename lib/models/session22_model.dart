// ============================================================
// Model: SessionModel2
// Description: Represents session list API response
// ============================================================

class SessionModel2Response {
  final String message;
  final List<SessionModel2> data;
  final int statusCode;
  final int totalCount;

  SessionModel2Response({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.totalCount,
  });

  factory SessionModel2Response.fromJson(Map<String, dynamic> json) {
    return SessionModel2Response(
      message: json['message'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SessionModel2.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      statusCode: json['statuscode'] as int? ?? 0,
      totalCount: json['totalCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
      'statuscode': statusCode,
      'totalCount': totalCount,
    };
  }
}

// ============================================================

class SessionModel2 {
  final int sessionId;
  final String session;
  final String action;
  final String createBy;
  final DateTime createDate;
  final String? updateBy;
  final String schoolId;
  final DateTime updateDate;
  final bool isActive;
  final DateTime createdDate;
  final DateTime date;
  final DateTime modifiedDate;
  final int createdBy;
  final int updatedBy;

  SessionModel2({
    required this.sessionId,
    required this.session,
    required this.action,
    required this.createBy,
    required this.createDate,
    this.updateBy,
    required this.schoolId,
    required this.updateDate,
    required this.isActive,
    required this.createdDate,
    required this.date,
    required this.modifiedDate,
    required this.createdBy,
    required this.updatedBy,
  });

  factory SessionModel2.fromJson(Map<String, dynamic> json) {
    return SessionModel2(
      sessionId: json['SessionId'] as int? ?? 0,
      session: json['Session'] as String? ?? '',
      action: json['Action'] as String? ?? '',
      createBy: json['CreateBy'] as String? ?? '',
      createDate: DateTime.tryParse(json['CreateDate'] as String? ?? '') ??
          DateTime(0001, 1, 1),
      updateBy: json['UpdateBy'] as String?,
      schoolId: json['SchoolId'] as String? ?? '',
      updateDate: DateTime.tryParse(json['Updatedate'] as String? ?? '') ??
          DateTime(0001, 1, 1),
      isActive: json['IsActive'] as bool? ?? false,
      createdDate: DateTime.tryParse(json['CreatedDate'] as String? ?? '') ??
          DateTime(0001, 1, 1),
      date: DateTime.tryParse(json['Date'] as String? ?? '') ??
          DateTime(0001, 1, 1),
      modifiedDate: DateTime.tryParse(json['ModifiedDate'] as String? ?? '') ??
          DateTime(0001, 1, 1),
      createdBy: json['Createdby'] as int? ?? 0,
      updatedBy: json['Updatedby'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SessionId': sessionId,
      'Session': session,
      'Action': action,
      'CreateBy': createBy,
      'CreateDate': createDate.toIso8601String(),
      'UpdateBy': updateBy,
      'SchoolId': schoolId,
      'Updatedate': updateDate.toIso8601String(),
      'IsActive': isActive,
      'CreatedDate': createdDate.toIso8601String(),
      'Date': date.toIso8601String(),
      'ModifiedDate': modifiedDate.toIso8601String(),
      'Createdby': createdBy,
      'Updatedby': updatedBy,
    };
  }

  @override
  String toString() {
    return 'SessionModel2('
        'sessionId: $sessionId, '
        'session: $session, '
        'schoolId: $schoolId, '
        'createBy: $createBy, '
        'isActive: $isActive'
        ')';
  }
}