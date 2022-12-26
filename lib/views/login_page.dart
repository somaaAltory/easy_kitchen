import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 60),
            Text(
              'Hello Again!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome back!',
              style: TextStyle( fontSize: 24),
            ),
            SizedBox(height: 10),

            //email textfeild

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration
                  (
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    decoration: InputDecoration
                      (
                      border: InputBorder.none,
                      hintText: 'Email',

                    ),
                  ),
                ),
              ),
            ),

            // password textfeild
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration
                  (
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration
                      (
                      border: InputBorder.none,
                      hintText: 'Password',

                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            //signin button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration
                  (
                  color: Colors.deepPurple,

                ),
                child: Center(child: Text('Sign In')),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
