import 'package:flutter/material.dart';
import 'package:project/services/auth.dart';
import 'package:project/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project/screens/home/library_list.dart';
import 'package:project/models/my_library.dart';
import 'package:project/screens/home/settings_form.dart';

import '../../models/my_library.dart';
import '../../models/user.dart';
import '../../services/database.dart';
import 'library_tile.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "Library",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: DatabaseService(uid: Provider.of<User>(context).uid)
                      .booksOfCurrentUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String studentName = snapshot.data["studentname"];
                      String bookName = snapshot.data["bookname"];
                      int days = snapshot.data["days"];
                      return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return LibraryTile(
                              myLibrary: MyLibrary(
                                  studentname: studentName,
                                  bookname: bookName,
                                  days: days),
                            );
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );

    // return StreamBuilder(
    //   stream: DatabaseService(uid: Provider.of<User>(context).uid)
    //       .booksOfCurrentUser,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       List<MyLibrary> libraryList = [];
    //       MyLibrary item = MyLibrary(
    //           bookname: snapshot.data["bookname"],
    //           days: snapshot.data["days"],
    //           studentname: snapshot.data["studentname"]);
    //       libraryList.add(item);

    //       return Scaffold(
    //         backgroundColor: Colors.blueGrey[100],
    //         appBar: AppBar(
    //           title: Text('My Library'),
    //           backgroundColor: Colors.blueGrey[400],
    //           elevation: 0.0,
    //           actions: <Widget>[
    //             FlatButton.icon(
    //               icon: Icon(Icons.person),
    //               label: Text('logout'),
    //               onPressed: () async {
    //                 await _auth.signOut();
    //               },
    //             ),
    //             FlatButton.icon(
    //               icon: Icon(Icons.settings),
    //               label: Text('settings'),
    //               onPressed: () => _showSettingsPanel(),
    //             )
    //           ],
    //         ),
    //         body: LibraryList(
    //           bookList: libraryList,
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return Center(
    //         child: Text("Error : ${snapshot.error}"),
    //       );
    //     }
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }
}
