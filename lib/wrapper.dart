import 'package:firebase/authenticate/authenticate.dart';
import 'package:firebase/home/home.dart';
import 'package:firebase/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user==null){return Login();}
    else{return Home();}
  }
}
