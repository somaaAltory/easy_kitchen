//import 'package:easy_kitchen/profile_screen.dart';
//import 'package:easy_kitchen/signup_screen.dart';
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
      home: MyHomePage(title: 'home'),
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Initialialze Firebase App
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginScreen();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Login function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email ");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    //create the textfiled controller
    TextEditingController _emailController =TextEditingController();
    TextEditingController _passwordController =TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "easy kitchen",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Login",
            style: TextStyle(
                color: Colors.black,
                fontSize: 44.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 44.0,
          ),
           TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration:  const InputDecoration(
              hintText: "User Email",
              prefixIcon: Icon(
                Icons.mail,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 26.0,
          ),
           TextField(
            controller: _passwordController,
            obscureText: true,
            decoration:  const InputDecoration(
              hintText: "User Password",
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            "Don't Remember your Password ?",
            style: TextStyle(color: Colors.blue),
          ),
          const SizedBox(
            height: 18.0,
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor:  Colors.lightBlue,
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              onPressed: () async{
                //let's test the app
                User? user =await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                print(user);
                if(user!= null)
                  {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> TabsPage()));
                        //make new screen
                  }
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
