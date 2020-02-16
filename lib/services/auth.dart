import 'package:firebase/models/user.dart';
import 'package:firebase/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User userFromFirebase(FirebaseUser user){
    return user!=null?User(uid: user.uid):null;
  }
  //auth change user stream

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(userFromFirebase);
  }

  //anon sign in
  Future signAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in with email and password
  Future signInWithEmailAndPassword(String email,String pass) async{
    try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    FirebaseUser user = result.user;
    return userFromFirebase(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email,String pass) async{
    try{
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    FirebaseUser user = result.user;
      //creating userdatabase with uid
    await DatabaseService(uid:user.uid).updateData('new sattvik member', '2', 'Bournvita');
    return userFromFirebase(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}