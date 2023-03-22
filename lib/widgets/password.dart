import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Password extends StatefulWidget {
  bool isHiddenPassword;
  Widget prefixIcon;
  String labelText;
  TextEditingController controller;

  Password(
      {Key? key, required this.isHiddenPassword,
      required this.prefixIcon,
      required this.labelText,
      required this.controller}) : super(key: key);

  @override
  State<Password> createState() {
    return _Password();
  }
}

class _Password extends State<Password> {
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      //begin the form
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: widget.isHiddenPassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintStyle: const TextStyle(fontSize: 17),
                  labelText: widget.labelText,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: InkWell(
                    onTap: _togglepassview,
                    child: Icon(
                      !widget.isHiddenPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                ),
                onChanged: (value) {
                  setState(() {
                    widget.controller.text = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglepassview() {
    setState(() {
      widget.isHiddenPassword = !widget.isHiddenPassword;
    });
  }
}
