import 'dart:async';

import 'package:digital_handbook/login/login.dart';
import 'package:digital_handbook/providers/UserProvider.dart';
import 'package:digital_handbook/providers/auth_provider.dart';
import 'package:digital_handbook/providers/studentprovider.dart';
import 'package:digital_handbook/providers/userprofileprovider.dart';
import 'package:digital_handbook/screens/add_users.dart';
import 'package:digital_handbook/screens/stud_screen.dart';
import 'package:digital_handbook/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async{
    Provider.debugCheckInvalidValueType = null;
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  //flutter run -d chrome --web-hostname localhost --web-port 5000
}



// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider()),
          ProxyProvider<AuthProvider, UsersProvider>(update: (context, auth, x) {
            return UsersProvider(auth);
          }),
           ProxyProvider<AuthProvider, StudentProvider>(update: (context, auth, x) {
            return StudentProvider(auth);
          }),
          ProxyProvider<AuthProvider, UserProfileProvider>(update: (context, auth, x) {
            return UserProfileProvider(auth);
          }),
          // ProxyProvider<AuthProvider, VehicleProvider>(
          //     update: (context, auth, x) {
          //   return VehicleProvider(auth);
          // }),
        ],
        //the materialApp is made the consumer of AuthProvider so as to maintain Users authentication throughout the app
        child: Consumer<AuthProvider>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'Splash Screen',
                  theme: ThemeData(
                    primaryColor: Colors.blue[800],
                  ),
                  home: auth.isAuth
                      ? TabsScreen()
                      // : FutureBuilder(
                      //     future: auth.tryAutoLogin(),
                      //         builder: (ctx, authResultSnapshot) =>
                      //         authResultSnapshot.connectionState ==
                      //                 ConnectionState.waiting
                      //             ? SplashScreen()
                      //             : 
                      //   ),
                      : const AuthCard(),
                  routes: {
                    // DashboardPage().routeName : (context) => DashboardPage(),
                    TabsScreen().routeName : (context) => TabsScreen(),
                    // '/addvehicles': (context) => const AddVehiclePage(),
                    // '/organizations': (context) => const Org_Screen(),
                     '/students': (context) => const Stud_Screen(),
                    // '/settings': (context) => const SettingsPage(),
                  },
                )));
  }
}

//splash screen class to provide "cosmica gps logo" on splash screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey[800],
        child: const Padding(padding: EdgeInsets.all(80),
        child: Text("Welcome"),
        // child:Image.asset('lib/icons/logo.png', fit: BoxFit.scaleDown, height: 3, width: 3,),
        )
    );
  }
}