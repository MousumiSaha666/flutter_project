import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget{
  @override
  _Firstpage createState() => _Firstpage();

}

class _Firstpage extends State<Firstpage>{
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
    body:Center(
      child: Image(
        image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQJLM6UWfoPaOnv8TkVGzI2pcuX-ORdLsrKvgi1U5f7F80l_Hwm&usqp=CAU'),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context,'/personal');
      },
      child: Text('click'),
      backgroundColor: Colors.green[200],
    ),
    );
  }
}