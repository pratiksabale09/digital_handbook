//add vehicle screen, text form screen with save button

import 'package:digital_handbook/forms/addUserform.dart';
import 'package:digital_handbook/models/http_exception.dart';
import 'package:digital_handbook/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:digital_handbook/providers/UserProvider.dart';

class AddUsersPage extends StatefulWidget {
  const AddUsersPage({Key? key}) : super(key: key);

  @override
  _AddUsersPage createState() => _AddUsersPage();
}

class _AddUsersPage extends State<AddUsersPage> {
  TextEditingController idcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  bool isDisabled = false;
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  bool adderror = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          // ignore: deprecated_member_use
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> saveform(Users user) async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<UsersProvider>(context, listen: false)
          .addUsersInList(user);
    } on HttpException catch (error) {
      adderror = true;
      Navigator.pop(context);
      _showErrorDialog(error.toString());
    } catch (e) {
      adderror = true;
      Navigator.pop(context);
      _showErrorDialog(e.toString());
    }
    if (adderror == false) {
      //print('I am here');
      Fluttertoast.showToast(msg: "Student added successfully");
      Navigator.pop(context); //to pop form screen
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Students"),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  //begin the form
                  child: Column(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UsersForm(
                            idcontroller: idcontroller,
                            passwordcontroller: passwordcontroller,
                            mobileController: mobileController,
                            nameController: nameController,
                            emailController: emailController,
                            roleController: roleController)),
                    Transform.scale(
                        scale: 0.8,
                        child: Wrap(children: <Widget>[
                          CupertinoSwitch(
                            value: isDisabled,
                            onChanged: (value) {
                              setState(() {
                                isDisabled = value;
                              });
                            },
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 8, left: 10),
                              child: InkWell(
                                child: Text(
                                  'Is Disabled',
                                  style: TextStyle(
                                      color: (isDisabled == false)
                                          ? Colors.blueGrey
                                          : Colors.black,
                                      fontSize: 25),
                                ),
                                onTap: () {
                                  setState(() {
                                    isDisabled = !isDisabled;
                                  });
                                },
                              )),
                        ])),
                    ElevatedButton(
                        onPressed: () {
                          Users user = Users.one(
                              id: idcontroller.text,
                              password: passwordcontroller.text,
                              mobile: mobileController.text,
                              name: nameController.text,
                              isDisabled: isDisabled,
                              email: emailController.text,
                              role: roleController.text,
                              );

                          // Provider.of<VehicleProvider>(context, listen: false)
                          //     .addVehicleInList(vehicle);
                          // Fluttertoast.showToast(msg: "Vehicle Added Successfully");
                          // Navigator.of(context).pop(MaterialPageRoute(
                          //     builder: (context) => const Vehicles_Screen()));
                          saveform(user);
                        },
                        child: const Text('Save'))
                  ]),
                ),
              ));
  }
}
