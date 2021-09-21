import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eczane/%D9%8Dservices/DatabaseServer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Statistic.dart';
import 'Employee.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final CollectionReference data = Firestore.instance.collection('data');
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  static String _uname;
  static String _phname;
  @override
  void initState() {
    setState(() {});
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    FirebaseUser mCurrentUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot names = await Firestore.instance
        .collection("data")
        .document(DatabaseServer.instance.uid)
        .get(); //If //I delete this line everything works fine but I don't have user name.
    print(DatabaseServer.instance);
    _uname = names['name'];

    _phname = names['PharmacyName'];
    setState(() {});

    print(_uname);
    print(_phname);
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          //header
          Center(
            child: new UserAccountsDrawerHeader(
              // those account attripute must be returned from db.........

              accountName: Text(_uname ?? "....."),
              accountEmail: Text(_phname ?? "....."),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.indigo,
                  ),
                ),
              ),
              decoration:
                  new BoxDecoration(color: Color.fromRGBO(66, 160, 206, 1)),
            ),
          ),
          Divider(),
          //pages
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            child: ListTile(
              title: Text('Home Page'),
              leading: Icon(
                Icons.home,
                color: Colors.red,
              ),
            ),
          ),
          Divider(),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => statis()),
              );
            },
            child: ListTile(
              title: Text('Statistics'),
              leading: Icon(
                Icons.insert_chart,
                color: Colors.yellow,
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Employee()),
              );
            },
            child: ListTile(
              title: Text('Employee'),
              leading: Icon(
                Icons.people,
                color: Colors.blue,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
