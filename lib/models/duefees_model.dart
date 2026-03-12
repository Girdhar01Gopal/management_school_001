class DueFeesModel {
  final String? message;
  final List<DueFeesRow> data;
  final int? statusCode;
  final int? totalCount;

  const DueFeesModel({
    this.message,
    this.data = const [],
    this.statusCode,
    this.totalCount,
  });

  factory DueFeesModel.fromJson(Map<String, dynamic> json) => DueFeesModel(
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>? ?? [])
            .map((v) => DueFeesRow.fromJson(v as Map<String, dynamic>))
            .toList(),
        statusCode: json['statuscode'] as int?,
        totalCount: json['totalCount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data.map((e) => e.toJson()).toList(),
        'statuscode': statusCode,
        'totalCount': totalCount,
      };
}

class DueFeesRow {
  final String? registrationNo;
  final int? studentId;
  final String? studentName;
  final num? amount;

  final String? feesHead;
  final String? mappingPayMonth;
  final String? session;
  final String? action;

  final int? classId;
  final String? studentClass;

  final int? sectionId;
  final String? section;

  final String? feeType;
  final String? feesDuration;

  final num? discount;

  /// months → stored as flags (true if that month is active)
  final bool january;
  final bool february;
  final bool march;
  final bool april;
  final bool may;
  final bool june;
  final bool july;
  final bool august;
  final bool september;
  final bool october;
  final bool november;
  final bool december;

  final int? schoolId;
  final int? feeTypeId;
  final int? deleteBy;
  final bool? isActive;

  final DateTime? createdDate;
  final DateTime? date;
  final DateTime? modifiedDate;

  final int? createdBy;
  final int? updatedBy;

  const DueFeesRow({
    this.registrationNo,
    this.studentId,
    this.studentName,
    this.amount,
    this.feesHead,
    this.mappingPayMonth,
    this.session,
    this.action,
    this.classId,
    this.studentClass,
    this.sectionId,
    this.section,
    this.feeType,
    this.feesDuration,
    this.discount,
    this.january = false,
    this.february = false,
    this.march = false,
    this.april = false,
    this.may = false,
    this.june = false,
    this.july = false,
    this.august = false,
    this.september = false,
    this.october = false,
    this.november = false,
    this.december = false,
    this.schoolId,
    this.feeTypeId,
    this.deleteBy,
    this.isActive,
    this.createdDate,
    this.date,
    this.modifiedDate,
    this.createdBy,
    this.updatedBy,
  });

  static num? _numOf(dynamic v) {
    if (v == null) return null;
    if (v is num) return v;
    return num.tryParse(v.toString());
  }

  static int? _intOf(dynamic v) => _numOf(v)?.toInt();

  static bool _monthVal(dynamic v, String monthName) {
    if (v == null) return false;
    final s = v.toString().toLowerCase();
    if (s == 'false' || s.isEmpty) return false;
    // if API returns the month name itself ("April", "May", etc.), treat as true
    if (s == monthName.toLowerCase()) return true;
    return s == 'true' || s == '1';
  }

  static DateTime? _dtOf(dynamic v) {
    if (v == null) return null;
    try {
      return DateTime.parse(v.toString());
    } catch (_) {
      return null;
    }
  }

  factory DueFeesRow.fromJson(Map<String, dynamic> json) => DueFeesRow(
        registrationNo: json['RegistrationNo'] as String?,
        studentId: _intOf(json['StudentId']),
        studentName: json['StudentName'] as String?,
        amount: _numOf(json['Amount']),
        feesHead: json['FeesHead'] as String?,
        mappingPayMonth: json['MappingPayMonth'] as String?,
        session: json['Session'] as String?,
        action: json['Action'] as String?,
        classId: _intOf(json['ClassId']),
        studentClass: json['Class'] as String?,
        sectionId: _intOf(json['SectionId']),
        section: json['Section'] as String?,
        feeType: json['FeeType'] as String?,
        feesDuration: json['FeesDuration'] as String?,
        discount: _numOf(json['Discount']),
        january: _monthVal(json['January'], 'january'),
        february: _monthVal(json['February'], 'february'),
        march: _monthVal(json['March'], 'march'),
        april: _monthVal(json['April'], 'april'),
        may: _monthVal(json['May'], 'may'),
        june: _monthVal(json['June'], 'june'),
        july: _monthVal(json['July'], 'july'),
        august: _monthVal(json['August'], 'august'),
        september: _monthVal(json['September'], 'september'),
        october: _monthVal(json['October'], 'october'),
        november: _monthVal(json['November'], 'november'),
        december: _monthVal(json['December'], 'december'),
        schoolId: _intOf(json['SchoolId']),
        feeTypeId: _intOf(json['FeeTypeId']),
        deleteBy: _intOf(json['DeleteBy']),
        isActive: json['IsActive'] as bool?,
        createdDate: _dtOf(json['CreatedDate']),
        date: _dtOf(json['Date']),
        modifiedDate: _dtOf(json['ModifiedDate']),
        createdBy: _intOf(json['Createdby']),
        updatedBy: _intOf(json['Updatedby']),
      );

  Map<String, dynamic> toJson() => {
        'RegistrationNo': registrationNo,
        'StudentId': studentId,
        'StudentName': studentName,
        'Amount': amount,
        'FeesHead': feesHead,
        'MappingPayMonth': mappingPayMonth,
        'Session': session,
        'Action': action,
        'ClassId': classId,
        'Class': studentClass,
        'SectionId': sectionId,
        'Section': section,
        'FeeType': feeType,
        'FeesDuration': feesDuration,
        'Discount': discount,
        'January': january,
        'February': february,
        'March': march,
        'April': april,
        'May': may,
        'June': june,
        'July': july,
        'August': august,
        'September': september,
        'October': october,
        'November': november,
        'December': december,
        'SchoolId': schoolId,
        'FeeTypeId': feeTypeId,
        'DeleteBy': deleteBy,
        'IsActive': isActive,
        'CreatedDate': createdDate?.toIso8601String(),
        'Date': date?.toIso8601String(),
        'ModifiedDate': modifiedDate?.toIso8601String(),
        'Createdby': createdBy,
        'Updatedby': updatedBy,
      };
}
