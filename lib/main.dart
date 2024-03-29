import 'package:easy_kitchen/Screens/main_screen.dart';
import 'package:easy_kitchen/Screens/login_screen.dart';
import 'package:easy_kitchen/Screens/my_pantry_screen.dart';
import 'package:easy_kitchen/Screens/rigester_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  runApp(ProviderScope(
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor:  Color.fromRGBO(255, 212, 212, 10),
        accentColor: Color.fromRGBO(167, 93, 93, 10),
        bottomAppBarColor: Color(0xffF0997D),


      ),
      home: MainScreen(),
      routes: {
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
      }
    );
  }
}








