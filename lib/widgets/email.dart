import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Email extends StatefulWidget {
  final String labelText;
  final Widget prefixIcon;
  TextEditingController controller;

  Email(
      {Key? key, required this.labelText,
      required this.prefixIcon,
      required this.controller}) : super(key: key);

  @override
  State<Email> createState() {
    return _Email();
  }
}

class _Email extends State<Email> {
  String mail = '';
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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintStyle: const TextStyle(fontSize: 17),
                  prefixIcon: widget.prefixIcon,
                  labelText: widget.labelText,
                  contentPadding: const EdgeInsets.all(20),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required.';
                  }
                  String pattern = r'\w+@\w+\.\w+';
                  if (!RegExp(pattern).hasMatch(value)) {
                    return 'Invalid E-mail Address format.';
                  }
                  return null;
                },
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
}
