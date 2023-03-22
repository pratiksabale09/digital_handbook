//provider for users

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_handbook/constants/apiconstants.dart';
import 'package:digital_handbook/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:digital_handbook/models/User.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersProvider extends ChangeNotifier{
  AuthProvider authprovider = AuthProvider();
  UsersProvider(this.authprovider);

  //default vehicle list
  List<Users> UsersList= [
  Users.one(id: "id", password: "password", mobile: "mobile", name: "name", isDisabled: true, email: "email", role: "Role"),
  ];

  //getter
  List<Users> get getUserss {
    return UsersList;
  }

  //fetch vehicle list
  // Future<void> fetchAndSetVehicles() async {
  //   final url = Api.getVehicleList();
  //   print('Vehicle List Api: $url');
  //   String token = authprovider.gettoken.toString();
  //   print('token in vehicle Provider, while fetching vehicles: $token');
  //   Map<String, dynamic> extractedData = {};
  //   List<Users> loadedUserss = [];
  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     print(response.body.toString());
  //     extractedData = json.decode(response.body);
  //     print('Extracted Data: $extractedData');
  //     if (extractedData['error']) {
  //       loadedVehicles = [];
  //     } else {
  //       extractedData['items'].forEach((vehicleData) {
  //         loadedVehicles.add(Vehicle(
  //             vehicleNo: vehicleData['vehicleNo'],
  //             vehicleType: vehicleData['vehicleType'],
  //             brandName: vehicleData['brandName'],
  //             brandModel: vehicleData['brandModel'],
  //             isOutSideVehicle: vehicleData['isOutSideVehicle']));
  //       });
  //     }
  //     vehicleList = loadedVehicles;
  //     notifyListeners();
  //   } catch (error) {
  //     vehicleList = loadedVehicles;
  //     if (extractedData.isEmpty) {
  //       throw 'An error occured';
  //     } else {
  //       throw extractedData['message'];
  //     }
  //   }
  // }

  //function to edit existing vehicle
  // Future<void> editVehicleInList(Vehicle vehicle, Vehicle vehiclenew) async {
  //   String token = authprovider.gettoken.toString();
  //   final vehicleIndex = vehicleList.indexOf(vehicle);
  //   Map<String, dynamic> responseData = {};
  //   if (vehicleIndex >= 0) {
  //     final url = Api.editVehicleById(vehicle.id);
  //     print('Edit Vehicle List Api: $url');
  //     try {
  //       final response = await http.patch(Uri.parse(url), body: {
  //         'vehicleNo': vehiclenew.vehicleNo,
  //         'isOutSideVehicle': vehiclenew.isOutSideVehicle.toString(),
  //         'brandModel': vehiclenew.brandModel,
  //         'brandName': vehiclenew.brandName,
  //         'vehicleType': vehiclenew.vehicleType,
  //       }, headers: {
  //         'Authorization': 'Bearer $token'
  //       });
  //       print(response.body);
  //       responseData = jsonDecode(response.body);
  //       print("im here");
  //         vehicleList[vehicleIndex] = vehiclenew;
  //       notifyListeners();
  //     } catch (error) {
  //       if (responseData.isEmpty) {
  //         throw 'An error occured';
  //       } else {
  //         throw HttpException(responseData['message']);
  //       }
  //     }
  //     return Future.value();
  //   }
  // }

  //function to add new vehilce
  Future<void> addUsersInList(Users users) async {
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
        'id': users.id,
        'password': users.password.toString(),
        'mobile': users.mobile,
        'name': users.name,
        'isDisabled': users.isDisabled,
        'email': users.email,
        'role': "student",
      };

          final _auth = FirebaseAuth.instance;
      UserCredential userCredential;

      try
    {
       
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: users.email!, password: users.password);
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

  // Future<void> deleteVehicle(Vehicle vehicle) async {
  //   String token = authprovider.gettoken.toString();
  //   Map<String, dynamic> responseData = {};
  //   final url = Api.deleteVehicleById(vehicle.id);
  //   final existingVehicleIndex =
  //       vehicleList.indexWhere((element) => (element == vehicle));
  //   Vehicle? existingVehicle = vehicleList[existingVehicleIndex];
  //   vehicleList.removeAt(existingVehicleIndex);
  //   notifyListeners();
  //   try {
  //     final response = await http.delete(
  //       Uri.parse(url),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     notifyListeners();
  //     responseData = jsonDecode(response.body);
  //   } catch (error) {
  //     print(error);
  //     if (responseData.isEmpty) {
  //       vehicleList.insert(existingVehicleIndex, existingVehicle);
  //       notifyListeners();
  //       throw 'An Error Occured';
  //     } else {
  //       vehicleList.insert(existingVehicleIndex, existingVehicle);
  //       notifyListeners();
  //       throw HttpException(responseData['message']);
  //     }
  //   }
  //   existingVehicle = null;
  // }
}
