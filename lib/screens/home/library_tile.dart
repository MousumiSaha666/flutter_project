import 'package:flutter/material.dart';
import 'package:project/models/my_library.dart';

import 'settings_form.dart';

class LibraryTile extends StatelessWidget {
  final MyLibrary myLibrary;
  LibraryTile({this.myLibrary});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: GestureDetector(
            onTap: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                    child: SettingsForm(
                      bookName: myLibrary.bookname,
                      days: myLibrary.days,
                      name: myLibrary.studentname,
                    ),
                  );
                }),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: 70,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.cyan),
                    ),
                  ),
                  Expanded(
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            myLibrary.studentname,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            myLibrary.bookname,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            myLibrary.days.toString(),
                            style: TextStyle(fontSize: 15),
                          )
                        ]),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black26
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ]),
            )));
  }
}
