import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/services/database.dart';
import 'package:project/shared/constants.dart';
import 'package:project/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List bookname=['LOGIIMIX','MATHEMATICS','PYTHON','OPERATING SYSTEM','DBMS'];
  // final List bookname = ["Book1","book2"];

 String _currentName = " " ;
 String _currentBook = "DBMS";
 int _currentdays = 1;
 int counter =0;
 
  @override
  Widget build(BuildContext context) {

    List<DropdownMenuItem> _dropDownListTemp = [];
    for (var book in bookname){
      _dropDownListTemp.add(DropdownMenuItem(child:Text(book),value:book));
    }
    
final user = Provider.of<User>(context);
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
      if(snapshot.hasData){

        UserData userData =snapshot.data;
        return SingleChildScrollView(
                  child: Form(
            key: _formKey,
            child:Column(
              children: <Widget>[
                Text(
                  'Update your Book Settings',
                  style:TextStyle(fontSize:18.0),
                ),
                SizedBox(height:20.0),
                TextFormField(
                  initialValue: userData.studentname,
                  decoration: textInputDecoration,
                  validator: (val) =>val.isEmpty ? 'Please enter  name':null,
                  onChanged: (val) => setState(() {
                    if(val.isNotEmpty)
                      _currentName =val;
                    else 
                      _currentName = userData.studentname;
                    }),
                ),
                SizedBox(height:20.0),
                DropdownButton(
                  isExpanded: true,
                  value: _currentBook,
                  items: bookname.map((book) => DropdownMenuItem(child: Text(book),value:book)).toList(),
                  onChanged: (val)=>setState((){_currentBook=val;})
                ),
                Slider(
                  value: (userData.days!=0 ? userData.days : _currentdays).toDouble(),
                  // value: _currentdays,
                  activeColor: Colors.cyan[(_currentdays ?? userData.days).toInt()],
                  // inactiveColor: Colors.cyan[(_currentdays?? userData.days).toInt()],
                  divisions: 8,
                  min: 1,                  
                  max: 8,
                  onChanged: (val) => setState(() =>_currentdays=val.toInt()),
                ),
                RaisedButton(
                  color: Colors.blueGrey,
                  child: Text(
                  'Select',
                  style:TextStyle(color: Colors.white),
                ),
                onPressed:()async{
                  if(_formKey.currentState.validate()){
                    await DatabaseService(uid: user.uid).updateUserData(
                      _currentName ?? userData.studentname,
                      _currentBook ?? userData.bookname,
                      _currentdays ?? userData.days
                    );
                    Navigator.pop(context);
                  }
                }
                ),
                SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
              ],
            ),
          ),
        );
    
      }else{
        return Loading();

        }
      }
    );
  }
}