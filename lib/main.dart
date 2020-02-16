//import 'package:firebase/loading.dart';
import 'package:firebase/models/user.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main(){
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
