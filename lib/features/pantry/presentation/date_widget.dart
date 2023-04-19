import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

Future<DateTime?> dateTimeForm(context) async {
  DateTime dateTime = DateTime.now() ;
  return await showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content:Padding(
        padding: const EdgeInsets.all(20.0),
        child: DateTimeFormField(
          mode:DateTimeFieldPickerMode.date ,

          firstDate: DateTime.now(),

          decoration: const InputDecoration(labelStyle: TextStyle(fontSize: 16),
              icon: Icon(Icons.calendar_today), //icon of text field
              labelText: "Enter Expiration Date"),
          dateTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          onDateSelected: (DateTime value){
            dateTime=value;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, dateTime),
          child: const Text('OK'),
        ),
      ],
    ),
  );

}