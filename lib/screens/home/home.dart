import 'package:flutter/material.dart';
import 'package:project/services/auth.dart';
import 'package:project/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project/screens/home/library_list.dart';
import 'package:project/models/my_library.dart';
import 'package:project/screens/home/settings_form.dart';

class Home extends StatelessWidget {

  final AuthService _auth =AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder:(context){
        return Container(
          padding: EdgeInsets.symmetric(vertical:20.0, horizontal:60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider< List<MyLibrary>>.value(
        value:DatabaseService().booklibrary,
          child: Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text('My Library'),
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: ()async {
                await _auth.signOut();
            },
          ),
          FlatButton.icon(
            icon:Icon(Icons.settings),
            label: Text('settings'),
            onPressed:() => _showSettingsPanel(),
          )
        ],
      ),
      body: LibraryList(),
      ),
    );
  }
}