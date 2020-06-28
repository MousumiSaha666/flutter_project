import 'package:flutter/material.dart';
import 'package:project/models/my_library.dart';

class LibraryTile extends StatelessWidget {

  final MyLibrary myLibrary;
  LibraryTile({this.myLibrary});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:10.0),
      child: Card(
        margin:EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.cyan[myLibrary.days],
          ),
          title: Text(myLibrary.studentname),
          subtitle: Text('has ${myLibrary.bookname} for ${myLibrary.days} days(s)'),
        ),
      )
    );
  }
}