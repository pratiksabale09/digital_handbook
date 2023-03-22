import 'package:digital_handbook/screens/dashboard.dart';
import 'package:digital_handbook/screens/settings.dart';
import 'package:flutter/material.dart';

import '../screens/stud_screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: const Text(
              'Welcome',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlue[700],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const DashboardPage()))
            },
          ),
     
           ListTile(
            leading: const Icon(Icons.traffic_sharp),
            title: const Text('Trips'),
            onTap: () => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Stud_Screen()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('Settings'),
            onTap: () => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SettingsPage()))
            },
          ),
        ],
      ),
    );
  }
}
