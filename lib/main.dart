//import 'package:easy_kitchen/profile_screen.dart';
//import 'package:easy_kitchen/signup_screen.dart';
import 'package:easy_kitchen/signup_screen.dart';
import 'package:easy_kitchen/tabs_page.dart';
import 'package:easy_kitchen/test_base.dart';
import 'package:easy_kitchen/views/login_page.dart';
import 'package:easy_kitchen/views/run_recipe.dart';
import 'package:easy_kitchen/views/widgets/detail_screen.dart';
import 'package:easy_kitchen/views/widgets/ingredients_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //runApp(IngredientsScreen());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // home: LoginPage(),
      home: TabsPage(),
    );
  }
}

/*
*  todo list:
* 1- create the main layout of the app (ui only)
* 2- firebase console
* 3- firebase project
* 4-firebase depenedeicie for flutter
* 5- init the firebase app
* 6- create the login function
* 7- create anew user inside our base and test the app
* 8 -input our user data and test the app
*
*
*
* */






