//provider for auth

import 'dart:async';
import 'dart:io';
import 'package:digital_handbook/constants/apiconstants.dart';
import 'package:digital_handbook/models/auth_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  DateTime? expiryDate;
  String? token;
  String? UsersId;
  String? orgId;
  Timer? authTimer;
  bool isauth = false;

  bool get isAuth {
    return isauth;
  }

  String? get gettoken {
    if (expiryDate != null &&
        expiryDate!.isAfter(DateTime.now()) &&
        token != null) {
      return token!;
    }
    return null;
  }

  String? get getUsersId {
    return UsersId;
  }

  String? get getOrgId {
    return orgId;
  }

  Future<void> signIn(AuthLogin authLogin) async {
    final url = Uri.parse(Api.login);
    try {
      print('tried in authlogin');
      final response = await http.post(
        url,
        body: {
          'email': authLogin.email,
          'password': authLogin.password,
          'rememberMe': authLogin.rememberMe.toString(),
        },
      );
      print(response.body);
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['error'] == true) {
        isauth = false;
        throw HttpException(responseData['message']);
      }
      isauth = true;
      token = responseData['token'];
      bool error = responseData['error'];
      String? message = responseData['message'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token.toString());
      UsersId = decodedToken['UsersId'];
      orgId = decodedToken['orgId'];
      print('response data: $responseData');
      print('error: $error');
      print('token from signin: $token');
      print('msg: $message');
      print('decoded token: $decodedToken');
      expiryDate = DateTime.now().add(
        Duration(
          seconds: responseData['expiresIn'],
        ),
      );
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final UsersData = json.encode(
        {
          'token': token,
          'orgId': orgId,
          'UsersId': UsersId,
          'expiryDate': expiryDate!.toIso8601String(),
        },
      );
      prefs.setString('UsersData', UsersData);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    print('Trying to auto login');
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('UsersData')) {
      print('didnt found preferences while autologin');
      isauth=false;
     
      return false;
    }
    var UsersData = prefs.getString('UsersData');
    print('Users data from preferences(String): $UsersData');
    Map<String, dynamic> extractedUsersData = jsonDecode(UsersData!);
    print('Users data from preferences(Map): $extractedUsersData');
    final expirydate = DateTime.parse(extractedUsersData['expiryDate']);
    if (expirydate.isBefore(DateTime.now())) {
      print('Found expired token!');
       isauth=false;
      notifyListeners();
      return false;
    } else {
      print('Found valid token, expiry date checked');
    }
    token = extractedUsersData['token'];
    UsersId = extractedUsersData['UsersId'];
    orgId = extractedUsersData['orgId'];
    expiryDate = expirydate;
    isauth = true;
    print('token: $token');
    print('UsersId: $UsersId');
    print('orgId: $orgId');
    print('expDate: $expiryDate');
    print('Authenticated!');
    notifyListeners();
    autoLogout();
    return true;
  }

  Future<void> logout() async {
    print('logout called!');
    token = null;
    UsersId = null;
    expiryDate = null;
    if (authTimer != null) {
      authTimer!.cancel();
      print('autologout timer stopped!');
      authTimer = null;
    }
    print('Users turned unauthenticated!');
    isauth = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    var stringfrompref = prefs.getString('UsersData');
    print('Data from preferences before clearing: $stringfrompref');
    prefs.clear();
    var stringfromprefafter = prefs.getString('UsersData');
    print('Data from preferences after clearing: $stringfromprefafter');
  }

  void autoLogout() {
    print('autologout timer started!');
    if (authTimer != null) {
      authTimer!.cancel();
    }
    final timeToExpiry = expiryDate!.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
