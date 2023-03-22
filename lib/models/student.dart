import 'address.dart';

class Student {

  String id;
  List<Map<String, dynamic>> mobile;
  String password;
  String name;
  String? rollNo;
  String? parentPhone;
  String? regID;
  bool isDisabled = true;
  String role;
  String email;
  String? currAddress;
  String? permanentAddress;
  String? dob;
  String? roleId;
  String? createdAt;
  String? updatedAt;
  bool? rememberMe;
  List<Map<String, dynamic>>? hobby;
  List<String>? achievement;
  bool? internship;
  String? internshipCompanyName;
  String? parentEmail;
  String? gender;

  Student({required this.id, required this.password, required this.mobile, 
  required this.name, required this.isDisabled, required this.role, required this.email, required this.currAddress, required this.permanentAddress, required this.achievement, required this.internship, required this.internshipCompanyName, required this.hobby,
  required this.dob, required this.roleId, required this.createdAt,
  required this.updatedAt, required this.parentEmail, required this.parentPhone, required this.regID, required this.rememberMe, required this.rollNo});

  Student.one({required this.id, required this.password, required this.mobile, required this.name, required this.isDisabled, required this.email, required this.role, required this.hobby, required this.parentEmail, required this.regID, required this.rollNo, required this.gender, required this.parentPhone, required this.currAddress});
}