//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/home/milk_list.dart';
import 'package:firebase/home/settings.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService(); 
  @override
  
  Widget build(BuildContext context) {
    void showSettings(){
      showModalBottomSheet(context: context, builder:(context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal:60.0),
          child: Settins(),
          );
      });
    }

     // final milk = Provider.of<QuerySnapshot>(context);
    //print(milk);
      return StreamProvider<List<Milk>>.value(
        value: DatabaseService().milk,
        child: Scaffold(
        appBar: AppBar(
          title: Text("Satvik Mess"),
          actions: <Widget>[
            FlatButton.icon(
              label: Text("LogOut"),
              icon: Icon(Icons.person),
              onPressed: () async {
                return await _auth.signOut();
              },
            ),
            FlatButton.icon(onPressed: showSettings, icon: Icon(Icons.settings), label: Text('Settings'))
          ],
        ),
        body: MilkList(),
      ),
    );
  }
}