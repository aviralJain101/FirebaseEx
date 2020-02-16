import 'package:firebase/services/auth.dart';
import 'package:flutter/material.dart';

import '../loading.dart';

class signInAnon extends StatefulWidget {
final Function toggleView;

  const signInAnon({Key key, this.toggleView}) : super(key: key);

  @override
  _signInAnonState createState() => _signInAnonState();
}

class _signInAnonState extends State<signInAnon> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email;
  String pass;
  String  error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50,left: 50,right: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (val){
                    return val.isEmpty?'Enter an Email':null;
                  },
                decoration: InputDecoration(
                    labelText: 'Email Id',
                    //hintText: 'Email Id'
                  ),
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                }
              ),
              SizedBox(height: 20.0,),
              TextFormField(
               validator: (val){
                    return val.length<6?'Enter password 6 or more char long':null;
                  },
                decoration: InputDecoration(
                    labelText: 'Password',
                    //hintText: 'Password'
                  ),
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    pass=val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                child: Text("Sign In",style: TextStyle(color: Colors.white),),
                color: Colors.pink,
                onPressed: ()async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                     dynamic result = await _auth.signInWithEmailAndPassword(email, pass);
                     if(result == null){
                       setState(() {
                         loading=false;
                         error = 'Invalid credentionls or Register';
                       });
                     } 
                    }
                },
              ),
               SizedBox(height: 20.0,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red,fontSize: 14.0),
                )
            ],
          ),
        )
      ),
    );
  }
}
