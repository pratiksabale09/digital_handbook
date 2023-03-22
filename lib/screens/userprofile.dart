import 'dart:io';

import 'package:digital_handbook/models/enums/gender.dart';
import 'package:digital_handbook/models/student.dart';
import 'package:digital_handbook/providers/userprofileprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../providers/UserProvider.dart';
import '../providers/studentprovider.dart';

// ignore: must_be_immutable
class UsersProfile extends StatefulWidget {
  bool isHiddenPassword = true;

  UsersProfile({Key? key}) : super(key: key);

  @override
  _UsersProfileState createState() => _UsersProfileState();
}

class _UsersProfileState extends State<UsersProfile> {
  int mailcount = 1;
  int mobilecount = 1;
  int hobbyCount = 1;
  List<Map<String, dynamic>> emailvalues = [];
  List<Map<String, dynamic>> hobbyValues = [];
  List<Map<String, dynamic>> mobilevalues = [];
  final FocusScopeNode node = FocusScopeNode();
  final FocusScopeNode formnode = FocusScopeNode();
  TextEditingController dateinputcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    TextEditingController semailController = TextEditingController();
    TextEditingController rollController = TextEditingController();

  TextEditingController pemailController = TextEditingController();

  TextEditingController pmobController= TextEditingController();

  GlobalKey formKey = GlobalKey();
  String emailkey = 'Primary';
  String mobilekey = 'Mobile';
  String hobbyKey = 'Hobby';
  String genderdropdownvalue = 'Male';
  bool isDisabled = true;


  // Map<String, dynamic> Usersdata = {
  //   'name': '',
  //   'mobile': '',
  //   'password': '',
  //   'Hobby': '',
  //   'gender': '',
  //   'email': List<Map<String,String>>,
  //   'address': '',
  //   'dob': '',
  //   'drivingLicense': '',
  //   'parent_email': '',
  //   'parent_phone': ''
  // };

  Student student = new Student(id: "", password: "password", mobile: [{}], name: "name", isDisabled: false, role: "role", email: "email", currAddress: "currAddress", permanentAddress: "permanentAddress", achievement: [], internship: false, internshipCompanyName: "internshipCompanyName", hobby: [{}], dob: "dob", roleId: "roleId", createdAt: "createdAt", updatedAt: "updatedAt", parentEmail: "parentEmail", parentPhone: "parentPhone", regID: "regID", rememberMe: false, rollNo: "rollNo");

  Gender genderlist = Gender();

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

