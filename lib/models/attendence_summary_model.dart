class AttendanceSummaryModel {
  var message;
  List<Data>? data;
  var statuscode;
  var totalCount;

  AttendanceSummaryModel(
      {this.message, this.data, this.statuscode, this.totalCount});

  AttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
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
  var stdAId;
  var registrationNo;
  var studentName;
  var classId;
  var sectionId;
  var session;
  var day1;
  var day2;
  var day3;
  var day4;
  var day5;
  var day6;
  var day7;
  var day8;
  var day9;
  var day10;
  var day11;
  var day12;
  var day13;
  var day14;
  var day15;
  var day16;
  var day17;
  var day18;
  var day19;
  var day20;
  var day21;
  var day22;
  var day23;
  var day24;
  var day25;
  var day26;
  var day27;
  var day28;
  var day29;
  var day30;
  var day31;
  var months;
  var aMonths;
  var action;
  var createDate;
  var schoolId;
  var totalPresent;
  var totalAbsent;
  var totalHalfDay;
  var totalDay;
  var cSessionPresent;
  var cSessionAbsent;
  var cSessionHalfDay;
  var cSessionTotalDay;
  var pPresent;
  var adate;
  bool? isActive;
  var createdDate;
  var date;
  var modifiedDate;
  var createdby;
  var updatedby;

  Data(
      {this.stdAId,
      this.registrationNo,
      this.studentName,
      this.classId,
      this.sectionId,
      this.session,
      this.day1,
      this.day2,
      this.day3,
      this.day4,
      this.day5,
      this.day6,
      this.day7,
      this.day8,
      this.day9,
      this.day10,
      this.day11,
      this.day12,
      this.day13,
      this.day14,
      this.day15,
      this.day16,
      this.day17,
      this.day18,
      this.day19,
      this.day20,
      this.day21,
      this.day22,
      this.day23,
      this.day24,
      this.day25,
      this.day26,
      this.day27,
      this.day28,
      this.day29,
      this.day30,
      this.day31,
      this.months,
      this.aMonths,
      this.action,
      this.createDate,
      this.schoolId,
      this.totalPresent,
      this.totalAbsent,
      this.totalHalfDay,
      this.totalDay,
      this.cSessionPresent,
      this.cSessionAbsent,
      this.cSessionHalfDay,
      this.cSessionTotalDay,
      this.pPresent,
      this.adate,
      this.isActive,
      this.createdDate,
      this.date,
      this.modifiedDate,
      this.createdby,
      this.updatedby});

  Data.fromJson(Map<String, dynamic> json) {
    stdAId = json['StdAId'];
    registrationNo = json['RegistrationNo'];
    studentName = json['StudentName'];
    classId = json['ClassId'];
    sectionId = json['SectionId'];
    session = json['Session'];
    day1 = json['Day1'];
    day2 = json['Day2'];
    day3 = json['Day3'];
    day4 = json['Day4'];
    day5 = json['Day5'];
    day6 = json['Day6'];
    day7 = json['Day7'];
    day8 = json['Day8'];
    day9 = json['Day9'];
    day10 = json['Day10'];
    day11 = json['Day11'];
    day12 = json['Day12'];
    day13 = json['Day13'];
    day14 = json['Day14'];
    day15 = json['Day15'];
    day16 = json['Day16'];
    day17 = json['Day17'];
    day18 = json['Day18'];
    day19 = json['Day19'];
    day20 = json['Day20'];
    day21 = json['Day21'];
    day22 = json['Day22'];
    day23 = json['Day23'];
    day24 = json['Day24'];
    day25 = json['Day25'];
    day26 = json['Day26'];
    day27 = json['Day27'];
    day28 = json['Day28'];
    day29 = json['Day29'];
    day30 = json['Day30'];
    day31 = json['Day31'];
    months = json['Months'];
    aMonths = json['AMonths'];
    action = json['Action'];
    createDate = json['CreateDate'];
    schoolId = json['SchoolId'];
    totalPresent = json['TotalPresent'];
    totalAbsent = json['TotalAbsent'];
    totalHalfDay = json['TotalHalfDay'];
    totalDay = json['TotalDay'];
    cSessionPresent = json['CSessionPresent'];
    cSessionAbsent = json['CSessionAbsent'];
    cSessionHalfDay = json['CSessionHalfDay'];
    cSessionTotalDay = json['CSessionTotalDay'];
    pPresent = json['PPresent'];
    adate = json['Adate'];
    isActive = json['IsActive'];
    createdDate = json['CreatedDate'];
    date = json['Date'];
    modifiedDate = json['ModifiedDate'];
    createdby = json['Createdby'];
    updatedby = json['Updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StdAId'] = this.stdAId;
    data['RegistrationNo'] = this.registrationNo;
    data['StudentName'] = this.studentName;
    data['ClassId'] = this.classId;
    data['SectionId'] = this.sectionId;
    data['Session'] = this.session;
    data['Day1'] = this.day1;
    data['Day2'] = this.day2;
    data['Day3'] = this.day3;
    data['Day4'] = this.day4;
    data['Day5'] = this.day5;
    data['Day6'] = this.day6;
    data['Day7'] = this.day7;
    data['Day8'] = this.day8;
    data['Day9'] = this.day9;
    data['Day10'] = this.day10;
    data['Day11'] = this.day11;
    data['Day12'] = this.day12;
    data['Day13'] = this.day13;
    data['Day14'] = this.day14;
    data['Day15'] = this.day15;
    data['Day16'] = this.day16;
    data['Day17'] = this.day17;
    data['Day18'] = this.day18;
    data['Day19'] = this.day19;
    data['Day20'] = this.day20;
    data['Day21'] = this.day21;
    data['Day22'] = this.day22;
    data['Day23'] = this.day23;
    data['Day24'] = this.day24;
    data['Day25'] = this.day25;
    data['Day26'] = this.day26;
    data['Day27'] = this.day27;
    data['Day28'] = this.day28;
    data['Day29'] = this.day29;
    data['Day30'] = this.day30;
    data['Day31'] = this.day31;
    data['Months'] = this.months;
    data['AMonths'] = this.aMonths;
    data['Action'] = this.action;
    data['CreateDate'] = this.createDate;
    data['SchoolId'] = this.schoolId;
    data['TotalPresent'] = this.totalPresent;
    data['TotalAbsent'] = this.totalAbsent;
    data['TotalHalfDay'] = this.totalHalfDay;
    data['TotalDay'] = this.totalDay;
    data['CSessionPresent'] = this.cSessionPresent;
    data['CSessionAbsent'] = this.cSessionAbsent;
    data['CSessionHalfDay'] = this.cSessionHalfDay;
    data['CSessionTotalDay'] = this.cSessionTotalDay;
    data['PPresent'] = this.pPresent;
    data['Adate'] = this.adate;
    data['IsActive'] = this.isActive;
    data['CreatedDate'] = this.createdDate;
    data['Date'] = this.date;
    data['ModifiedDate'] = this.modifiedDate;
    data['Createdby'] = this.createdby;
    data['Updatedby'] = this.updatedby;
    return data;
  }
}
