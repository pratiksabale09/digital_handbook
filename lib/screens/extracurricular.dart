import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Extracurricular extends StatefulWidget {
  const Extracurricular({super.key});

  @override
  State<Extracurricular> createState() => _ExtracurricularState();
}

class _ExtracurricularState extends State<Extracurricular> {
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
                            leading: const Icon(Icons.military_tech),
                            title: const Text('Internship'),
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
                            leading: Icon(Icons.emoji_events),
                            title: Text('Certificates'),
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
                            leading: const Icon(Icons.auto_stories),
                            title: const Text('College Group'),
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
                                'This list is scrollable if more details sections can be added'),
                          ),
                        ],
                      ).toList(),
                    ))),
        ],
      ),
    );
  }
}