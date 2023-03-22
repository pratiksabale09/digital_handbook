//edit vehicle screen, text form screen to modify properties of existing vehicle

import 'package:digital_handbook/providers/studentprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../forms/editStudForm.dart';
import '../models/student.dart';

// ignore: must_be_immutable
class EditStudentPage extends StatefulWidget {
  Student gotstudent;
  EditStudentPage({Key? key, required this.gotstudent}) : super(key: key);

  @override
  _EditStudentPage createState() => _EditStudentPage();
}

class _EditStudentPage extends State<EditStudentPage> {
  FocusScopeNode node = FocusScopeNode();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  String? id, password, mobile, name, email, role;

  bool _isLoading = false;
  bool editerror = false;

  @override
  void initState() {
    if (idcontroller.text == "") {
      idcontroller.text = widget.gotstudent.id;
    }
    if (passwordcontroller.text == "") {
      passwordcontroller.text = widget.gotstudent.password;
    }
    if (mobileController.text == "") {
      mobileController.text = widget.gotstudent.mobile[0]['Primary Mobile']!;
    }
    if (nameController.text == "") {
      nameController.text = widget.gotstudent.name;
    }
    if (emailController.text == "") {
      emailController.text = widget.gotstudent.email;
    }
    if (roleController.text == "") {
      roleController.text = widget.gotstudent.role;
    }
    super.initState();
  }

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

  Future<void> saveform(Student student) async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<StudentProvider>(context, listen: false)
          .editStudentInList(widget.gotstudent, student);
    } catch (error) {
      editerror = true;
      Navigator.pop(context);
      const errorMessage = 'Could not edit student. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    if (editerror == false) {
      Fluttertoast.showToast(msg: "Student edited successfully");
      Navigator.pop(context); //to pop form screen
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final vehicle = ModalRoute.of(context)?.settings.arguments as Vehicle;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Students"),
        ),
        body: _isLoading
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
                        child: EditStudForm(
                            idcontroller: idcontroller,
                            passwordcontroller: passwordcontroller,
                            mobileController: mobileController,
                            nameController: nameController,
                            emailController: emailController,
                            roleController: roleController,
                            id: widget.gotstudent.id,
                            password: widget.gotstudent.password,
                            mobile: widget.gotstudent.mobile[0]['Primary Mobile']!,
                            name: widget.gotstudent.name,
                            email: widget.gotstudent.email,
                            role: widget.gotstudent.role)),
                    Transform.scale(
                        scale: 0.8,
                        child: Wrap(children: <Widget>[
                          CupertinoSwitch(
                            value: widget.gotstudent.isDisabled,
                            onChanged: (value) {
                              setState(() {
                                widget.gotstudent.isDisabled = value;
                              });
                            },
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 8, left: 10),
                              child: InkWell(
                                child: Text(
                                  'Student disabled?',
                                  style: TextStyle(
                                      color:
                                          (widget.gotstudent.isDisabled ==
                                                  false)
                                              ? Colors.blueGrey
                                              : Colors.black,
                                      fontSize: 25),
                                ),
                                onTap: () {
                                  setState(() {
                                    widget.gotstudent.isDisabled =
                                        !(widget.gotstudent.isDisabled);
                                  });
                                },
                              )),
                        ])),
                    ElevatedButton(
                        onPressed: () {
                          // Student newstudent = Student.one(
                          //     id: idcontroller.text,
                          //     password: passwordcontroller.text,
                          //     mobile: [{}],
                          //     name: nameController.text,
                          //     isDisabled: widget.gotstudent.isDisabled,
                          //     email: emailController.text,
                          //     role: roleController.text);
                          //saveform(newstudent);
                        },
                        child: const Text('Save'))
                  ]),
                ),
              ));
  }
}
