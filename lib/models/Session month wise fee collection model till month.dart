// session_month_wise_fee_collection_model.dart
//
// Model for:
// GET {baseUrl}api/FMSCoreApi/SessionWithMonthWiseFeeCollectionTillMonth/{session}/{tillMonth}
//
// The API returns one row per month (APR, MAY, JUN, JUL, ...) for each
// session, plus a final row with MonthName == "Total" holding the
// aggregated totals for that session up to the requested month.

double? _toDouble(dynamic v) {
  if (v == null) return null;
  if (v is int) return v.toDouble();
  if (v is double) return v;
  return double.tryParse(v.toString());
}

int? _toInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is double) return v.toInt();
  return int.tryParse(v.toString());
}

class SessionMonthWiseFeeCollectionModel {
  final String? message;
  final List<MonthWiseFeeData> data;
  final int? statuscode;
  final int? totalCount;

  SessionMonthWiseFeeCollectionModel({
    this.message,
    this.data = const [],
    this.statuscode,
    this.totalCount,
  });

  factory SessionMonthWiseFeeCollectionModel.fromJson(
      Map<String, dynamic> json) {
    return SessionMonthWiseFeeCollectionModel(
      message: json['message']?.toString(),
      data: json['data'] != null
          ? List<MonthWiseFeeData>.from(
          (json['data'] as List).map((x) => MonthWiseFeeData.fromJson(x)))
          : <MonthWiseFeeData>[],
      statuscode: _toInt(json['statuscode']),
      totalCount: _toInt(json['totalCount']),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data.map((x) => x.toJson()).toList(),
    'statuscode': statuscode,
    'totalCount': totalCount,
  };
}

class MonthWiseFeeData {
  final String? feeType;
  final String? tutionFee;
  final String? transportFee;
  final String? feesDuration;
  final String? admissionNo;
  final String? registrationNo;
  final String? studentName;
  final String? examFee;
  final String? transportUser;
  final String? registrationFee;
  final String? admissionFee;
  final String? annualFee;
  final int? sectionId;
  final String? className;
  final String? session;
  final String? section;
  final String? cautionFee;
  final String? fatherName;
  final String? fMobileno;
  final String? activityFee;
  final String? boardFee;
  final String? practicalFee;
  final String? preBoardFees;

  final int? tillMonth;
  final String? monthName;

  final double? totalFeeAmount;
  final double? totalSchoolDiscount;
  final double? totalNetFeeAmount;
  final double? totalTransportFee;
  final double? totalTransportDiscount;
  final double? totalNetTransportFee;
  final double? totalDiscount;
  final double? grandTotalFee;

  final double? totalSchoolFeePaid;
  final double? totalTransportFeePaid;
  final double? totalPaidFee;
  final double? totalDueAmount;

  final double? totalFee;
  final double? totalPaid;
  final double? totalDue;

  final double? totalSchoolFee;
  final double? totalNetSchoolFee;
  final double? totalAdvance;
  final double? totalSchoolDue;
  final double? totalSchoolAdvance;
  final double? totalTransportDue;
  final double? totalTransportAdvance;

  final bool? isActive;
  final String? createdDate;
  final String? date;
  final String? modifiedDate;
  final int? createdby;
  final int? updatedby;

  MonthWiseFeeData({
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
    this.fMobileno,
    this.activityFee,
    this.boardFee,
    this.practicalFee,
    this.preBoardFees,
    this.tillMonth,
    this.monthName,
    this.totalFeeAmount,
    this.totalSchoolDiscount,
    this.totalNetFeeAmount,
    this.totalTransportFee,
    this.totalTransportDiscount,
    this.totalNetTransportFee,
    this.totalDiscount,
    this.grandTotalFee,
    this.totalSchoolFeePaid,
    this.totalTransportFeePaid,
    this.totalPaidFee,
    this.totalDueAmount,
    this.totalFee,
    this.totalPaid,
    this.totalDue,
    this.totalSchoolFee,
    this.totalNetSchoolFee,
    this.totalAdvance,
    this.totalSchoolDue,
    this.totalSchoolAdvance,
    this.totalTransportDue,
    this.totalTransportAdvance,
    this.isActive,
    this.createdDate,
    this.date,
    this.modifiedDate,
    this.createdby,
    this.updatedby,
  });

