// ============================================================
// Model: SessionMonthWiseFee
// Description: Represents month-wise fee summary for a session
// ============================================================

class SessionMonthWiseFeeResponse {
  final String message;
  final List<SessionMonthWiseFee> data;
  final int statusCode;
  final int totalCount;

  SessionMonthWiseFeeResponse({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.totalCount,
  });

  factory SessionMonthWiseFeeResponse.fromJson(Map<String, dynamic> json) {
    return SessionMonthWiseFeeResponse(
      message: json['message'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
          SessionMonthWiseFee.fromJson(e as Map<String, dynamic>))
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

class SessionMonthWiseFee {
  // Student / Section Info (nullable from API)
  final String? feeType;
  final double? tutionFee;
  final double? transportFee;
  final String? feesDuration;
  final String? admissionNo;
  final String? registrationNo;
  final String? studentName;
  final double? examFee;
  final String? transportUser;
  final double? registrationFee;
  final double? admissionFee;
  final double? annualFee;
  final int? sectionId;
  final String? className;
  final String? session;
  final String? section;
  final double? cautionFee;
  final String? fatherName;
  final String? fMobileNo;
  final double? activityFee;
  final double? boardFee;
  final double? practicalFee;
  final double? preBoardFees;

  // Month Info
  final int tillMonth;
  final String monthName;

  // School Fee Totals
  final double totalFeeAmount;
  final double totalSchoolDiscount;
  final double totalNetFeeAmount;
  final double totalSchoolFee;
  final double totalNetSchoolFee;
  final double totalSchoolFeePaid;
  final double totalSchoolDue;
  final double totalSchoolAdvance;

  // Transport Fee Totals
  final double totalTransportFee;
  final double totalTransportDiscount;
  final double totalNetTransportFee;
  final double totalTransportFeePaid;
  final double totalTransportDue;
  final double totalTransportAdvance;

  // Grand Totals
  final double totalDiscount;
  final double grandTotalFee;
  final double totalFee;
  final double totalPaidFee;
  final double totalDueAmount;
  final double totalPaid;
  final double totalDue;
  final double totalAdvance;

  // Meta
  final bool isActive;
  final DateTime createdDate;
  final DateTime date;
  final DateTime modifiedDate;
  final int createdBy;
  final int updatedBy;

  SessionMonthWiseFee({
    this.feeType,
    this.tutionFee,
    this.transportFee,
    this.feesDuration,
    this.admissionNo,
    this.registrationNo,
    this.studentName,
    this.examFee,
    this.transportUser,
    this.registrationFee,
    this.admissionFee,
    this.annualFee,
    this.sectionId,
    this.className,
    this.session,
    this.section,
    this.cautionFee,
    this.fatherName,
    this.fMobileNo,
    this.activityFee,
    this.boardFee,
    this.practicalFee,
    this.preBoardFees,
    required this.tillMonth,
    required this.monthName,
    required this.totalFeeAmount,
    required this.totalSchoolDiscount,
    required this.totalNetFeeAmount,
    required this.totalSchoolFee,
    required this.totalNetSchoolFee,
    required this.totalSchoolFeePaid,
    required this.totalSchoolDue,
    required this.totalSchoolAdvance,
    required this.totalTransportFee,
    required this.totalTransportDiscount,
    required this.totalNetTransportFee,
    required this.totalTransportFeePaid,
    required this.totalTransportDue,
    required this.totalTransportAdvance,
    required this.totalDiscount,
    required this.grandTotalFee,
    required this.totalFee,
    required this.totalPaidFee,
    required this.totalDueAmount,
    required this.totalPaid,
    required this.totalDue,
    required this.totalAdvance,
    required this.isActive,
    required this.createdDate,
    required this.date,
    required this.modifiedDate,
    required this.createdBy,
    required this.updatedBy,
  });

  factory SessionMonthWiseFee.fromJson(Map<String, dynamic> json) {
    return SessionMonthWiseFee(
      feeType: json['FeeType'] as String?,
      tutionFee: _toDouble(json['TutionFee']),
      transportFee: _toDouble(json['TransportFee']),
      feesDuration: json['FeesDuration'] as String?,
      admissionNo: json['AdmissionNo'] as String?,
      registrationNo: json['RegistrationNo'] as String?,
      studentName: json['StudentName'] as String?,
      examFee: _toDouble(json['EXAMFEE']),
      transportUser: json['TransportUser'] as String?,
      registrationFee: _toDouble(json['REGISTRATIONFEE']),
      admissionFee: _toDouble(json['ADMISSIONFEE']),
      annualFee: _toDouble(json['ANNUALFEE']),
      sectionId: json['SectionId'] as int?,
      className: json['Class'] as String?,
      session: json['Session'] as String?,
      section: json['Section'] as String?,
      cautionFee: _toDouble(json['CAUTIONFEE']),
      fatherName: json['FatherName'] as String?,
      fMobileNo: json['FMobileno'] as String?,
      activityFee: _toDouble(json['ActivityFee']),
      boardFee: _toDouble(json['BoardFee']),
      practicalFee: _toDouble(json['PracticalFee']),
      preBoardFees: _toDouble(json['PreBoardFees']),
      tillMonth: json['TillMonth'] as int? ?? 0,
      monthName: json['MonthName'] as String? ?? '',
      totalFeeAmount: _toDouble(json['TotalFeeAmount']) ?? 0.0,
      totalSchoolDiscount: _toDouble(json['TotalSchoolDiscount']) ?? 0.0,
      totalNetFeeAmount: _toDouble(json['TotalNetFeeAmount']) ?? 0.0,
      totalSchoolFee: _toDouble(json['TotalSchoolFee']) ?? 0.0,
      totalNetSchoolFee: _toDouble(json['TotalNetSchoolFee']) ?? 0.0,
      totalSchoolFeePaid: _toDouble(json['TotalSchoolFeePaid']) ?? 0.0,
      totalSchoolDue: _toDouble(json['TotalSchoolDue']) ?? 0.0,
      totalSchoolAdvance: _toDouble(json['TotalSchoolAdvance']) ?? 0.0,
      totalTransportFee: _toDouble(json['TotalTransportFee']) ?? 0.0,
      totalTransportDiscount: _toDouble(json['TotalTransportDiscount']) ?? 0.0,
      totalNetTransportFee: _toDouble(json['TotalNetTransportFee']) ?? 0.0,
      totalTransportFeePaid: _toDouble(json['TotalTransportFeePaid']) ?? 0.0,
      totalTransportDue: _toDouble(json['TotalTransportDue']) ?? 0.0,
      totalTransportAdvance: _toDouble(json['TotalTransportAdvance']) ?? 0.0,
      totalDiscount: _toDouble(json['TotalDiscount']) ?? 0.0,
      grandTotalFee: _toDouble(json['GrandTotalFee']) ?? 0.0,
      totalFee: _toDouble(json['TotalFee']) ?? 0.0,
      totalPaidFee: _toDouble(json['TotalPaidFee']) ?? 0.0,
      totalDueAmount: _toDouble(json['TotalDueAmount']) ?? 0.0,
      totalPaid: _toDouble(json['TotalPaid']) ?? 0.0,
      totalDue: _toDouble(json['TotalDue']) ?? 0.0,
      totalAdvance: _toDouble(json['TotalAdvance']) ?? 0.0,
      isActive: json['IsActive'] as bool? ?? false,
      createdDate: DateTime.tryParse(json['CreatedDate'] as String? ?? '') ??
          DateTime(0001, 1, 1),
      date: DateTime.tryParse(json['Date'] as String? ?? '') ??
          DateTime(0001, 1, 1),
      modifiedDate:
      DateTime.tryParse(json['ModifiedDate'] as String? ?? '') ??
          DateTime(0001, 1, 1),
      createdBy: json['Createdby'] as int? ?? 0,
      updatedBy: json['Updatedby'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FeeType': feeType,
      'TutionFee': tutionFee,
      'TransportFee': transportFee,
      'FeesDuration': feesDuration,
      'AdmissionNo': admissionNo,
      'RegistrationNo': registrationNo,
      'StudentName': studentName,
      'EXAMFEE': examFee,
      'TransportUser': transportUser,
      'REGISTRATIONFEE': registrationFee,
      'ADMISSIONFEE': admissionFee,
      'ANNUALFEE': annualFee,
      'SectionId': sectionId,
      'Class': className,
      'Session': session,
      'Section': section,
      'CAUTIONFEE': cautionFee,
      'FatherName': fatherName,
      'FMobileno': fMobileNo,
      'ActivityFee': activityFee,
      'BoardFee': boardFee,
      'PracticalFee': practicalFee,
      'PreBoardFees': preBoardFees,
      'TillMonth': tillMonth,
      'MonthName': monthName,
      'TotalFeeAmount': totalFeeAmount,
      'TotalSchoolDiscount': totalSchoolDiscount,
      'TotalNetFeeAmount': totalNetFeeAmount,
      'TotalSchoolFee': totalSchoolFee,
      'TotalNetSchoolFee': totalNetSchoolFee,
      'TotalSchoolFeePaid': totalSchoolFeePaid,
      'TotalSchoolDue': totalSchoolDue,
      'TotalSchoolAdvance': totalSchoolAdvance,
      'TotalTransportFee': totalTransportFee,
      'TotalTransportDiscount': totalTransportDiscount,
      'TotalNetTransportFee': totalNetTransportFee,
      'TotalTransportFeePaid': totalTransportFeePaid,
      'TotalTransportDue': totalTransportDue,
      'TotalTransportAdvance': totalTransportAdvance,
      'TotalDiscount': totalDiscount,
      'GrandTotalFee': grandTotalFee,
      'TotalFee': totalFee,
      'TotalPaidFee': totalPaidFee,
      'TotalDueAmount': totalDueAmount,
      'TotalPaid': totalPaid,
      'TotalDue': totalDue,
      'TotalAdvance': totalAdvance,
      'IsActive': isActive,
      'CreatedDate': createdDate.toIso8601String(),
      'Date': date.toIso8601String(),
      'ModifiedDate': modifiedDate.toIso8601String(),
      'Createdby': createdBy,
      'Updatedby': updatedBy,
    };
  }

  // Utility: safely parse num/int/double -> double
  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  @override
  String toString() {
    return 'SessionMonthWiseFee('
        'monthName: $monthName, '
        'totalFee: $totalFee, '
        'totalPaid: $totalPaid, '
        'totalSchoolDue: $totalSchoolDue, '
        'totalTransportDue: $totalTransportDue'
        ')';
  }
}

// ============================================================
// NEW: Helper model — groups multiple session-rows under a
// single month (used so APR/MAY/JUN.. don't repeat as separate
// blocks when the API returns more than one session's data for
// the same month).
// ============================================================
class SessionMonthWiseFeeGroup {
  final String monthName;
  final int tillMonth;
  final List<SessionMonthWiseFee> entries;

  SessionMonthWiseFeeGroup({
    required this.monthName,
    required this.tillMonth,
    required this.entries,
  });
}