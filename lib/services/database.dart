import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/home/milk_list.dart';
import 'package:firebase/models/user.dart';
//import 'package:flutter/material.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  
  final CollectionReference milkCollection = Firestore.instance.collection('milk');

  Future<void> updateData(String name,String sugars,String addon) async{
    return await milkCollection.document(uid).setData({
      'name':name,
      'sugars':sugars,
      'addon':addon
    });
  }
  //retrieving data from snapshotas a list
  List<Milk> _milkFromData(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Milk(
        name: doc.data['name']??'',
        sugars: doc.data['sugars']??'0',
        addon: doc.data['addon']??''
      );
    }).toList();
  }
//retrieving user data from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      addon: snapshot.data['addon']
    );
  }

  Stream<List<Milk>> get milk {
    return milkCollection.snapshots().map(_milkFromData);
  }

  Stream<UserData> get userData{
    return milkCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}