  factory MonthWiseFeeData.fromJson(Map<String, dynamic> json) {
    return MonthWiseFeeData(
      feeType: json['FeeType']?.toString(),
      tutionFee: json['TutionFee']?.toString(),
      transportFee: json['TransportFee']?.toString(),
      feesDuration: json['FeesDuration']?.toString(),
      admissionNo: json['AdmissionNo']?.toString(),
      registrationNo: json['RegistrationNo']?.toString(),
      studentName: json['StudentName']?.toString(),
      examFee: json['EXAMFEE']?.toString(),
      transportUser: json['TransportUser']?.toString(),
      registrationFee: json['REGISTRATIONFEE']?.toString(),
      admissionFee: json['ADMISSIONFEE']?.toString(),
      annualFee: json['ANNUALFEE']?.toString(),
      sectionId: _toInt(json['SectionId']),
      className: json['Class']?.toString(),
      session: json['Session']?.toString(),
      section: json['Section']?.toString(),
      cautionFee: json['CAUTIONFEE']?.toString(),
      fatherName: json['FatherName']?.toString(),
      fMobileno: json['FMobileno']?.toString(),
      activityFee: json['ActivityFee']?.toString(),
      boardFee: json['BoardFee']?.toString(),
      practicalFee: json['PracticalFee']?.toString(),
      preBoardFees: json['PreBoardFees']?.toString(),
      tillMonth: _toInt(json['TillMonth']),
      monthName: json['MonthName']?.toString(),
      totalFeeAmount: _toDouble(json['TotalFeeAmount']),
      totalSchoolDiscount: _toDouble(json['TotalSchoolDiscount']),
      totalNetFeeAmount: _toDouble(json['TotalNetFeeAmount']),
      totalTransportFee: _toDouble(json['TotalTransportFee']),
      totalTransportDiscount: _toDouble(json['TotalTransportDiscount']),
      totalNetTransportFee: _toDouble(json['TotalNetTransportFee']),
      totalDiscount: _toDouble(json['TotalDiscount']),
      grandTotalFee: _toDouble(json['GrandTotalFee']),
      totalSchoolFeePaid: _toDouble(json['TotalSchoolFeePaid']),
      totalTransportFeePaid: _toDouble(json['TotalTransportFeePaid']),
      totalPaidFee: _toDouble(json['TotalPaidFee']),
      totalDueAmount: _toDouble(json['TotalDueAmount']),
      totalFee: _toDouble(json['TotalFee']),
      totalPaid: _toDouble(json['TotalPaid']),
      totalDue: _toDouble(json['TotalDue']),
      totalSchoolFee: _toDouble(json['TotalSchoolFee']),
      totalNetSchoolFee: _toDouble(json['TotalNetSchoolFee']),
      totalAdvance: _toDouble(json['TotalAdvance']),
      totalSchoolDue: _toDouble(json['TotalSchoolDue']),
      totalSchoolAdvance: _toDouble(json['TotalSchoolAdvance']),
      totalTransportDue: _toDouble(json['TotalTransportDue']),
      totalTransportAdvance: _toDouble(json['TotalTransportAdvance']),
      isActive: json['IsActive'] is bool ? json['IsActive'] : null,
      createdDate: json['CreatedDate']?.toString(),
      date: json['Date']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      createdby: _toInt(json['Createdby']),
      updatedby: _toInt(json['Updatedby']),
    );
  }

  Map<String, dynamic> toJson() => {
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
    'FMobileno': fMobileno,
    'ActivityFee': activityFee,
    'BoardFee': boardFee,
    'PracticalFee': practicalFee,
    'PreBoardFees': preBoardFees,
    'TillMonth': tillMonth,
    'MonthName': monthName,
    'TotalFeeAmount': totalFeeAmount,
    'TotalSchoolDiscount': totalSchoolDiscount,
    'TotalNetFeeAmount': totalNetFeeAmount,
    'TotalTransportFee': totalTransportFee,
    'TotalTransportDiscount': totalTransportDiscount,
    'TotalNetTransportFee': totalNetTransportFee,
    'TotalDiscount': totalDiscount,
    'GrandTotalFee': grandTotalFee,
    'TotalSchoolFeePaid': totalSchoolFeePaid,
    'TotalTransportFeePaid': totalTransportFeePaid,
    'TotalPaidFee': totalPaidFee,
    'TotalDueAmount': totalDueAmount,
    'TotalFee': totalFee,
    'TotalPaid': totalPaid,
    'TotalDue': totalDue,
    'TotalSchoolFee': totalSchoolFee,
    'TotalNetSchoolFee': totalNetSchoolFee,
    'TotalAdvance': totalAdvance,
    'TotalSchoolDue': totalSchoolDue,
    'TotalSchoolAdvance': totalSchoolAdvance,
    'TotalTransportDue': totalTransportDue,
    'TotalTransportAdvance': totalTransportAdvance,
    'IsActive': isActive,
    'CreatedDate': createdDate,
    'Date': date,
    'ModifiedDate': modifiedDate,
    'Createdby': createdby,
    'Updatedby': updatedby,
  };
}