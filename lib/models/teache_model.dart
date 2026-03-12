class TeacherModelClass {
  String? message;
  List<Data>? data;
  int? statuscode;
  int? totalCount;

  TeacherModelClass(
      {this.message, this.data, this.statuscode, this.totalCount});

  TeacherModelClass.fromJson(Map<String, dynamic> json) {
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
  int? studentId;
  var studentRegNo;
  var registrationNo;
  var admissionNo;
  var session;
  var studentName;
  var sex;
  var placeofBirth;
  var dOB;
  var admissionDate;
  var age;
  int? classId;
  var classs;
  var section;
  int? sectionId;
  var religion;
  var caste;
  var nationality;
  var motherTongue;
  int? qNId;
  int? sQNId;
  int? hostel;
  var parentStatus;
  var quotaName;
  var parentID;
  var fatherName;
  var fAge;
  var fEducation;
  var fOccupation;
  var fDesignation;
  var fOrganisation;
  var fAddressRes;
  var fAddressPerm;
  var fAddressOffice;
  var fPhoneOffice;
  var fMobileno;
  var fEmail;
  var motherName;
  var mAge;
  var mEducation;
  var mOccupation;
  var mDesignation;
  var mOrganisation;
  var mAddressRes;
  var mAddressPerm;
  var mAddressOffice;
  var mPhoneoffice;
  var mMobileno;
  var mEmail;
  var smsFather;
  var smsMother;
  var bloodGroup;
  var identificationMark;
  var height;
  var weight;
  var asthma;
  var epilepsy;
  var anyOther;
  var bCG;
  var hib;
  var dPT;
  var influenza;
  var mMR;
  var typhoid;
  var polio;
  var measles;
  var hepatitisA;
  var hepatitisB;
  var chickenpox;
  var dTAP;
  var anyMedicine;
  var anyFood;
  var anythingElse;
  var spectacles;
  var blindness;
  int? routeNo;
  var routeName;
  var pickupPoint;
  var dropPoint;
  var midDayTo;
  var midDayFrom;
  var studentPic;
  var fatherPic;
  var motherPic;
  var aadharPic;
  var birthCertificatePic;
  var action;
  var action1;
  var action2;
  var attendance;
  var createBy;
  var updateBy;
  var ppassword;
  var rollNo;
  var dDOB;
  var aAdmissionDate;
  int? sNo;
  var schoolId;
  var schoolName;
  var aAdharNo;
  var eMISNo;
  int? routePointId;
  int? routeNameId;
  var transportUser;
  var description1;
  var feeType;
  var createddBy;
  var receiptno;
  var term;
  var remark;
  var updateDate;
  var transportremark;
  var transportdate;
  var whichclass;
  var smsMobileNoNumber;
  int? feeTypeId;
  var hostelRemarks;
  var technoRemarks;
  var tCStatus;
  var language1;
  int? tCNumber;
  var siblingDetails;
  var dOA;
  var dateOfAdmission;
  var fQualification;
  var mQualification;
  var whatsAppNo;
  var guardianName;
  var guardianPhone;
  var pinCode;
  int? languageId;
  int? activityId;
  int? serviceId;
  int? casteId;
  var activity;
  var serviceMovement;
  int? coachingId;
  var coaching;
  var community;
  var cityState;
  var cityName;
  var language;
  int? groupId;
  var groupName;
  int? houseId;
  var houseName;
  var nEETIITCA;
  var classInWords;
  var dobinWords;
  var games19;
  var whether18;
  var conduct20;
  var studentQRCode;
  var email;
  var website;
  var certified;
  var address;
  var phone;
  var affiliated;
  int? sclInfoId;
  var createDate;
  int? bonafiedId;
  var bonafiedNo;
  var stuId;
  var purpose;
  var session1;
  var rupees;
  var dOB1;
  var rupeeInWords;
  int? bonId;
  var conduct;
  var issuedPurpose;
  int? subjectId;
  var name;
  var teacherReg;
  var subject;
  bool? isActive;
  var createdDate;
  var date;
  var modifiedDate;
  int? createdby;
  int? updatedby;
  var classss;

  Data(
      {this.studentId,
      this.studentRegNo,
      this.registrationNo,
      this.admissionNo,
      this.session,
      this.studentName,
      this.sex,
      this.placeofBirth,
      this.dOB,
      this.admissionDate,
      this.age,
      this.classId,
      this.classs,
      this.section,
      this.sectionId,
      this.religion,
      this.caste,
      this.nationality,
      this.motherTongue,
      this.qNId,
      this.sQNId,
      this.hostel,
      this.parentStatus,
      this.quotaName,
      this.parentID,
      this.fatherName,
      this.fAge,
      this.fEducation,
      this.fOccupation,
      this.fDesignation,
      this.fOrganisation,
      this.fAddressRes,
      this.fAddressPerm,
      this.fAddressOffice,
      this.fPhoneOffice,
      this.fMobileno,
      this.fEmail,
      this.motherName,
      this.mAge,
      this.mEducation,
      this.mOccupation,
      this.mDesignation,
      this.mOrganisation,
      this.mAddressRes,
      this.mAddressPerm,
      this.mAddressOffice,
      this.mPhoneoffice,
      this.mMobileno,
      this.mEmail,
      this.smsFather,
      this.smsMother,
      this.bloodGroup,
      this.identificationMark,
      this.height,
      this.weight,
      this.asthma,
      this.epilepsy,
      this.anyOther,
      this.bCG,
      this.hib,
      this.dPT,
      this.influenza,
      this.mMR,
      this.typhoid,
      this.polio,
      this.measles,
      this.hepatitisA,
      this.hepatitisB,
      this.chickenpox,
      this.dTAP,
      this.anyMedicine,
      this.anyFood,
      this.anythingElse,
      this.spectacles,
      this.blindness,
      this.routeNo,
      this.routeName,
      this.pickupPoint,
      this.dropPoint,
      this.midDayTo,
      this.midDayFrom,
      this.studentPic,
      this.fatherPic,
      this.motherPic,
      this.aadharPic,
      this.birthCertificatePic,
      this.action,
      this.action1,
      this.action2,
      this.attendance,
      this.createBy,
      this.updateBy,
      this.ppassword,
      this.rollNo,
      this.dDOB,
      this.aAdmissionDate,
      this.sNo,
      this.schoolId,
      this.schoolName,
      this.aAdharNo,
      this.eMISNo,
      this.routePointId,
      this.routeNameId,
      this.transportUser,
      this.description1,
      this.feeType,
      this.createddBy,
      this.receiptno,
      this.term,
      this.remark,
      this.updateDate,
      this.transportremark,
      this.transportdate,
      this.whichclass,
      this.smsMobileNoNumber,
      this.feeTypeId,
      this.hostelRemarks,
      this.technoRemarks,
      this.tCStatus,
      this.language1,
      this.tCNumber,
      this.siblingDetails,
      this.dOA,
      this.dateOfAdmission,
      this.fQualification,
      this.mQualification,
      this.whatsAppNo,
      this.guardianName,
      this.guardianPhone,
      this.pinCode,
      this.languageId,
      this.activityId,
      this.serviceId,
      this.casteId,
      this.activity,
      this.serviceMovement,
      this.coachingId,
      this.coaching,
      this.community,
      this.cityState,
      this.cityName,
      this.language,
      this.groupId,
      this.groupName,
      this.houseId,
      this.houseName,
      this.nEETIITCA,
      this.classInWords,
      this.dobinWords,
      this.games19,
      this.whether18,
      this.conduct20,
      this.studentQRCode,
      this.email,
      this.website,
      this.certified,
      this.address,
      this.phone,
      this.affiliated,
      this.sclInfoId,
      this.createDate,
      this.bonafiedId,
      this.bonafiedNo,
      this.stuId,
      this.purpose,
      this.session1,
      this.rupees,
      this.dOB1,
      this.rupeeInWords,
      this.bonId,
      this.conduct,
      this.issuedPurpose,
      this.subjectId,
      this.name,
      this.teacherReg,
      this.subject,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby,
      this.classss});

  Data.fromJson(Map<String, dynamic> json) {
    studentId = json['StudentId'];
    studentRegNo = json['StudentRegNo'];
    registrationNo = json['RegistrationNo'];
    admissionNo = json['AdmissionNo'];
    session = json['Session'];
    studentName = json['StudentName'];
    sex = json['Sex'];
    placeofBirth = json['PlaceofBirth'];
    dOB = json['DOB'];
    admissionDate = json['AdmissionDate'];
    age = json['Age'];
    classId = json['ClassId'];
    classs = json['Classs'];
    section = json['Section'];
    sectionId = json['SectionId'];
    religion = json['Religion'];
    caste = json['Caste'];
    nationality = json['Nationality'];
    motherTongue = json['MotherTongue'];
    qNId = json['QNId'];
    sQNId = json['SQNId'];
    hostel = json['Hostel'];
    parentStatus = json['ParentStatus'];
    quotaName = json['QuotaName'];
    parentID = json['ParentID'];
    fatherName = json['FatherName'];
    fAge = json['FAge'];
    fEducation = json['FEducation'];
    fOccupation = json['FOccupation'];
    fDesignation = json['FDesignation'];
    fOrganisation = json['FOrganisation'];
    fAddressRes = json['FAddressRes'];
    fAddressPerm = json['FAddressPerm'];
    fAddressOffice = json['FAddressOffice'];
    fPhoneOffice = json['FPhoneOffice'];
    fMobileno = json['FMobileno'];
    fEmail = json['FEmail'];
    motherName = json['MotherName'];
    mAge = json['MAge'];
    mEducation = json['MEducation'];
    mOccupation = json['MOccupation'];
    mDesignation = json['MDesignation'];
    mOrganisation = json['MOrganisation'];
    mAddressRes = json['MAddressRes'];
    mAddressPerm = json['MAddressPerm'];
    mAddressOffice = json['MAddressOffice'];
    mPhoneoffice = json['MPhoneoffice'];
    mMobileno = json['MMobileno'];
    mEmail = json['MEmail'];
    smsFather = json['SmsFather'];
    smsMother = json['SmsMother'];
    bloodGroup = json['BloodGroup'];
    identificationMark = json['IdentificationMark'];
    height = json['Height'];
    weight = json['Weight'];
    asthma = json['Asthma'];
    epilepsy = json['Epilepsy'];
    anyOther = json['AnyOther'];
    bCG = json['BCG'];
    hib = json['Hib'];
    dPT = json['DPT'];
    influenza = json['Influenza'];
    mMR = json['MMR'];
    typhoid = json['Typhoid'];
    polio = json['Polio'];
    measles = json['Measles'];
    hepatitisA = json['HepatitisA'];
    hepatitisB = json['HepatitisB'];
    chickenpox = json['Chickenpox'];
    dTAP = json['DTAP'];
    anyMedicine = json['AnyMedicine'];
    anyFood = json['AnyFood'];
    anythingElse = json['AnythingElse'];
    spectacles = json['Spectacles'];
    blindness = json['Blindness'];
    routeNo = json['RouteNo'];
    routeName = json['RouteName'];
    pickupPoint = json['PickupPoint'];
    dropPoint = json['DropPoint'];
    midDayTo = json['MidDayTo'];
    midDayFrom = json['MidDayFrom'];
    studentPic = json['StudentPic'];
    fatherPic = json['FatherPic'];
    motherPic = json['MotherPic'];
    aadharPic = json['AadharPic'];
    birthCertificatePic = json['BirthCertificatePic'];
    action = json['Action'];
    action1 = json['Action1'];
    action2 = json['Action2'];
    attendance = json['Attendance'];
    createBy = json['CreateBy'];
    updateBy = json['UpdateBy'];
    ppassword = json['Ppassword'];
    rollNo = json['RollNo'];
    dDOB = json['DDOB'];
    aAdmissionDate = json['AAdmissionDate'];
    sNo = json['SNo'];
    schoolId = json['SchoolId'];
    schoolName = json['SchoolName'];
    aAdharNo = json['AAdharNo'];
    eMISNo = json['EMISNo'];
    routePointId = json['RoutePointId'];
    routeNameId = json['RouteNameId'];
    transportUser = json['TransportUser'];
    description1 = json['Description1'];
    feeType = json['FeeType'];
    createddBy = json['CreateddBy'];
    receiptno = json['Receiptno'];
    term = json['Term'];
    remark = json['remark'];
    updateDate = json['UpdateDate'];
    transportremark = json['transportremark'];
    transportdate = json['transportdate'];
    whichclass = json['whichclass'];
    smsMobileNoNumber = json['SmsMobileNoNumber'];
    feeTypeId = json['FeeTypeId'];
    hostelRemarks = json['HostelRemarks'];
    technoRemarks = json['TechnoRemarks'];
    tCStatus = json['TCStatus'];
    language1 = json['Language1'];
    tCNumber = json['TCNumber'];
    siblingDetails = json['SiblingDetails'];
    dOA = json['DOA'];
    dateOfAdmission = json['DateOfAdmission'];
    fQualification = json['FQualification'];
    mQualification = json['MQualification'];
    whatsAppNo = json['WhatsAppNo'];
    guardianName = json['GuardianName'];
    guardianPhone = json['GuardianPhone'];
    pinCode = json['PinCode'];
    languageId = json['LanguageId'];
    activityId = json['ActivityId'];
    serviceId = json['ServiceId'];
    casteId = json['CasteId'];
    activity = json['Activity'];
    serviceMovement = json['ServiceMovement'];
    coachingId = json['CoachingId'];
    coaching = json['Coaching'];
    community = json['Community'];
    cityState = json['city_state'];
    cityName = json['city_name'];
    language = json['Language'];
    groupId = json['GroupId'];
    groupName = json['GroupName'];
    houseId = json['HouseId'];
    houseName = json['HouseName'];
    nEETIITCA = json['NEETIITCA'];
    classInWords = json['ClassInWords'];
    dobinWords = json['DobinWords'];
    games19 = json['Games19'];
    whether18 = json['Whether18'];
    conduct20 = json['Conduct20'];
    studentQRCode = json['StudentQRCode'];
    email = json['Email'];
    website = json['Website'];
    certified = json['Certified'];
    address = json['Address'];
    phone = json['Phone'];
    affiliated = json['Affiliated'];
    sclInfoId = json['SclInfoId'];
    createDate = json['CreateDate'];
    bonafiedId = json['BonafiedId'];
    bonafiedNo = json['BonafiedNo'];
    stuId = json['StuId'];
    purpose = json['Purpose'];
    session1 = json['Session1'];
    rupees = json['Rupees'];
    dOB1 = json['DOB1'];
    rupeeInWords = json['RupeeInWords'];
    bonId = json['BonId'];
    conduct = json['Conduct'];
    issuedPurpose = json['IssuedPurpose'];
    subjectId = json['SubjectId'];
    name = json['Name'];
    teacherReg = json['TeacherReg'];
    subject = json['Subject'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
    classss = json['Classss'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentId'] = this.studentId;
    data['StudentRegNo'] = this.studentRegNo;
    data['RegistrationNo'] = this.registrationNo;
    data['AdmissionNo'] = this.admissionNo;
    data['Session'] = this.session;
    data['StudentName'] = this.studentName;
    data['Sex'] = this.sex;
    data['PlaceofBirth'] = this.placeofBirth;
    data['DOB'] = this.dOB;
    data['AdmissionDate'] = this.admissionDate;
    data['Age'] = this.age;
    data['ClassId'] = this.classId;
    data['Classs'] = this.classs;
    data['Section'] = this.section;
    data['SectionId'] = this.sectionId;
    data['Religion'] = this.religion;
    data['Caste'] = this.caste;
    data['Nationality'] = this.nationality;
    data['MotherTongue'] = this.motherTongue;
    data['QNId'] = this.qNId;
    data['SQNId'] = this.sQNId;
    data['Hostel'] = this.hostel;
    data['ParentStatus'] = this.parentStatus;
    data['QuotaName'] = this.quotaName;
    data['ParentID'] = this.parentID;
    data['FatherName'] = this.fatherName;
    data['FAge'] = this.fAge;
    data['FEducation'] = this.fEducation;
    data['FOccupation'] = this.fOccupation;
    data['FDesignation'] = this.fDesignation;
    data['FOrganisation'] = this.fOrganisation;
    data['FAddressRes'] = this.fAddressRes;
    data['FAddressPerm'] = this.fAddressPerm;
    data['FAddressOffice'] = this.fAddressOffice;
    data['FPhoneOffice'] = this.fPhoneOffice;
    data['FMobileno'] = this.fMobileno;
    data['FEmail'] = this.fEmail;
    data['MotherName'] = this.motherName;
    data['MAge'] = this.mAge;
    data['MEducation'] = this.mEducation;
    data['MOccupation'] = this.mOccupation;
    data['MDesignation'] = this.mDesignation;
    data['MOrganisation'] = this.mOrganisation;
    data['MAddressRes'] = this.mAddressRes;
    data['MAddressPerm'] = this.mAddressPerm;
    data['MAddressOffice'] = this.mAddressOffice;
    data['MPhoneoffice'] = this.mPhoneoffice;
    data['MMobileno'] = this.mMobileno;
    data['MEmail'] = this.mEmail;
    data['SmsFather'] = this.smsFather;
    data['SmsMother'] = this.smsMother;
    data['BloodGroup'] = this.bloodGroup;
    data['IdentificationMark'] = this.identificationMark;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    data['Asthma'] = this.asthma;
    data['Epilepsy'] = this.epilepsy;
    data['AnyOther'] = this.anyOther;
    data['BCG'] = this.bCG;
    data['Hib'] = this.hib;
    data['DPT'] = this.dPT;
    data['Influenza'] = this.influenza;
    data['MMR'] = this.mMR;
    data['Typhoid'] = this.typhoid;
    data['Polio'] = this.polio;
    data['Measles'] = this.measles;
    data['HepatitisA'] = this.hepatitisA;
    data['HepatitisB'] = this.hepatitisB;
    data['Chickenpox'] = this.chickenpox;
    data['DTAP'] = this.dTAP;
    data['AnyMedicine'] = this.anyMedicine;
    data['AnyFood'] = this.anyFood;
    data['AnythingElse'] = this.anythingElse;
    data['Spectacles'] = this.spectacles;
    data['Blindness'] = this.blindness;
    data['RouteNo'] = this.routeNo;
    data['RouteName'] = this.routeName;
    data['PickupPoint'] = this.pickupPoint;
    data['DropPoint'] = this.dropPoint;
    data['MidDayTo'] = this.midDayTo;
    data['MidDayFrom'] = this.midDayFrom;
    data['StudentPic'] = this.studentPic;
    data['FatherPic'] = this.fatherPic;
    data['MotherPic'] = this.motherPic;
    data['AadharPic'] = this.aadharPic;
    data['BirthCertificatePic'] = this.birthCertificatePic;
    data['Action'] = this.action;
    data['Action1'] = this.action1;
    data['Action2'] = this.action2;
    data['Attendance'] = this.attendance;
    data['CreateBy'] = this.createBy;
    data['UpdateBy'] = this.updateBy;
    data['Ppassword'] = this.ppassword;
    data['RollNo'] = this.rollNo;
    data['DDOB'] = this.dDOB;
    data['AAdmissionDate'] = this.aAdmissionDate;
    data['SNo'] = this.sNo;
    data['SchoolId'] = this.schoolId;
    data['SchoolName'] = this.schoolName;
    data['AAdharNo'] = this.aAdharNo;
    data['EMISNo'] = this.eMISNo;
    data['RoutePointId'] = this.routePointId;
    data['RouteNameId'] = this.routeNameId;
    data['TransportUser'] = this.transportUser;
    data['Description1'] = this.description1;
    data['FeeType'] = this.feeType;
    data['CreateddBy'] = this.createddBy;
    data['Receiptno'] = this.receiptno;
    data['Term'] = this.term;
    data['remark'] = this.remark;
    data['UpdateDate'] = this.updateDate;
    data['transportremark'] = this.transportremark;
    data['transportdate'] = this.transportdate;
    data['whichclass'] = this.whichclass;
    data['SmsMobileNoNumber'] = this.smsMobileNoNumber;
    data['FeeTypeId'] = this.feeTypeId;
    data['HostelRemarks'] = this.hostelRemarks;
    data['TechnoRemarks'] = this.technoRemarks;
    data['TCStatus'] = this.tCStatus;
    data['Language1'] = this.language1;
    data['TCNumber'] = this.tCNumber;
    data['SiblingDetails'] = this.siblingDetails;
    data['DOA'] = this.dOA;
    data['DateOfAdmission'] = this.dateOfAdmission;
    data['FQualification'] = this.fQualification;
    data['MQualification'] = this.mQualification;
    data['WhatsAppNo'] = this.whatsAppNo;
    data['GuardianName'] = this.guardianName;
    data['GuardianPhone'] = this.guardianPhone;
    data['PinCode'] = this.pinCode;
    data['LanguageId'] = this.languageId;
    data['ActivityId'] = this.activityId;
    data['ServiceId'] = this.serviceId;
    data['CasteId'] = this.casteId;
    data['Activity'] = this.activity;
    data['ServiceMovement'] = this.serviceMovement;
    data['CoachingId'] = this.coachingId;
    data['Coaching'] = this.coaching;
    data['Community'] = this.community;
    data['city_state'] = this.cityState;
    data['city_name'] = this.cityName;
    data['Language'] = this.language;
    data['GroupId'] = this.groupId;
    data['GroupName'] = this.groupName;
    data['HouseId'] = this.houseId;
    data['HouseName'] = this.houseName;
    data['NEETIITCA'] = this.nEETIITCA;
    data['ClassInWords'] = this.classInWords;
    data['DobinWords'] = this.dobinWords;
    data['Games19'] = this.games19;
    data['Whether18'] = this.whether18;
    data['Conduct20'] = this.conduct20;
    data['StudentQRCode'] = this.studentQRCode;
    data['Email'] = this.email;
    data['Website'] = this.website;
    data['Certified'] = this.certified;
    data['Address'] = this.address;
    data['Phone'] = this.phone;
    data['Affiliated'] = this.affiliated;
    data['SclInfoId'] = this.sclInfoId;
    data['CreateDate'] = this.createDate;
    data['BonafiedId'] = this.bonafiedId;
    data['BonafiedNo'] = this.bonafiedNo;
    data['StuId'] = this.stuId;
    data['Purpose'] = this.purpose;
    data['Session1'] = this.session1;
    data['Rupees'] = this.rupees;
    data['DOB1'] = this.dOB1;
    data['RupeeInWords'] = this.rupeeInWords;
    data['BonId'] = this.bonId;
    data['Conduct'] = this.conduct;
    data['IssuedPurpose'] = this.issuedPurpose;
    data['SubjectId'] = this.subjectId;
    data['Name'] = this.name;
    data['TeacherReg'] = this.teacherReg;
    data['Subject'] = this.subject;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    data['Classss'] = this.classss;
    return data;
  }
}
