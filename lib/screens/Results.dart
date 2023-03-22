import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    color: Colors.white,
                    child: ListView(
                      children: ListTile.divideTiles(
                        context: context,
                        tiles: [
                          ListTile(
                            leading: const Icon(Icons.lightbulb),
                            title: const Text('AMCAT Results'),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => UsersProfile()));
                            },
                          ),
                           ListTile(
                            leading: Icon(Icons.assignment),
                            title: Text('Academic Results'),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ),
                             onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => UsersProfile()));
                            },
                            ),
                          const ListTile(
                            title: Text(
                                'This list is scrollable if more result sections can be added'),
                          ),
                        ],
                      ).toList(),
                    ))),
        ],
      ),
    );
  }
}