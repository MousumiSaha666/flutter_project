import 'package:flutter/material.dart' ;
import 'package:project/models/user.dart'; 
import 'package:project/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:project/services/auth.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
   value: AuthService().user,
    child:MaterialApp(
      home:Wrapper(),
    ),
    );
  } 
}