  Future<void> saveform(Student student) async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<UserProfileProvider>(context, listen: false)
          .updateProfile(student);
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
      Fluttertoast.showToast(msg: "Student added/updated successfully");
      Navigator.pop(context); //to pop form screen
    }
    setState(() {
      isLoading = false;
    });
  }



  void saveData(Student student) {
    
   student.mobile = mobilevalues;
  student.hobby = hobbyValues;
  saveform(student);


    //function from userProider goes here.....
  }

  //function to enable/disable form editing
  void _togglelock() {
    setState(() {
      if (isDisabled == false) {
        saveData(student);
      }
      isDisabled = !isDisabled;
      FocusScope.of(context).unfocus();
    });
  }

  //on update email in dynamic form store in key value pair


  onUpdateHobbies(int index, String val) async {
    int foundKey = -1;
    for (var map in hobbyValues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      hobbyValues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }

    Map<String, dynamic> json = {
      "id": index,
      "value": val,
    };
    hobbyValues.add(json);
  }

  //on update mobile number in dynamic form store in key value pair
  onUpdatemobile(int index, String val) async {
    int foundKey = -1;
    for (var map in mobilevalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      mobilevalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
    };
    mobilevalues.add(json);
  }

  //helper function to dynamically add text fields for mobile numbers
  mobilerow(int index) {
    if (index == 0) {
      mobilekey = 'Mobile';
    } else if (index == 1) {
      mobilekey = 'Home';
    } else if (index == 2) {
      mobilekey = 'Work';
    }
    return Row(
      children: [
        Text(mobilekey),
        const SizedBox(width: 30),
        Expanded(
            child: Form(
                child: FocusScope(
          node: node,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(labelText: mobilekey),
            keyboardType: TextInputType.number,
            maxLength: 10,
            validator: (value) {
              if (value.toString().length != 10) {
                return 'Invalid mobile number!';
              }
            },
            onEditingComplete: node.nextFocus,
            onChanged: (val) {
              onUpdatemobile(index, val);
            },
          ),
        ))),
      ],
    );
  }

  hobbiesRow(int index) {
    if (index == 0) {
      hobbyKey = 'Main Hobby';
    } else if (index == 1) {
      hobbyKey = 'Secondary Hobby';
    } else if (index == 2) {
      hobbyKey = 'Other hobbies';
    }
    return Row(
      children: [
        Text(hobbyKey),
        const SizedBox(width: 30),
        Expanded(
            child: Form(
                child: FocusScope(
          node: node,
          child: TextFormField(
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(labelText: hobbyKey),
            keyboardType: TextInputType.text,
            onEditingComplete: node.nextFocus,
            onChanged: (val) {
              onUpdateHobbies(index, val);
            },
          ),
        ))),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blueGrey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 8.0,
        child: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: FocusScope(
                        node: formnode,
                        child: Column(
                          children: <Widget>[
                            //raisedbutton to enable or disable form editing, kept outside ignorepointer scope to keep it enabled
                            // ignore: deprecated_member_use
                            ElevatedButton(
                                child: (isDisabled)
                                    ? const Text('ENABLE EDIT')
                                    : const Text('SAVE'),
                                onPressed: _togglelock
                                //buttonnode.nextFocus;
                                ,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 6.0),
                                  foregroundColor:
                                      Theme.of(context).primaryColor,
                                  //textColor: Theme.of(context).cardColor,
                                )),
                            //to keep form disabled until edit button is pressed
                            IgnorePointer(
                              ignoring: isDisabled,
                              child: Column(children: <Widget>[
                                //textfield for name
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'Name'),
                                  onSaved: (value) {
                                    student.name = value!;
                                  },
                                  onEditingComplete: formnode.nextFocus,
                                  validator: (value) {
                                    if (value.toString().length < 3) {
                                      return 'Name too short!';
                                    }
                                  },
                                  maxLength: 50,
                                ),
                                //dynamic textfields for multiple mobiles
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: mobilecount,
                                    itemBuilder: (context, index) {
                                      return mobilerow(index);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 115),
                                  child: Row(children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          if (mobilecount < 3) {
                                            mobilecount++;
                                          }
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          if (mobilecount > 1) {
                                            mobilecount--;
                                          }
                                        });
                                      },
                                    ),
                                  ]),
                                ),
                             TextFormField(
                              controller: semailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      labelText: 'Student E-Mail'),
                                  keyboardType: TextInputType.emailAddress,
                                  maxLength: 20,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        (value.length < 5)) {
                                      return 'E-Mail must be greater than 5 characters!';
                                    }
                                    String pattern = r'\w+@\w+\.\w+';
                                    if (!RegExp(pattern).hasMatch(value)) {
                                      return 'Invalid E-mail Address format.';
                                    }
                                    return null;
                                  },
                                  onEditingComplete: node.nextFocus,
                                  onChanged: (val) {
                                    ///////////////////////////////////////////////////////////////////
                                  },
                                  onSaved: (newValue) {
                                    student.email = semailController.text;
                                  },
                                ),

                                //dynamic textfields for multiple emails
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: hobbyCount,
                                    itemBuilder: (context, index) {
                                      return hobbiesRow(index);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 115),
                                  child: Row(children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          if (hobbyCount < 10) {
                                            hobbyCount++;
                                          }
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          if (hobbyCount > 1) {
                                            hobbyCount--;
                                          }
                                        });
                                      },
                                    ),
                                  ]),
                                ),
                                TextFormField(
                                  controller: pemailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      labelText: 'Parent E-Mail'),
                                  keyboardType: TextInputType.emailAddress,
                                  maxLength: 20,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        (value.length < 5)) {
                                      return 'E-Mail must be greater than 5 characters!';
                                    }
                                    String pattern = r'\w+@\w+\.\w+';
                                    if (!RegExp(pattern).hasMatch(value)) {
                                      return 'Invalid E-mail Address format.';
                                    }
                                    return null;
                                  },
                                  onEditingComplete: node.nextFocus,
                                  onChanged: (val) {
                                    ///////////////////////////////////////////////////////////////////
                                  },
                                  onSaved: (newValue) {
                                    student.parentEmail = pemailController.text;
                                  },
                                ),
                                TextFormField(
                                  controller: pmobController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration:
                                      InputDecoration(labelText: 'Parent Phone Number'),
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  validator: (value) {
                                    if (value.toString().length != 10) {
                                      return 'Invalid mobile number!';
                                    }
                                  },
                                  onEditingComplete: node.nextFocus,
                                  onChanged: (val) {
                                    ////////////////////////////////////////////////////////////////////////////////////
                                  },
                                  onSaved: (newValue) {
                                    student.parentPhone = pmobController.text;
                                  },
                                ),

                                  TextFormField(
                                    controller: rollController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration:
                                      InputDecoration(labelText: 'Student Roll Number'),
                                  keyboardType: TextInputType.number,
                                  maxLength: 5,
                                  validator: (value) {
                                    if (value.toString().length != 5) {
                                      return 'Invalid roll number, must be 5 digits';
                                    }
                                  },
                                  onEditingComplete: node.nextFocus,
                                  onChanged: (val) {
                                    ////////////////////////////////////////////////////////////////////////////////////
                                  },
                                  onSaved: (newValue) {
                                    student.rollNo = rollController.text;
                                  },
                                ),
                                Row(children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 80, right: 10, top: 15),
                                    child: Text(
                                      'Gender',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 10),
                                    child:
                                        //gender dropdown
                                        DropdownButton<String>(
                                      value: genderdropdownvalue,
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 8,
                                      style: TextStyle(color: Colors.grey[800]),
                                      underline: Container(
                                        height: 1,
                                        color: Colors.blueGrey[800],
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          genderdropdownvalue = newValue!;
                                          student.gender=
                                              genderdropdownvalue;
                                        });
                                      },
                                      items: <String>[
                                        'Male',
                                        'Female',
                                        'Other',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ]),
                                //dropdowns for Users type and gender selection
                                Row(children: <Widget>[]),
                                //textfield for address
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Address'),
                                  onSaved: (value) {
                                    student.currAddress = value!;
                                  },
                                  onEditingComplete: formnode.nextFocus,
                                ),
                                //textfield for date of birth
                                TextFormField(
                                  controller: dateinputcontroller,
                                  decoration: const InputDecoration(
                                    labelText: 'Date Of Birth',
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101))
                                        .then((pickedDate) {
                                      setState(() {
                                        dateinputcontroller.text = pickedDate
                                            .toString()
                                            .substring(0, 10);
                                      });
                                    });
                                  },
                                  onSaved: (pickedDate) {
                                    student.dob = dateinputcontroller.text;
                                  },
                                  onEditingComplete: formnode.nextFocus,
                                ),
                              ]),
                            ),
                            // ignore: deprecated_member_use
                          ],
                        ))))));
  }

  //function to toggle hide/show password
  void _togglepassview() {
    setState(() {
      widget.isHiddenPassword = !widget.isHiddenPassword;
    });
  }
}
