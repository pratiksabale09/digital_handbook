import 'package:digital_handbook/models/role.dart';
import 'package:digital_handbook/models/User.dart';
import 'User.dart';
import 'address.dart';
import 'enums/gender.dart';

class UsersProfileModel {

  String id;
  String mobile;
  String password;
  String name;
  Gender gender;
  bool isDisabled = true;
  Users UsersType;
  String email;
  Address address;
  DateTime dob;
  bool isOutSideDriver;
  String accId;
  Role roleId;
  DateTime createdAt;
  DateTime updatedAt;
  
  UsersProfileModel({required this.id, required this.password, 
  required this.mobile, required this.name, 
  required this.gender, required this.accId, 
  required this.roleId, required this.UsersType, required this.address, required this.createdAt, required this.dob,
  required this.email, required this.isDisabled, required this.isOutSideDriver, required this.updatedAt});

}