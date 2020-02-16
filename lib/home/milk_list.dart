//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MilkList extends StatefulWidget {
  @override
  _MilkListState createState() => _MilkListState();
}

class _MilkListState extends State<MilkList> {
  @override
  Widget build(BuildContext context) {
    final milks = Provider.of<List<Milk>>(context)??[];
    return ListView.builder(
      itemCount: milks.length,
      itemBuilder: (context,index){
        return Padding(padding: EdgeInsets.only(top:10.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.brown,
              ),
              title: Text(milks[index].name),
              subtitle: Text("Takes ${milks[index].sugars} sugar(s)"),
            ),
          ),
        ); 
      },
    );
  }
}

class Milk{
  final String name;
  final String sugars;
  final String addon;
  Milk({this.name,this.sugars,this.addon});
}