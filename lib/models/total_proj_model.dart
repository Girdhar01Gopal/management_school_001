class TotalProjModel {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  TotalProjModel({this.message, this.data, this.statuscode, this.totalCount});

  TotalProjModel.fromJson(Map<String, dynamic> json) {
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
  int? sProjectId;
  var projectName;
  var clientName;
  var mobileNo;
  var projectDate;
  var projectDate1;
  var deliveryDate;
  var deliveryDate1;
  var assignDate;
  var description;
  var email;
  var remark;
  int? productId;
  int? subProductId;
  int? employeeId;
  int? employeeId1;
  int? employeeId21;
  var employeeName;
  var employeeName1;
  var createBy;
  var updateBy;
  var createDate;
  var updateDate;
  var action;
  var productService;
  var subProductService;
  var assignBy;
  var uploadImage;
  var uploadImage1;
  int? assignId;
  var proGress;
  var projectDetails;
  var referenceURL;
  var uploadProjectImg;
  var module1;
  var module2;
  var module3;
  var module4;
  var module5;
  var module6;
  var module7;
  var module8;
  var module9;
  var module10;
  int? assignById;
  int? proAllocatId;
  var proDescription;
  var deliveryEstimateDate;
  var deliveryEstimateDate1;
  var tokenId;
  var projectStatus;
  var uploadAllotFile;
  bool? isActive;
  var createdDate;
  var date;
  var modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.sProjectId,
        this.projectName,
        this.clientName,
        this.mobileNo,
        this.projectDate,
        this.projectDate1,
        this.deliveryDate,
        this.deliveryDate1,
        this.assignDate,
        this.description,
        this.email,
        this.remark,
        this.productId,
        this.subProductId,
        this.employeeId,
        this.employeeId1,
        this.employeeId21,
        this.employeeName,
        this.employeeName1,
        this.createBy,
        this.updateBy,
        this.createDate,
        this.updateDate,
        this.action,
        this.productService,
        this.subProductService,
        this.assignBy,
        this.uploadImage,
        this.uploadImage1,
        this.assignId,
        this.proGress,
        this.projectDetails,
        this.referenceURL,
        this.uploadProjectImg,
        this.module1,
        this.module2,
        this.module3,
        this.module4,
        this.module5,
        this.module6,
        this.module7,
        this.module8,
        this.module9,
        this.module10,
        this.assignById,
        this.proAllocatId,
        this.proDescription,
        this.deliveryEstimateDate,
        this.deliveryEstimateDate1,
        this.tokenId,
        this.projectStatus,
        this.uploadAllotFile,
        this.isActive,
        this.createdDate,
        this.date,
        this.modifiedDate,
        this.createdby,
        this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    sProjectId = json['SProjectId'];
    projectName = json['ProjectName'];
    clientName = json['ClientName'];
    mobileNo = json['MobileNo'];
    projectDate = json['ProjectDate'];
    projectDate1 = json['ProjectDate1'];
    deliveryDate = json['DeliveryDate'];
    deliveryDate1 = json['DeliveryDate1'];
    assignDate = json['AssignDate'];
    description = json['Description'];
    email = json['Email'];
    remark = json['Remark'];
    productId = json['ProductId'];
    subProductId = json['SubProductId'];
    employeeId = json['EmployeeId'];
    employeeId1 = json['EmployeeId1'];
    employeeId21 = json['EmployeeId21'];
    employeeName = json['EmployeeName'];
    employeeName1 = json['EmployeeName1'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    action = json['Action'];
    productService = json['ProductService'];
    subProductService = json['SubProductService'];
    assignBy = json['AssignBy'];
    uploadImage = json['UploadImage'];
    uploadImage1 = json['UploadImage1'];
    assignId = json['AssignId'];
    proGress = json['ProGress'];
    projectDetails = json['ProjectDetails'];
    referenceURL = json['ReferenceURL'];
    uploadProjectImg = json['UploadProjectImg'];
    module1 = json['Module1'];
    module2 = json['Module2'];
    module3 = json['Module3'];
    module4 = json['Module4'];
    module5 = json['Module5'];
    module6 = json['Module6'];
    module7 = json['Module7'];
    module8 = json['Module8'];
    module9 = json['Module9'];
    module10 = json['Module10'];
    assignById = json['AssignById'];
    proAllocatId = json['ProAllocatId'];
    proDescription = json['ProDescription'];
    deliveryEstimateDate = json['DeliveryEstimateDate'];
    deliveryEstimateDate1 = json['DeliveryEstimateDate1'];
    tokenId = json['TokenId'];
    projectStatus = json['ProjectStatus'];
    uploadAllotFile = json['UploadAllotFile'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SProjectId'] = this.sProjectId;
    data['ProjectName'] = this.projectName;
    data['ClientName'] = this.clientName;
    data['MobileNo'] = this.mobileNo;
    data['ProjectDate'] = this.projectDate;
    data['ProjectDate1'] = this.projectDate1;
    data['DeliveryDate'] = this.deliveryDate;
    data['DeliveryDate1'] = this.deliveryDate1;
    data['AssignDate'] = this.assignDate;
    data['Description'] = this.description;
    data['Email'] = this.email;
    data['Remark'] = this.remark;
    data['ProductId'] = this.productId;
    data['SubProductId'] = this.subProductId;
    data['EmployeeId'] = this.employeeId;
    data['EmployeeId1'] = this.employeeId1;
    data['EmployeeId21'] = this.employeeId21;
    data['EmployeeName'] = this.employeeName;
    data['EmployeeName1'] = this.employeeName1;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
    data['CreateDate'] = this.createDate;
    data['UpdateDate'] = this.updateDate;
    data['Action'] = this.action;
    data['ProductService'] = this.productService;
    data['SubProductService'] = this.subProductService;
    data['AssignBy'] = this.assignBy;
    data['UploadImage'] = this.uploadImage;
    data['UploadImage1'] = this.uploadImage1;
    data['AssignId'] = this.assignId;
    data['ProGress'] = this.proGress;
    data['ProjectDetails'] = this.projectDetails;
    data['ReferenceURL'] = this.referenceURL;
    data['UploadProjectImg'] = this.uploadProjectImg;
    data['Module1'] = this.module1;
    data['Module2'] = this.module2;
    data['Module3'] = this.module3;
    data['Module4'] = this.module4;
    data['Module5'] = this.module5;
    data['Module6'] = this.module6;
    data['Module7'] = this.module7;
    data['Module8'] = this.module8;
    data['Module9'] = this.module9;
    data['Module10'] = this.module10;
    data['AssignById'] = this.assignById;
    data['ProAllocatId'] = this.proAllocatId;
    data['ProDescription'] = this.proDescription;
    data['DeliveryEstimateDate'] = this.deliveryEstimateDate;
    data['DeliveryEstimateDate1'] = this.deliveryEstimateDate1;
    data['TokenId'] = this.tokenId;
    data['ProjectStatus'] = this.projectStatus;
    data['UploadAllotFile'] = this.uploadAllotFile;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
