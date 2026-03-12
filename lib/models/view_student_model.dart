class ApiResponse {
  List<Student>? data;
  int? statusCode;
  int? totalCount;

  ApiResponse({
     this.data,
     this.statusCode,
     this.totalCount,
  });

  // Factory method to create ApiResponse object from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Student> students = dataList.map((studentJson) => Student.fromJson(studentJson)).toList();

    return ApiResponse(
      data: students,
      statusCode: json['statuscode'],
      totalCount: json['totalCount'],
    );
  }
}

class Student {
  var userName;
  var password;
  var registrationNo;
  var admissionNo;
  var session;
  var studentName;
  var sex;
  var placeOfBirth;
  var dob;
  var age;
  var classId;
  var className;
  var section;
  var sectionId;
  var parentId;
  var studentPic;
  var ppassword;
  var studentId;
  var fatherName;
  var fMobileNo;
  var motherName;
  var fAddressRes;
  var dropPoint;
  var fEmail;
  var uploadLogo1;
  var schoolName;
  var schoolId;
  var passwordStatus;
  var approvedRemarks;
  var bloodGroup;
  var mEmail;
  var id;
  var isActive;

  Student({
    this.userName,
    this.password,
    this.registrationNo,
    this.admissionNo,
    this.session,
    this.studentName,
    this.sex,
    this.placeOfBirth,
    this.dob,
    this.age,
    this.classId,
    this.className,
    this.section,
    this.sectionId,
    this.parentId,
    this.studentPic,
    this.ppassword,
    this.studentId,
    this.fatherName,
    this.fMobileNo,
    this.motherName,
    this.fAddressRes,
    this.dropPoint,
    this.fEmail,
    this.uploadLogo1,
    this.schoolName,
    this.schoolId,
    this.passwordStatus,
    this.approvedRemarks,
    this.bloodGroup,
    this.mEmail,
    this.id,
    this.isActive,
  });

  // Factory method to create a Student object from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      userName: json['UserName'],
      password: json['Password'],
      registrationNo: json['RegistrationNo'],
      admissionNo: json['AdmissionNo'],
      session: json['Session'],
      studentName: json['StudentName'],
      sex: json['Sex'],
      placeOfBirth: json['PlaceofBirth'],
      dob: json['DOB'] != null ? DateTime.parse(json['DOB']) : null,
      age: json['Age'],
      classId: json['ClassId'],
      className: json['Class'] ?? "",
      section: json['Section'],
      sectionId: json['SectionId'],
      parentId: json['ParentID'],
      studentPic: json['StudentPic'],
      ppassword: json['Ppassword'],
      studentId: json['StudentId'],
      fatherName: json['FatherName'],
      fMobileNo: json['FMobileno'],
      motherName: json['MotherName'],
      fAddressRes: json['FAddressRes'],
      dropPoint: json['DropPoint'],
      fEmail: json['FEmail'],
      uploadLogo1: json['UploadLogo1'],
      schoolName: json['SchoolName'],
      schoolId: json['SchoolId'],
      passwordStatus: json['PasswordStatus'],
      approvedRemarks: json['ApprovedRemarks'],
      bloodGroup: json['BloodGroup'],
      mEmail: json['MEmail'],
      id: json['ID'],
      isActive: json['IsActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'Password': password,
      'RegistrationNo': registrationNo,
      'AdmissionNo': admissionNo,
      'Session': session,
      'StudentName': studentName,
      'Sex': sex,
      'PlaceofBirth': placeOfBirth,
      'DOB': dob?.toIso8601String(),  // Convert DateTime to String
      'Age': age,
      'ClassId': classId,
      'Class': className,
      'Section': section,
      'SectionId': sectionId,
      'ParentID': parentId,
      'StudentPic': studentPic,
      'Ppassword': ppassword,
      'StudentId': studentId,
      'FatherName': fatherName,
      'FMobileno': fMobileNo,
      'MotherName': motherName,
      'FAddressRes': fAddressRes,
      'DropPoint': dropPoint,
      'FEmail': fEmail,
      'UploadLogo1': uploadLogo1,
      'SchoolName': schoolName,
      'SchoolId': schoolId,
      'PasswordStatus': passwordStatus,
      'ApprovedRemarks': approvedRemarks,
      'BloodGroup': bloodGroup,
      'MEmail': mEmail,
      'ID': id,
      'IsActive': isActive,
    };
  }
}


