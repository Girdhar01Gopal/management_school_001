class Login_Model {
  String? message;
  Data? data;
  int? statuscode;
  int? totalCount;

  Login_Model({this.message, this.data, this.statuscode, this.totalCount});

  Login_Model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statuscode = json['statuscode'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statuscode'] = this.statuscode;
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class Data {
  var userName;
  var password;
  String? registrationNo;
  var admissionNo;
  String? session;
  String? studentName;
  String? sex;
  var placeofBirth;
  String? dOB;
  var age;
  int? classId;
  String? classs;
  String? section;
  int? sectionId;
  String? parentID;
  String? studentPic;
  String? ppassword;
  int? studentId;
  String? fatherName;
  String? fMobileno;
  String? motherName;
  String? fAddressRes;
  var dropPoint;
  String? fEmail;
  String? uploadLogo1;
  String? schoolName;
  String? schoolId;
  int? passwordStatus;
  String? className;
  var approvedRemarks;
  var bloodGroup;
  var mEmail;
  int? iD;
  var appVer;
  var modle;
  var oS;
  var networkType;
  var osVer;
  var forceUpdate;
  var updateNew;
  var loginID;
  String? loginDate;
  String? action;
  bool? isActive;
  String? createdDate;
  String? date;
  String? modifiedDate;
  int? createdby;
  int? updatedby;

  Data(
      {this.userName,
        this.password,
        this.registrationNo,
        this.admissionNo,
        this.session,
        this.studentName,
        this.sex,
        this.placeofBirth,
        this.dOB,
        this.age,
        this.classId,
        this.classs,
        this.section,
        this.sectionId,
        this.parentID,
        this.studentPic,
        this.ppassword,
        this.studentId,
        this.fatherName,
        this.fMobileno,
        this.motherName,
        this.fAddressRes,
        this.dropPoint,
        this.fEmail,
        this.uploadLogo1,
        this.schoolName,
        this.schoolId,
        this.passwordStatus,
        this.className,
        this.approvedRemarks,
        this.bloodGroup,
        this.mEmail,
        this.iD,
        this.appVer,
        this.modle,
        this.oS,
        this.networkType,
        this.osVer,
        this.forceUpdate,
        this.updateNew,
        this.loginID,
        this.loginDate,
        this.action,
        this.isActive,
        this.createdDate,
        this.date,
        this.modifiedDate,
        this.createdby,
        this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    password = json['Password'];
    registrationNo = json['RegistrationNo'];
    admissionNo = json['AdmissionNo'];
    session = json['Session'];
    studentName = json['StudentName'];
    sex = json['Sex'];
    placeofBirth = json['PlaceofBirth'];
    dOB = json['DOB'];
    age = json['Age'];
    classId = json['ClassId'];
    classs = json['Classs'];
    section = json['Section'];
    sectionId = json['SectionId'];
    parentID = json['ParentID'];
    studentPic = json['StudentPic'];
    ppassword = json['Ppassword'];
    studentId = json['StudentId'];
    fatherName = json['FatherName'];
    fMobileno = json['FMobileno'];
    motherName = json['MotherName'];
    fAddressRes = json['FAddressRes'];
    dropPoint = json['DropPoint'];
    fEmail = json['FEmail'];
    uploadLogo1 = json['UploadLogo1'];
    schoolName = json['SchoolName'];
    schoolId = json['SchoolId'];
    passwordStatus = json['PasswordStatus'];
    className = json['ClassName'];
    approvedRemarks = json['ApprovedRemarks'];
    bloodGroup = json['BloodGroup'];
    mEmail = json['MEmail'];
    iD = json['ID'];
    appVer = json['AppVer'];
    modle = json['Modle'];
    oS = json['OS'];
    networkType = json['NetworkType'];
    osVer = json['OsVer'];
    forceUpdate = json['ForceUpdate'];
    updateNew = json['UpdateNew'];
    loginID = json['LoginID'];
    loginDate = json['LoginDate'];
    action = json['Action'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['RegistrationNo'] = this.registrationNo;
    data['AdmissionNo'] = this.admissionNo;
    data['Session'] = this.session;
    data['StudentName'] = this.studentName;
    data['Sex'] = this.sex;
    data['PlaceofBirth'] = this.placeofBirth;
    data['DOB'] = this.dOB;
    data['Age'] = this.age;
    data['ClassId'] = this.classId;
    data['Classs'] = this.classs;
    data['Section'] = this.section;
    data['SectionId'] = this.sectionId;
    data['ParentID'] = this.parentID;
    data['StudentPic'] = this.studentPic;
    data['Ppassword'] = this.ppassword;
    data['StudentId'] = this.studentId;
    data['FatherName'] = this.fatherName;
    data['FMobileno'] = this.fMobileno;
    data['MotherName'] = this.motherName;
    data['FAddressRes'] = this.fAddressRes;
    data['DropPoint'] = this.dropPoint;
    data['FEmail'] = this.fEmail;
    data['UploadLogo1'] = this.uploadLogo1;
    data['SchoolName'] = this.schoolName;
    data['SchoolId'] = this.schoolId;
    data['PasswordStatus'] = this.passwordStatus;
    data['ClassName'] = this.className;
    data['ApprovedRemarks'] = this.approvedRemarks;
    data['BloodGroup'] = this.bloodGroup;
    data['MEmail'] = this.mEmail;
    data['Action'] = this.action;
    data['ID'] = this.iD;
    data['AppVer'] = this.appVer;
    data['Modle'] = this.modle;
    data['OS'] = this.oS;
    data['NetworkType'] = this.networkType;
    data['OsVer'] = this.osVer;
    data['ForceUpdate'] = this.forceUpdate;
    data['UpdateNew'] = this.updateNew;
    data['LoginID'] = this.loginID;
    data['LoginDate'] = this.loginDate;
    data['Action'] = this.action;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
