import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/my_library.dart';
import 'package:project/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

    final CollectionReference libraryCollection=Firestore.instance.collection('booklibrary');

    Future updateUserData(String studentname,String bookname, int days)async{
      return await libraryCollection.document(uid).setData({
         'studentname':studentname,
         'bookname':bookname,
         'days':days,
      });
    }

    List<MyLibrary> _libraryListFromSnapshot(QuerySnapshot snapshot){
        return snapshot.documents.map((doc){
            return MyLibrary(
             studentname :doc.data['studentname']??'',
             bookname:doc.data['bookname']??'b_name',
             days: doc.data['days']??0

            );
        }).toList();
    }

    UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
      return UserData(
        uid: uid,
        studentname: snapshot.data['studentname'],
        bookname: snapshot.data['bookname'],
        days: snapshot.data['days']
      );
    }

    Stream< List<MyLibrary>> get booklibrary{
      return libraryCollection.snapshots()
      .map(_libraryListFromSnapshot);
    }

    Stream<UserData> get userData{
      return libraryCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
    }

}