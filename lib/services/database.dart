import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/my_library.dart';
import 'package:project/models/user.dart';

import '../models/my_library.dart';
import '../models/my_library.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference libraryCollection =
      Firestore.instance.collection('booklibrary');

  Future updateUserData(String studentname, String bookname, int days) async {
    return await libraryCollection.document(uid).setData({
      'studentname': studentname,
      'bookname': bookname,
      'days': days,
    });
  }

  List<MyLibrary> _libraryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return MyLibrary(
          studentname: doc.data['studentname'] ?? '',
          bookname: doc.data['bookname'] ?? 'b_name',
          days: doc.data['days'] ?? 0);
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        studentname: snapshot.data['studentname'],
        bookname: snapshot.data['bookname'],
        days: snapshot.data['days']);
  }

  Stream<List<MyLibrary>> get booklibrary {
    return libraryCollection.snapshots().map(_libraryListFromSnapshot);
  }

  Future get userDataAsFuture {
    return libraryCollection.document(uid).get();
  }

  Stream<UserData> get userData {
    return libraryCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  ///----------------------------------------------------------------------------------------------------------------------

  Stream get booksOfCurrentUser {
    return libraryCollection.document(uid).snapshots();
  }

  Future<List> getAllBooks() async {
    try {
      return await libraryCollection
          .document(uid)
          .get()
          .then((doc) => doc["Books"]);
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future addBook(
      {String studentName,
      String bookName,
      int days,
      MyLibrary myLibrary}) async {
    List bookList = await getAllBooks();
    if (bookList == null) bookList = [];
    bookList
        .add({"studentname": studentName, "bookname": bookName, "days": days});
    return await libraryCollection
        .document(uid)
        .updateData({"Books": bookList});
  }

  Future removeBook(
      {String studentName,
      String bookName,
      int days,
      MyLibrary myLibrary}) async {
    if (myLibrary != null) {
      studentName = myLibrary.studentname;
      bookName = myLibrary.bookname;
      days = myLibrary.days;
    }
    List bookList = await getAllBooks();
    if (bookList == null) return;
    bookList.removeWhere((element) =>
        element["studentname"] == studentName &&
        element["bookname"] == bookName &&
        element["days"] == days);
    return await libraryCollection
        .document(uid)
        .updateData({"Books": bookList});
  }
}
