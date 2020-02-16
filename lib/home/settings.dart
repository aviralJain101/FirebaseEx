import 'package:firebase/loading.dart';
import 'package:firebase/models/user.dart';
import 'package:firebase/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settins extends StatefulWidget {
  @override
  _SettinsState createState() => _SettinsState();
}

class _SettinsState extends State<Settins> {
  final List<String> addOn = ['Plain','Haldi','Bournvita']; 
  final _formKey = GlobalKey<FormState>();
  String _currentname;
  String _currentaddOn ;
  String _currentsugars;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Update Your Milk Settings',style: TextStyle(fontSize:18.0),),
              SizedBox(height: 20.0,),
              //name field
              TextFormField(
                validator: (val)=> val.isEmpty?'Please enter a name':null,
                initialValue: userData.name,
                decoration: InputDecoration(
                  labelText: "Enter name",
                 // hintText: _currentname
                ),
                onChanged: (val){
                  setState(() {
                    _currentname = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              //drop down for add On
              DropdownButtonFormField(
                value: _currentaddOn??userData.addon,
                items: addOn.map((add){
                 return DropdownMenuItem(
                   value: add,
                   child: Text("$add Milk"),
                 );
                }).toList(),
                onChanged: (val){setState(() {
                  _currentaddOn = val;
                });},
              ),
              SizedBox(height: 20.0,),
              //slider for sugars
              Slider(
                min: 0.0,
                max: 4.0,
                divisions: 4,
                value: (int.parse(_currentsugars)??int.parse(userData.sugars)).toDouble(), 
                onChanged: (double value) {
                  setState(() {
                    _currentsugars=value.round().toString();
                  });
                },
              ),
              SizedBox(height: 8.0,),
              Text("${int.parse(_currentsugars)??int.parse(userData.sugars)} sugar(s)"),
              SizedBox(height: 20.0,),
              //update button
              RaisedButton(
                color: Colors.pink,
                child: Text('Update',style: TextStyle(color:Colors.white),),
                onPressed: ()async{
                  // print(_currentsugars);
                  // print(_currentaddOn);
                  // print(_currentname);
                  if(_formKey.currentState.validate()){
                  await DatabaseService(uid:user.uid).updateData(
                    _currentname??snapshot.data.name,
                    _currentsugars??snapshot.data.sugars,
                    _currentaddOn??snapshot.data.addon
                  );
                  Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        );
      }
      else{
        return Loading();
      }
    }
  );
  }
}