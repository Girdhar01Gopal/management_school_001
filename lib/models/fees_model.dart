class FeesModelClass {
  String? message;
  List<FData>? data;
  int? statuscode;
  int? totalCount;

  FeesModelClass({this.message, this.data, this.statuscode, this.totalCount});

  FeesModelClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <FData>[];
      json['data'].forEach((v) {
        data!.add(new FData.fromJson(v));
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

class FData {
  var pAId;
  var registrationNo;
  var studentName;
  var session;
  var payDate;
  var feeMonth;
  var totalAmount;
  var payAmount;
  var dueAmount;
  var totalPay;
  var discount;
  var action;
  var createBy;
  var receiptno;
  var modePaymentOnline;
  var paymentId;
  var paymentMode;
  var updateBy;
  var reply;
  var replyDate;
  var fee;
  var feeType;
  var feetype;
  var monthName;
  var schoolId;
  bool? isActive;
  var createdDate;
  var date;
  var modifiedDate;
  var createdby;
  var updatedby;

  FData(
      {this.pAId,
      this.registrationNo,
      this.studentName,
      this.session,
      this.payDate,
      this.feeMonth,
      this.totalAmount,
      this.payAmount,
      this.dueAmount,
      this.totalPay,
      this.discount,
      this.action,
      this.createBy,
      this.receiptno,
      this.modePaymentOnline,
      this.paymentId,
      this.paymentMode,
      this.updateBy,
      this.reply,
      this.replyDate,
      this.fee,
      this.feeType,
      this.feetype,
      this.monthName,
      this.schoolId,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  FData.fromJson(Map<String, dynamic> json) {
    pAId = json['PAId'];
    registrationNo = json['RegistrationNo'];
    studentName = json['StudentName'];
    session = json['Session'];
    payDate = json['PayDate'];
    feeMonth = json['FeeMonth'];
    totalAmount = json['TotalAmount'];
    payAmount = json['PayAmount'];
    dueAmount = json['DueAmount'];
    totalPay = json['TotalPay'];
    discount = json['Discount'];
    action = json['Action'];
    createBy = json['CreateBy'];
    receiptno = json['Receiptno'];
    modePaymentOnline = json['ModePaymentOnline'];
    paymentId = json['PaymentId'];
    paymentMode = json['PaymentMode'];
    updateBy = json['UpdateBy'];
    reply = json['Reply'];
    replyDate = json['ReplyDate'];
    fee = json['Fee'];
    feeType = json['FeeType'];
    feetype = json['Feetype'];
    monthName = json['MonthName'];
    schoolId = json['SchoolId'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PAId'] = this.pAId;
    data['RegistrationNo'] = this.registrationNo;
    data['StudentName'] = this.studentName;
    data['Session'] = this.session;
    data['PayDate'] = this.payDate;
    data['FeeMonth'] = this.feeMonth;
    data['TotalAmount'] = this.totalAmount;
    data['PayAmount'] = this.payAmount;
    data['DueAmount'] = this.dueAmount;
    data['TotalPay'] = this.totalPay;
    data['Discount'] = this.discount;
    data['Action'] = this.action;
    data['CreateBy'] = this.createBy;
    data['Receiptno'] = this.receiptno;
    data['ModePaymentOnline'] = this.modePaymentOnline;
    data['PaymentId'] = this.paymentId;
    data['PaymentMode'] = this.paymentMode;
    data['UpdateBy'] = this.updateBy;
    data['Reply'] = this.reply;
    data['ReplyDate'] = this.replyDate;
    data['Fee'] = this.fee;
    data['FeeType'] = this.feeType;
    data['Feetype'] = this.feetype;
    data['MonthName'] = this.monthName;
    data['SchoolId'] = this.schoolId;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
