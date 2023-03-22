import 'package:digital_handbook/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';
import '../providers/studentprovider.dart';
import '../widgets/student_card.dart';

// ignore: camel_case_types
class Stud_Screen extends StatefulWidget {
  const Stud_Screen({Key? key}) : super(key: key);

  @override
  _Stud_ScreenState createState() => _Stud_ScreenState();
}

// ignore: camel_case_types
class _Stud_ScreenState extends State<Stud_Screen> {
  Future<bool> onBackPressed() async {
    return (await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('CANCEL'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("LEAVE"),
              ),
            ],
          ),
        )) ??
        false;
  }

  GlobalKey formKey = GlobalKey();
  TextEditingController searchController = TextEditingController();
  FocusScopeNode searchNode = FocusScopeNode();
  bool isSearching = false;
  List<Student> filteredstudentlist = [];
  String searchstring = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      filteredstudentlist = List<Student>.from(
          Provider.of<StudentProvider>(context, listen: false).getStudents);
    });
    super.didChangeDependencies();
  }

  Future<void> refreshStudents(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<StudentProvider>(context, listen: false)
        .fetchAndSetStudents()
        .then((_) {
      setState(() {
        isLoading = false;
        filteredstudentlist = List<Student>.from(
            Provider.of<StudentProvider>(context, listen: false).getStudents);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Student> studentList =
        List<Student>.from(Provider.of<StudentProvider>(context).getStudents);

    void filterstudents(String string) {
      setState(() {
        if (string.toString().isNotEmpty) {
          isSearching = true;
          filteredstudentlist = studentList
              .where((studentList) =>
                  studentList.name.toLowerCase().contains(string.toLowerCase()))
              .toList();
        } else {
          filteredstudentlist = studentList;
          isSearching = false;
        }
      });
    }

    return Container(
        margin: EdgeInsets.all(5),
        child: SingleChildScrollView(
            child: RefreshIndicator(
                onRefresh: () => refreshStudents(context),
                child: Form(
                    key: formKey,
                    child: FocusScope(
                        node: searchNode,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Container(
                                    height: 35,
                                    child: TextField(
                                      controller: searchController,
                                      onTap: () {
                                        setState(() {
                                          searchNode.requestFocus();
                                        });
                                        setState(() {
                                          isSearching = true;
                                          searchNode.requestFocus();
                                        });
                                      },
                                      onChanged: (value) {
                                        searchstring = value;
                                        searchController.text = value;
                                        searchController.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: searchController
                                                        .text.length));
                                        filterstudents(searchstring);
                                      },
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintStyle:
                                            const TextStyle(fontSize: 17),
                                        labelText: 'Search Student Here',
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            if (isSearching) {
                                              setState(() {
                                                isSearching = false;
                                                searchstring = "";
                                                filterstudents(searchstring);
                                                searchController.clear();
                                                searchNode.unfocus();
                                              });
                                            } else {
                                              setState(() {
                                                isSearching = true;
                                                searchNode.requestFocus();
                                              });
                                            }
                                          },
                                          child: Icon(
                                            isSearching
                                                ? Icons.cancel
                                                : Icons.search,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ))),
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    )
                                  : (filteredstudentlist.isEmpty)
                                      ? Container(
                                          margin: EdgeInsets.all(80),
                                          child: Text('No Students Found!',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black87,
                                              )))
                                      : ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: filteredstudentlist.length,
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(5),
                                          itemBuilder: (context, index) {
                                            return StudentCard(
                                                studentList:
                                                    filteredstudentlist,
                                                student:
                                                    filteredstudentlist[index]);
                                          }),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: 10),
                            //   child: FloatingActionButton.extended(
                            //     onPressed: () {
                            //       Navigator.of(context)
                            //           .push(MaterialPageRoute(
                            //               builder: (context) =>
                            //                   const AddVehiclePage()))
                            //           .then((value) => setState(() {
                            //                 filteredvehiclelist =
                            //                     List<Vehicle>.from(Provider.of<
                            //                                 VehicleProvider>(
                            //                             context,
                            //                             listen: false)
                            //                         .getVehicles);
                            //               }));
                            //     },
                            //     label: const Text('Add Vehicle'),
                            //     backgroundColor: Colors.green,
                            //   ),
                            // ),
                          ],
                        ))))));
  }
}
