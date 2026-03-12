class TotalEmpModel {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  TotalEmpModel({this.message, this.data, this.statuscode, this.totalCount});

  TotalEmpModel.fromJson(Map<String, dynamic> json) {
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
  int? employeeId;
  var employeeId1;
  var employeeName;
  var employeeName1;
  var createBy;
  var updateBy;
  var fatherName;
  var contactNo;
  var dateOfBirth;
  var joinDate;
  var dateOfBirth1;
  var joinDate1;
  var gender;
  var maritalStatus;
  var bloodGroup;
  var email;
  var presentAddress;
  var permanentAddress;
  var aadhaarNo;
  var aadhaarPic;
  var resume;
  var photo;
  var employeeCode;
  var employeeCode1;
  var password;
  var newPassword;
  var confirmPassword;
  var oldPassword;
  var createDate;
  var updateDate;
  var action;
  int? designationId;
  var designation;
  int? roleId;
  var roleType;
  var assignBy;
  int? assignedStatus;
  int? assignedId;
  int? assignById;
  bool? isActive;
  var createdDate;
  var date;
  var modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.employeeId,
        this.employeeId1,
        this.employeeName,
        this.employeeName1,
        this.createBy,
        this.updateBy,
        this.fatherName,
        this.contactNo,
        this.dateOfBirth,
        this.joinDate,
        this.dateOfBirth1,
        this.joinDate1,
        this.gender,
        this.maritalStatus,
        this.bloodGroup,
        this.email,
        this.presentAddress,
        this.permanentAddress,
        this.aadhaarNo,
        this.aadhaarPic,
        this.resume,
        this.photo,
        this.employeeCode,
        this.employeeCode1,
        this.password,
        this.newPassword,
        this.confirmPassword,
        this.oldPassword,
        this.createDate,
        this.updateDate,
        this.action,
        this.designationId,
        this.designation,
        this.roleId,
        this.roleType,
        this.assignBy,
        this.assignedStatus,
        this.assignedId,
        this.assignById,
        this.isActive,
        this.createdDate,
        this.date,
        this.modifiedDate,
        this.createdby,
        this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    employeeId1 = json['EmployeeId1'];
    employeeName = json['EmployeeName'];
    employeeName1 = json['EmployeeName1'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    fatherName = json['FatherName'];
    contactNo = json['ContactNo'];
    dateOfBirth = json['DateOfBirth'];
    joinDate = json['JoinDate'];
    dateOfBirth1 = json['DateOfBirth1'];
    joinDate1 = json['JoinDate1'];
    gender = json['Gender'];
    maritalStatus = json['MaritalStatus'];
    bloodGroup = json['BloodGroup'];
    email = json['Email'];
    presentAddress = json['PresentAddress'];
    permanentAddress = json['PermanentAddress'];
    aadhaarNo = json['AadhaarNo'];
    aadhaarPic = json['AadhaarPic'];
    resume = json['Resume'];
    photo = json['Photo'];
    employeeCode = json['EmployeeCode'];
    employeeCode1 = json['EmployeeCode1'];
    password = json['Password'];
    newPassword = json['NewPassword'];
    confirmPassword = json['ConfirmPassword'];
    oldPassword = json['OldPassword'];
    createDate = json['CreateDate'];
    updateDate = json['UpdateDate'];
    action = json['Action'];
    designationId = json['DesignationId'];
    designation = json['Designation'];
    roleId = json['RoleId'];
    roleType = json['RoleType'];
    assignBy = json['AssignBy'];
    assignedStatus = json['AssignedStatus'];
    assignedId = json['AssignedId'];
    assignById = json['AssignById'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeId'] = this.employeeId;
    data['EmployeeId1'] = this.employeeId1;
    data['EmployeeName'] = this.employeeName;
    data['EmployeeName1'] = this.employeeName1;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
    data['FatherName'] = this.fatherName;
    data['ContactNo'] = this.contactNo;
    data['DateOfBirth'] = this.dateOfBirth;
    data['JoinDate'] = this.joinDate;
    data['DateOfBirth1'] = this.dateOfBirth1;
    data['JoinDate1'] = this.joinDate1;
    data['Gender'] = this.gender;
    data['MaritalStatus'] = this.maritalStatus;
    data['BloodGroup'] = this.bloodGroup;
    data['Email'] = this.email;
    data['PresentAddress'] = this.presentAddress;
    data['PermanentAddress'] = this.permanentAddress;
    data['AadhaarNo'] = this.aadhaarNo;
    data['AadhaarPic'] = this.aadhaarPic;
    data['Resume'] = this.resume;
    data['Photo'] = this.photo;
    data['EmployeeCode'] = this.employeeCode;
    data['EmployeeCode1'] = this.employeeCode1;
    data['Password'] = this.password;
    data['NewPassword'] = this.newPassword;
    data['ConfirmPassword'] = this.confirmPassword;
    data['OldPassword'] = this.oldPassword;
    data['CreateDate'] = this.createDate;
    data['UpdateDate'] = this.updateDate;
    data['Action'] = this.action;
    data['DesignationId'] = this.designationId;
    data['Designation'] = this.designation;
    data['RoleId'] = this.roleId;
    data['RoleType'] = this.roleType;
    data['AssignBy'] = this.assignBy;
    data['AssignedStatus'] = this.assignedStatus;
    data['AssignedId'] = this.assignedId;
    data['AssignById'] = this.assignById;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
