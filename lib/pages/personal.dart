import 'package:flutter/material.dart';
class Personal extends StatefulWidget{
  @override
  _PersonalState createState() => _PersonalState();

}

class _PersonalState extends State<Personal>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      title:Text(
        'My Library',
        style: TextStyle(
          fontSize: 50.0,
          fontWeight:FontWeight.bold,
          letterSpacing: 2.0,
          color: Colors.grey[600],
        ),
        ),
      centerTitle: true,
      backgroundColor: Colors.green[200],
    ),
     body:Column(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: <Widget>[
         Container(
           color: Colors.grey[400],
           padding:EdgeInsets.symmetric(),
           child: RaisedButton.icon(
             onPressed: () {},
             icon:Icon(
               Icons.attach_money
             ),
             label:Text('FINE'),
           ),
         ),
         Container(
           color: Colors.grey[400],
           padding:EdgeInsets.symmetric(),
           child: RaisedButton.icon(
             onPressed: () {},
             icon:Icon(
               Icons.library_books
             ),
             label:Text('BOOKS I HAVE'),
           ),
         ),
         Container(
           color: Colors.grey[400],
           padding:EdgeInsets.symmetric(),
           child: RaisedButton.icon(
             onPressed: () {},
             icon:Icon(
               Icons.book
             ),
             label:Text('BORROW'),
           ),
         ),
         
         Container(
           color: Colors.grey[400],
           padding:EdgeInsets.symmetric(),
           child: RaisedButton.icon(
             onPressed: () {},
             icon:Icon(
               Icons.book
             ),
             label:Text('Lend'),
           ),
         ),
         Container(
           color: Colors.grey[400],
           padding:EdgeInsets.symmetric(),
           child: RaisedButton.icon(
             onPressed: () {},
             icon:Icon(
               Icons.alarm
             ),
             label:Text('Reminder'),
           ),

         ),
       ],
     ), 
    );
  }
} 