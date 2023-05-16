import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:responsive_login_page/widgets/pallete.dart';

import 'screens/homescreen.dart';
import 'screens/login_screen.dart';
import 'screens/reset_pass.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late StreamSubscription<User?> user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) { 
      if (user == null) {
        print("User is currently signed out");
      }else{
        print("Iser is signed in");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 
      FirebaseAuth.instance.currentUser == null?'login':'home',

      routes: {
        'login':(context) =>const login_screen(),
        'home':(context)=>const HomeScreen(),
        'reset':(context) =>const ResetPassword() 


      },

    );
  }
}
