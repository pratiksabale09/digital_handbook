import 'package:digital_handbook/providers/auth_provider.dart';
import 'package:digital_handbook/screens/Userprofile.dart';
import 'package:digital_handbook/screens/add_users.dart';
import 'package:digital_handbook/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // List<bool> isSelected = [false, false, false];
  // List<String> valuelist = ['Users Profile', 'About Us', 'Sign Out'];
  // String selectedvalue = '';
  // int selectedIndex = 4;
  // String title = 'Dashboard';
  // bool isLoading = false;

  // signOut() async {
  //   await showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Are you sure?'),
  //       content: const Text('Do you want to Sign Out'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             setState(() {
  //               isSelected[2] = false;
  //             });
  //             Navigator.pop(context, 'CANCEL');
  //           },
  //           child: const Text('CANCEL'),
  //         ),
  //         const SizedBox(height: 16),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //             Navigator.of(context).pushReplacementNamed('/');
  //             Provider.of<AuthProvider>(context, listen: false).logout();
  //           },
  //           child: const Text("SIGN OUT"),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future<bool> onBackPressed() async {
  //   return (await showDialog(
  //         barrierDismissible: false,
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text('Are you sure?'),
  //           content: const Text('Do you want to exit an App'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, 'Cancel'),
  //               child: const Text('CANCEL'),
  //             ),
  //             const SizedBox(height: 16),
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(true),
  //               child: const Text("LEAVE"),
  //             ),
  //           ],
  //         ),
  //       )) ??
  //       false;
  // }

  @override
  Widget build(BuildContext context) {
      final routeargs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?; 
    final deviceSize = MediaQuery.of(context).size;
    // return WillPopScope(
    //     onWillPop: onBackPressed,
    //     child: Scaffold(
    //       backgroundColor: Colors.grey[500],
    //       drawer: const NavDrawer(),
    //       appBar: AppBar(
    //         title:
    //             (title == 'Sign Out') ? const Text('Dashboard') : Text(title),
    //         // actions: <Widget>[
    //         //   PopupMenuButton<String>(
    //         //       onSelected: onSelect,
    //         //       itemBuilder: (BuildContext context) {
    //         //         return myMenuItems.map((String choice) {
    //         //           return PopupMenuItem<String>(
    //         //             child: Text(choice),
    //         //             value: choice,
    //         //           );
    //         //         }).toList();
    //         //       })
    //         // ],
    //         actions: <Widget>[
    //           ToggleButtons(
    //               fillColor: Theme.of(context).primaryColor,
    //               borderWidth: 0,
    //               children: <Widget>[
    //                 Icon(
    //                   Icons.account_circle_outlined,
    //                   color: (isSelected[0] == true)
    //                       ? Colors.grey[800]
    //                       : Colors.white,
    //                 ),
    //                 Icon(
    //                   Icons.group_rounded,
    //                   color: (isSelected[1] == true)
    //                       ? Colors.grey[800]
    //                       : Colors.white,
    //                 ),
    //                 Icon(
    //                   Icons.logout_rounded,
    //                   color: (isSelected[2] == true)
    //                       ? Colors.grey[800]
    //                       : Colors.white,
    //                 )
    //               ],
    //               onPressed: (int index) async {
    //                 setState(() {
    //                   for (int i = 0; i < isSelected.length; i++) {
    //                     isSelected[i] = (i == index);
    //                     selectedvalue = valuelist[index];
    //                     title = selectedvalue;
    //                     selectedIndex = valuelist.indexOf(selectedvalue);
    //                   }
    //                 });
    //                 if (isSelected[2] == true) {
    //                   signOut();
    //                 }
    //               },
    //               isSelected: isSelected)
    //         ],
    //       ),
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(4),
              child: Center(
                  child: Column(children:  <Widget>[
                
               ElevatedButton(
                    child: const Text('Add Students'),
                    onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddUsersPage()));
                            },
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
              ])),
            ),
          )
        ;
  }
}
