import 'address.dart';

class Users {

  String id;
  String mobile;
  String password;
  String name;
  bool isDisabled = true;
  String? role;
  String? email;
  Address? address;
  DateTime? dob;
  String? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? rememberMe;

  Users({required this.id, required this.password, required this.mobile, 
  required this.name, required this.isDisabled, required this.role, required this.email, required this.address,
  required this.dob, required this.roleId, required this.createdAt,
  required this.updatedAt});

  Users.one({required this.id, required this.password, required this.mobile, required this.name, required this.isDisabled, required this.email, required this.role});
}