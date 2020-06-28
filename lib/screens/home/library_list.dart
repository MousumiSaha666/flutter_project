import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/models/my_library.dart';
import 'package:project/screens/home/library_tile.dart';

class LibraryList extends StatefulWidget {
  @override
  _LibraryListState createState() => _LibraryListState();
}

class _LibraryListState extends State<LibraryList> {
  @override
  Widget build(BuildContext context) {
    
    final booklibrary =Provider.of< List<MyLibrary>>(context) ?? [];
    
    return ListView.builder(
      itemCount: booklibrary.length,
      itemBuilder: (context,index){
          return LibraryTile(myLibrary : booklibrary[index]);
      },
    );
  }
}