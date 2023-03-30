import 'package:easy_kitchen/views/recipe_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RunRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food recipe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      // home: HomePage(),
    );
  }
}
