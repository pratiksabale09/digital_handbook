import 'package:digital_handbook/providers/auth_provider.dart';
import 'package:digital_handbook/screens/Results.dart';
import 'package:digital_handbook/screens/accounts.dart';
import 'package:digital_handbook/screens/dashboard.dart';
import 'package:digital_handbook/screens/extracurricular.dart';
import 'package:digital_handbook/screens/records.dart';
import 'package:digital_handbook/screens/settings.dart';
import 'package:digital_handbook/screens/stud_screen.dart';
import 'package:digital_handbook/screens/Userprofile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
    String routeName = '/tabscreen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {


  List<bool> isSelected = [false];
  List<String> valuelist = ['Sign Out'];
  String selectedvalue = '';
  int selectedIndex = 5;
  bool isLoading = false;

  signOut() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to Sign Out'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                isSelected[0] = false;
              });
              Navigator.pop(context, 'CANCEL');
            },
            child: const Text('CANCEL'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
            child: const Text("SIGN OUT"),
          ),
        ],
      ),
    );
  }

  Future<bool> onBackPressed() async {
    return 
    (
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
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


  
  final List<Map<String, dynamic>> _pages = [
    {
      'page': DashboardPage(),
      'title': 'Dashboard',
    },
    {
      'page': Stud_Screen(),
      'title': 'My Students',
    },
    {
      'page': AccountsPage(),
      'title': 'My Account ',
    },
    {
      'page': Records(),
      'title': 'Records ',
    },
    {
      'page': Extracurricular(),
      'title': 'Extra Curricular ',
    },
    {
      'page': Results(),
      'title': 'Results ',
    },
    // {
    //   'page': Org_Screen(),
    //   'title': 'Organizations',
    // },
    
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'].toString()),
        actions: <Widget>[
              ToggleButtons(
                  fillColor: Theme.of(context).primaryColor,
                  borderWidth: 0,
                  children: <Widget>[
                    Icon(
                      Icons.logout_rounded,
                      color: (isSelected[0] == true)
                          ? Colors.grey[800]
                          : Colors.white,
                    )
                  ],
                  onPressed: (int index) async {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = (i == index);
                        selectedvalue = valuelist[index];
                        selectedIndex = valuelist.indexOf(selectedvalue);
                      }
                    });
                    if (isSelected[0] == true) {
                      signOut();
                    }
                  },
                  isSelected: isSelected)
            ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey[900],
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon:  Icon(Icons.people_sharp),
            label: 'My Students',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.person_rounded),
            label: 'My Account',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.description_outlined),
            label: 'Records',
          ),
           BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.card_membership_outlined),
            label: 'Extra-Curricular',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.library_books_outlined),
            label: 'Results',
          ),
          //  BottomNavigationBarItem(
          //   backgroundColor: Theme.of(context).primaryColor,
          //   icon: Icon(Icons.business_rounded),
          //   title: Text('Organizations'),
          // ),
           
        ],
      ),
    )
    );
  }
}

