import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/services/database.dart';
import 'package:project/shared/constants.dart';
import 'package:project/shared/loading.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/database.dart';

class SettingsForm extends StatefulWidget {
  final String name;
  final String bookName;
  final int days;
  final bool toAdd;

  SettingsForm(
      {this.name = "",
      this.bookName = "DBMS",
      this.days = 1,
      this.toAdd = false});

  @override
  _SettingsFormState createState() => _SettingsFormState(
      currentBook: bookName,
      currentName: name,
      currentdays: days,
      toAdd: toAdd);
}

class _SettingsFormState extends State<SettingsForm> {
  String currentName;
  String currentBook;
  int currentdays;
  bool toAdd;
  _SettingsFormState(
      {this.currentName, this.currentBook, this.currentdays, this.toAdd});

  final _formKey = GlobalKey<FormState>();
  final List bookname = [
    'LOGIIMIX',
    'MATHEMATICS',
    'PYTHON',
    'OPERATING SYSTEM',
    'DBMS'
  ];
  // final List bookname = ["Book1","book2"];

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> _dropDownListTemp = [];
    for (var book in bookname) {
      _dropDownListTemp.add(DropdownMenuItem(child: Text(book), value: book));
    }

    final user = Provider.of<User>(context);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Update your Book Settings',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: currentName,
              decoration: InputDecoration(labelText: "Enter Your Name"),
              validator: (val) => val.isEmpty ? 'Please enter  name' : null,
              onChanged: (val) => setState(() {
                currentName = val;
              }),
            ),
            SizedBox(height: 20.0),
            DropdownButton(
                isExpanded: true,
                value: currentBook,
                items: bookname
                    .map((book) =>
                        DropdownMenuItem(child: Text(book), value: book))
                    .toList(),
                onChanged: (val) => setState(() {
                      currentBook = val;
                    })),
            Slider(
              value: currentdays.toDouble(),
              divisions: 8,
              min: 1,
              max: 8,
              onChanged: (val) => setState(() => currentdays = val.toInt()),
            ),
            RaisedButton(
                color: Colors.blueGrey,
                child: Text(
                  'Select',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (toAdd) {
                      DatabaseService(uid: user.uid).addBook(
                          bookName: currentBook,
                          days: currentdays,
                          studentName: currentName);
                      Navigator.pop(context);
                    } else {
                      DatabaseService(uid: user.uid).updateUserData(
                          currentName, currentBook, currentdays);
                      Navigator.pop(context);
                    }
                  }
                }),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }
}
