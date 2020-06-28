import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/models/my_library.dart';
import 'package:project/screens/home/library_tile.dart';

class LibraryList extends StatefulWidget {
  final List bookList;
  LibraryList({this.bookList});
  @override
  _LibraryListState createState() => _LibraryListState(bookList: bookList);
}

class _LibraryListState extends State<LibraryList> {
  final List<MyLibrary> bookList;

  _LibraryListState({this.bookList});

  @override
  Widget build(BuildContext context) {
    // final booklibrary = Provider.of<List<MyLibrary>>(context) ?? [];

    return ListView.builder(
      itemCount: bookList == null ? 0 : bookList.length,
      itemBuilder: (context, index) {
        return LibraryTile(myLibrary: bookList[index]);
      },
    );
  }
}
