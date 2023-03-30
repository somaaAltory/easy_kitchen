
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

void showErrorMessage(String message,context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  );
}

// for Login & Register button style
//used in login_screen,register_screen
Widget buttonStyle(String buttonName,String routeName ,String text,context)
{
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,style: TextStyle(
          fontSize: 18,
        ),),
        const SizedBox(
          width: 10,
        ),
        RawMaterialButton(
        onPressed: () {
          Navigator.of(context)
              .pushReplacementNamed(routeName);
        },
        child: Text(
          buttonName,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),]
    ),
  );
}

Widget emailTextFormField(TextEditingController emailController)
{
  return TextFormField(
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (email) =>
    email != null && !EmailValidator.validate(email)
        ? 'Enter a valid email'
        : null,
    decoration: const InputDecoration(
      hintText: AutofillHints.email,
      prefixIcon: Icon(
        Icons.mail,
        color: Colors.black,
      ),
    ),
  );
}

Widget passwordTextFormField(TextEditingController PasswordController)
{

  return TextFormField(
    controller: PasswordController,
    obscureText: true,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) => value != null && value.length < 6
        ? 'Enter min.6 characters'
        : null,
    decoration: const InputDecoration(
      hintText: AutofillHints.password,
      prefixIcon: Icon(
        Icons.lock,
        color: Colors.black,
      ),
    ),
  );
}

Widget addIngredientDialog(context,String title ,String description )
{
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
    title: const Text("Add Ingredient"),
    content: Container(
      width: 400,
      height: 100,
      child: Column(
        children: [
          TextField(
            onChanged: (String value) {
              title = value;
            },
          ),
          TextField(
            onChanged: (String value) {
              description = value;
            },
          ),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
          onPressed: () {
            // setState(() {
            //   //todos.add(title);
            //   // createToDo();
            // });
            Navigator.of(context).pop();
          },
          child: const Text("Add"))
    ],
  );
}



