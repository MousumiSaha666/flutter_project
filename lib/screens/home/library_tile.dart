import 'package:flutter/material.dart';
import 'package:project/models/my_library.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../services/database.dart';
import 'settings_form.dart';

class LibraryTile extends StatefulWidget {
  final MyLibrary myLibrary;
  LibraryTile({this.myLibrary});

  @override
  _LibraryTileState createState() => _LibraryTileState();
}

class _LibraryTileState extends State<LibraryTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 30),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.delete,
          size: 30,
        ),
      ),
      key: Key(DateTime.now().toIso8601String()),
      onDismissed: (direction) {
        DatabaseService(uid: Provider.of<User>(context, listen: false).uid)
            .removeBook(myLibrary: widget.myLibrary);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("${widget.myLibrary.studentname} dismissed"),
        ));
      },
      child: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: GestureDetector(
              onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 60.0),
                      child: SettingsForm(
                        bookName: widget.myLibrary.bookname,
                        days: widget.myLibrary.days,
                        name: widget.myLibrary.studentname,
                      ),
                    );
                  }),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        width: 70,
                        clipBehavior: Clip.hardEdge,
                        child: Icon(
                          Icons.account_circle,
                          size: 70,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            color: Colors.black12),
                      ),
                    ),
                    Expanded(
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.myLibrary.studentname,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "has issued the book ${widget.myLibrary.bookname} for ${widget.myLibrary.days.toString()} days",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black38),
                            ),
                            // SizedBox(height: 10),
                            // Text(
                            //   "${myLibrary.days.toString()} days",
                            //   style: TextStyle(fontSize: 15),
                            // )
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
              ))),
    );
  }
}
