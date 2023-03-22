//login screen
import 'package:digital_handbook/widgets/logincard.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.Login;
  var isLoading = false;
  List<bool> isSelected = [false, true, false];
  List<String> valuelist = ['Teacher', 'Student', 'TG Coordinator'];
  //by default Cusomer is the Users type for signing in, which can be switched on screen
  String selectedvalue = 'Student';
  //you will get Userstype in selectedvalue(string)
  int selectedIndex = 1;

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Container(
          margin: (_authMode == AuthMode.Login)
              ? const EdgeInsets.only(top: 200)
              : const EdgeInsets.only(top: 35),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: (_authMode == AuthMode.Signup)
                      ? Text(
                          'Sign Up As $selectedvalue',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        )
                      : const SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: (_authMode == AuthMode.Signup)
                      ? ToggleButtons(
                          //borderColor: Colors.black,
                          fillColor: Colors.grey[200],
                          borderWidth: 0,
                          selectedBorderColor: Colors.black,
                          selectedColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          constraints:
                              const BoxConstraints(minHeight: 30, minWidth: 60),
                          onPressed: (int index) {
                            setState(() {
                              for (int i = 0; i < isSelected.length; i++) {
                                isSelected[i] = (i == index);
                                selectedvalue = valuelist[index];
                                selectedIndex =
                                    valuelist.indexOf(selectedvalue);
                              }
                            });
                          },
                          isSelected: isSelected,
                          children: <Widget>[
                            Icon(
                              Icons.directions_car_filled_outlined,
                              color: (isSelected[0] == true)
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                            Icon(
                              Icons.person_add_alt_1,
                              color: (isSelected[1] == true)
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                            Icon(
                              Icons.add_business_outlined,
                              color: (isSelected[2] == true)
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                          ],
                        )
                      : const SizedBox(height: 0),
                ),

                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: (_authMode == AuthMode.Login)
                      ? LoginCard()
                      : SizedBox()
                ),

                // ignore: deprecated_member_use
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  // ignore: deprecated_member_use
                  child: ElevatedButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                    onPressed: _switchAuthMode,
                     style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 6.0),
                    foregroundColor: Theme.of(context).primaryColor,
                    //textColor: Theme.of(context).cardColor,
                       )
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top:10),
                child: (_authMode == AuthMode.Login)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right:5, top: 6),
                              child: Text(
                                'By Pratik and Shruti',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 16),
                              ),
                            ),
                            // Image.asset(
                            //   'lib/icons/logo.png',
                            //   //fit: BoxFit.scaleDown,
                            //   filterQuality: FilterQuality.high,
                            //   height: 40,
                            //   width: 100,
                            // ),
                          ],
                        )
                      : const SizedBox(),
                )
              ],
            ),
          ),
        )));
  }
}
