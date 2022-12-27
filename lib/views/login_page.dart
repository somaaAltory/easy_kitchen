import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tabs_page.dart';

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
    return Scaffold(
        body:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child:
                const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 44.0,
                      fontWeight: FontWeight.bold),
                ),
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
        ));
  }
}