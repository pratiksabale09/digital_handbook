import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/student.dart';
import 'auth_provider.dart';

class UserProfileProvider extends ChangeNotifier {
    AuthProvider authprovider = AuthProvider();
  UserProfileProvider(this.authprovider);
    Future<void> updateProfile(Student student)
    {
      CollectionReference cr = FirebaseFirestore.instance.collection('Students');
      

       Map<String, dynamic> data1 = {
        'id': student.id,
        'name': student.name,
        'mobiles': student.mobile,
        'email': student.email,
        'parent mobile': student.parentPhone,
        'parent email': student.parentEmail,
        'roll no': student.rollNo,
        'gender' : student.gender,
        'dob': student.dob,
        'hobbies': student.hobby,
        'address': student.currAddress
       };


      cr.add(data1);
      notifyListeners();
      return Future.value();
    }
}