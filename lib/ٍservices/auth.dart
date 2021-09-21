import 'package:eczane/models/User.dart';

import 'DatabaseServer.dart';

import 'package:firebase_auth/firebase_auth.dart';

class authser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
// create object based on firebase
  User _userfromfirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //  .map((FirebaseUser user )=>_userfromfirebase(user));
        .map(_userfromfirebase);
  }

  //sign with email and pass
  Future signemail(String email, String pass) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return _userfromfirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future store(String uid, String name, String phone) async {
    await DatabaseServer.instance.addStore(name, phone);
  }

  Future employ(String uid, String name, String phone) async {
    await DatabaseServer.instance.addEmployee(uid, name, phone);
  }

  //regist with email and pass
  Future registemail(
      String email, String pass, String name, String PharmacyName) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = result.user;
      //create a doc for user with his uid
      DatabaseServer.get(user.uid);
      print(user.uid);
      await DatabaseServer.get(user.uid).updatedata(name, PharmacyName);
      return _userfromfirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registemployee(String Admin, String email, String pass) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = result.user;
      //create a doc for user with his uid

      await DatabaseServer.instance.addEmployee(Admin, email, pass);

      return _userfromfirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
