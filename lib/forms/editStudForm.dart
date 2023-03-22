//a text form to add vehicle

import 'package:digital_handbook/models/User.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditStudForm extends StatefulWidget {
  FocusScopeNode node = FocusScopeNode();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  String id,
      password,
      mobile,
      name,
      email,
      role;
  bool isDisabled = false;

  EditStudForm(
      {Key? key,
      required this.idcontroller,
      required this.passwordcontroller,
      required this.mobileController,
      required this.nameController,
      required this.emailController,
      required this.roleController,
      required this.id,
      required this.password,
      required this.mobile,
      required this.name,
      required this.email,
      required this.role})
      : super(key: key);

  @override
  _EditStudForm createState() => _EditStudForm();
}

class _EditStudForm extends State<EditStudForm> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formkey,
        child: FocusScope(
          node: widget.node,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            //begin the form
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.idcontroller.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 17),
                      labelText: 'Student id',
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onEditingComplete: widget.node.nextFocus,
                    onChanged: (value) {
                      setState(() {
                        widget.idcontroller.text = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.passwordcontroller.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 17),
                      labelText: "Password",
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onEditingComplete: widget.node.nextFocus,
                    onChanged: (value) {
                      setState(() {
                        widget.passwordcontroller.text = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.mobileController.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 17),
                      labelText: 'Mobile',
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onEditingComplete: widget.node.nextFocus,
                    onChanged: (value) {
                      setState(() {
                        widget.mobileController.text = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.nameController.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 17),
                      labelText: 'Name',
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onEditingComplete: widget.node.nextFocus,
                    onChanged: (value) {
                      setState(() {
                        widget.nameController.text = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.emailController.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 17),
                      labelText: 'email',
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onEditingComplete: widget.node.nextFocus,
                    onChanged: (value) {
                      setState(() {
                        widget.emailController.text = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.roleController.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 17),
                      labelText: 'Role',
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onEditingComplete: widget.node.nextFocus,
                    onChanged: (value) {
                      setState(() {
                        widget.roleController.text = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
