class ReceiptModelClass {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  ReceiptModelClass(
      {this.message, this.data, this.statuscode, this.totalCount});

  ReceiptModelClass.fromJson(Map<String, dynamic> json) {
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
  int? onID;
  String? receiptNo;
  String? admissionNo;
  String? paydate;
  String? classs;
  String? sec;
  String? studentName;
  String? feeType;
  String? term;
  String? rs;
  int? amount;
  String? paymentMode;
  String? dDNO;
  String? dDDate;
  String? bank;
  int? action;
  var createBy;
  String? createDate;
  var schoolId;
  var iPAddress;
  String? session;
  var numbertoword;
  String? transportUser;
  var dropPoint;
  var routname;
  String? routeName;
  bool? isActive;
  String? createdDate;
  String? date;
  String? modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.onID,
      this.receiptNo,
      this.admissionNo,
      this.paydate,
      this.classs,
      this.sec,
      this.studentName,
      this.feeType,
      this.term,
      this.rs,
      this.amount,
      this.paymentMode,
      this.dDNO,
      this.dDDate,
      this.bank,
      this.action,
      this.createBy,
      this.createDate,
      this.schoolId,
      this.iPAddress,
      this.session,
      this.numbertoword,
      this.transportUser,
      this.dropPoint,
      this.routname,
      this.routeName,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    onID = json['OnID'];
    receiptNo = json['ReceiptNo'];
    admissionNo = json['AdmissionNo'];
    paydate = json['Paydate'];
    classs = json['Classs'];
    sec = json['Sec'];
    studentName = json['StudentName'];
    feeType = json['FeeType'];
    term = json['Term'];
    rs = json['Rs'];
    amount = json['Amount'];
    paymentMode = json['PaymentMode'];
    dDNO = json['DDNO'];
    dDDate = json['DDDate'];
    bank = json['Bank'];
    action = json['Action'];
    createBy = json['CreateBy'];
    createDate = json['CreateDate'];
    schoolId = json['SchoolId'];
    iPAddress = json['IPAddress'];
    session = json['Session'];
    numbertoword = json['Numbertoword'];
    transportUser = json['TransportUser'];
    dropPoint = json['DropPoint'];
    routname = json['Routname'];
    routeName = json['RouteName'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OnID'] = this.onID;
    data['ReceiptNo'] = this.receiptNo;
    data['AdmissionNo'] = this.admissionNo;
    data['Paydate'] = this.paydate;
    data['Classs'] = this.classs;
    data['Sec'] = this.sec;
    data['StudentName'] = this.studentName;
    data['FeeType'] = this.feeType;
    data['Term'] = this.term;
    data['Rs'] = this.rs;
    data['Amount'] = this.amount;
    data['PaymentMode'] = this.paymentMode;
    data['DDNO'] = this.dDNO;
    data['DDDate'] = this.dDDate;
    data['Bank'] = this.bank;
    data['Action'] = this.action;
    data['CreateBy'] = this.createBy;
    data['CreateDate'] = this.createDate;
    data['SchoolId'] = this.schoolId;
    data['IPAddress'] = this.iPAddress;
    data['Session'] = this.session;
    data['Numbertoword'] = this.numbertoword;
    data['TransportUser'] = this.transportUser;
    data['DropPoint'] = this.dropPoint;
    data['Routname'] = this.routname;
    data['RouteName'] = this.routeName;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
