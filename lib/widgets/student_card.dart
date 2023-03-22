
import 'package:digital_handbook/providers/studentprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';
import '../screens/editStudent.dart';

// ignore: must_be_immutable
class StudentCard extends StatefulWidget {
  List<Student> studentList;
  Student student;

  StudentCard({Key? key, required this.studentList, required this.student})
      : super(key: key);

  @override
  State<StudentCard> createState() {
    return _StudentCard();
  }
}

class _StudentCard extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditStudentPage(
                                    gotstudent: widget.student,
                                  ))).then((value) => setState(() {
                            widget.studentList = List<Student>.from(
                                Provider.of<StudentProvider>(context,
                                        listen: false)
                                    .getStudents);
                          }));
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                  IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete student?'),
                          content: const Text(
                              'Are you sure you want to delete this student?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('CANCEL'),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<StudentProvider>(context,
                                        listen: false)
                                    .deleteStudent(widget.student);                               
                                Navigator.pop(context, 'deleted');
                              },
                              child: const Text('DELETE'),
                            )
                          ],
                        ),
                      );
                    },
                    color: Theme.of(context).errorColor,
                  ),
                ],
              ),
            ),
            title: Text(widget.student.name),
            subtitle: Text(
              widget.student.name,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
            child: Text(
              widget.student.id,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
