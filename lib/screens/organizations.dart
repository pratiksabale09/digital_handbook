import 'package:digital_handbook/widgets/navdrawer.dart';
import 'package:flutter/material.dart';

class OrgPage extends StatefulWidget {
  const OrgPage({Key? key}) : super(key: key);

  @override
  _OrgPage createState() => _OrgPage();
}

class _OrgPage extends State<OrgPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text("Vehicles"),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Token: Organizations here',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
