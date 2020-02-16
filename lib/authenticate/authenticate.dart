import 'package:firebase/authenticate/register.dart';
import 'package:firebase/authenticate/sign_in.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool signInView = true;

  void toggleView(){
    setState(() {
      signInView=!signInView;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(signInView==true){return signInAnon(toggleView: toggleView);}
    else{return Register(toggleView: toggleView);}
  }
}
