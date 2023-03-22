//provider for vehicles

import 'dart:io';
//import 'package:DIGITAL_HANDBOOK/constants/apiconstants.dart';
//import 'package:car_rental_mng_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_handbook/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:car_rental_mng_app/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/apiconstants.dart';
import '../models/student.dart';

class StudentProvider extends ChangeNotifier {
  AuthProvider authprovider = AuthProvider();
  StudentProvider(this.authprovider);
//  List<Map<String, String>> ss = [{'mobile':'mobile'}];
  //default vehicle list
  List<Student> studentList = [
    Student.one(
        id: "id",
        password: "password",
        mobile: [{}],
        name: "Pratik",
        isDisabled: false,
        email: "email",
        role: "role",
        hobby: [{}], 
        parentEmail: "parentEmail",
        regID: "",
        rollNo: "", 
        gender: "",
        parentPhone: "",
        currAddress: ""),
    // Student.one(
    //     id: "id",
    //     password: "password",
    //     mobile: [{'Primary Mobile':'9145750060'}],
    //     name: "Shruti",
    //     isDisabled: false,
    //     email: "email",
    //     role: "role"),
    // Student.one(
    //     id: "id",
    //     password: "password",
    //     mobile: [{'Primary Mobile':'9145750060'}],
    //     name: "XX",
    //     isDisabled: false,
    //     email: "email",
    //     role: "role"),
    // Student.one(
    //     id: "id",
    //     password: "password",
    //     mobile: [{'Primary Mobile':'9145750060'}],
    //     name: "YY",
    //     isDisabled: false,
    //     email: "email",
    //     role: "role"),
    // Student.one(
    //     id: "id",
    //     password: "password",
    //     mobile: [{'Primary Mobile':'9145750060'}],
    //     name: "ZZ",
    //     isDisabled: false,
    //     email: "email",
    //     role: "role"),
    // Student.one(
    //     id: "id",
    //     password: "password",
    //     mobile: [{'Primary Mobile':'9145750060'}],
    //     name: "XYZW",
    //     isDisabled: false,
    //     email: "email",
    //     role: "role"),
  ];

  //getter
  List<Student> get getStudents {
    return studentList;
  }

  Future<void> fetchAndSetStudents() async {
    final url = Api.getStudentsList();
    print('Student List Api: $url');
    String token = authprovider.gettoken.toString();
    print('token in student Provider, while fetching students: $token');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body.toString());
      final extractedData = json.decode(response.body);
      List<Student> loadedStudents = [];
      if (extractedData['error']) {
        loadedStudents = [];
      } else {
        extractedData['items'].forEach((studentData) {
          // loadedStudents.add(Student.one(
          //     id: studentData['id'],
          //     password: studentData['password'],
          //     mobile: studentData['mobile'],
          //     name: studentData['name'],
          //     isDisabled: studentData['isDisabled'],
          //     email: studentData['email'],
          //     role: studentData['role'],
          //     ));
        });
      }
      studentList = studentList;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  //function to edit existing vehicle
  Future<void> editStudentInList(Student student, Student studentNew) async {
    String token = authprovider.gettoken.toString();
    final studentIndex = studentList.indexOf(student);
    Map<String, dynamic>? responseData;
    if (studentIndex >= 0) {
      print('I am here');
      final url = Api.editStudentById(student.id);
      print('Edit Student List Api: $url');
      try {
        final response = await http.patch(Uri.parse(url), body: {
          'id': studentNew.id,
          'password': studentNew.password,
          'mobile': studentNew.mobile,
          'name': studentNew.name,
          'isDisabled': studentNew.isDisabled,
          'email': studentNew.email,
          'role': studentNew.role,
        }, headers: {
          'Authorization': 'Bearer $token'
        });
        print(response.body);
        responseData = jsonDecode(response.body);
        if (responseData!['error'] != true) {
          studentList[studentIndex] = studentNew;
        }
        notifyListeners();
      } catch (error) {
        throw HttpException(responseData!['message']);
      }
      return Future.value();
    }
  }

  //function to add new vehilce
  Future<void> addStudentInList(Student student) async {
        String token = authprovider.gettoken.toString();
    // final url = Api.addUsers();
    //print('Api for add vehicle: $url');
    Map<String, dynamic> responseData = {};
    try {
      // final response = await http.post(Uri.parse(url), body: {
      //   'id': Users.id,
      //   'password': Users.password.toString(),
      //   'mobile': Users.mobile,
      //   'name': Users.name,
      //   'isDisabled': Users.isDisabled,
      //   'email': Users.email,
      //   //'gpsEndPoint': vehicle.gpsEndPoint,
      //   //'orgId': vehicle.orgId,
      //   //'accId': vehicle.accId,
      // }, headers: {
      //   'Authorization': 'Bearer $token'
      // });

      Map<String, dynamic> data = {
        'id': student.id,
        'password': student.toString(),
        'mobile': student.mobile,
        'name': student.name,
        'isDisabled': student.isDisabled,
        'email': student.email,
        'role': "student",
      };

          final _auth = FirebaseAuth.instance;
      UserCredential userCredential;

      try
    {
       
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: student.email, password: student.password);
    print(userCredential);
    } on PlatformException catch (err)
    {
      var message = 'An error occured please check message';
      if(err.message!=null)
      {
        message = err.message!;
      }
    }

    
      CollectionReference cr = FirebaseFirestore.instance.collection('Users');
      cr.add(data);
      notifyListeners();
    } catch (error) {
      if(responseData.isEmpty){
        throw 'An error occured';
      }else
      {
      throw HttpException(responseData['message']);
      }
    }
    return Future.value();
  }

  Future<void> deleteStudent(Student vehicle) async {
    String token = authprovider.gettoken.toString();
    Map<String, dynamic>? responseData;
    final url = Api.deleteStudentById(vehicle.id);
    final existingVehicleIndex =
        studentList.indexWhere((element) => (element == vehicle));
    Student? existingVehicle = studentList[existingVehicleIndex];
    studentList.removeAt(existingVehicleIndex);
    notifyListeners();
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      responseData = jsonDecode(response.body);
      if (responseData!['error'] == true) {
        studentList.insert(existingVehicleIndex, existingVehicle);
        Fluttertoast.showToast(msg: "Could not delete student.");
        notifyListeners();
      }
    } catch (error) {
      throw HttpException(responseData!['message']);
    }
    existingVehicle = null;
  }
}
