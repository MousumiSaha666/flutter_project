import 'package:flutter/material.dart';
import 'package:project/services/auth.dart';
import 'package:project/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project/screens/home/library_list.dart';
import 'package:project/models/my_library.dart';
import 'package:project/screens/home/settings_form.dart';

import '../../models/my_library.dart';
import '../../models/user.dart';
import '../../services/auth.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import 'library_tile.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget drawer(BuildContext context) {
    return Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          //Account Name cannot be displayed since Name is not an input during registration
          accountName: null,
          accountEmail: FutureBuilder(
            future: AuthService().getUserEmail(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.error);
              }
              return CircularProgressIndicator();
            },
          ),
          currentAccountPicture: Icon(
            Icons.account_circle,
            size: 100,
          ),
        ),
        FlatButton.icon(
            onPressed: () => AuthService().signOut(),
            icon: Icon(Icons.account_box),
            label: Text("Sign Out"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm(
                  toAdd: true,
                ),
              );
            }),
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: drawer(context),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Builder(
                    builder: (context) => IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        )),
                Center(
                  child: Text(
                    "Library",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
                      // String studentName = snapshot.data["studentname"];
                      // String bookName = snapshot.data["bookname"];
                      // int days = snapshot.data["days"];

                      List bookList = snapshot.data["Books"];

                      return ListView.builder(
                          itemCount: bookList == null ? 0 : bookList.length,
                          itemBuilder: (context, index) {
                            var book = bookList[index];
                            return LibraryTile(
                              myLibrary: MyLibrary(
                                  studentname: book["studentname"],
                                  bookname: book["bookname"],
                                  days: book["days"]),
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
