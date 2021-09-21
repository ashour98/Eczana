import 'package:eczane/%D9%8Dservices/DatabaseServer.dart';
import 'package:eczane/push_nofitications/PushNotificationManage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'Sell.dart';
import 'AddStore.dart';
import 'MyMedicine.dart';
import 'MedicineStore.dart';
import 'MyDrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future _getUser() async {
    FirebaseUser mCurrentUser = await FirebaseAuth.instance.currentUser();
    DatabaseServer.get(mCurrentUser.uid);
  }

  initState() {
    _getUser();

    print('Rooooooh');

    PushNotificationsManager().init();

    print('taa3aaa');
  }

  Future _log() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white.withOpacity(0.80),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        ' Are you sure you want to log out ! ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 100.0,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              DatabaseServer.set();
                            });

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                          child: Text(
                            "yes",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final controller = FabCircularMenuController();

    return Scaffold(
      backgroundColor: Color.fromRGBO(222, 234, 247, 1),
      appBar: AppBar(
        //  backgroundColor: Color.fromRGBO(123, 189, 221, 1),
        backgroundColor: Color.fromRGBO(66, 160, 206, 1),
        //backgroundColor: Colors.lightBlueAccent,
        title: new Text("Home"),
      ),
      drawer: MyDrawer(),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/m.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: FabCircularMenu(
              fabColor: Colors.black,
              child: Center(
                  child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Text('How can Eczane help you ?',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.black, fontSize: 36.0)),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset('images/arrow.gif')),
                  ],
                ),
              )),
              ringColor: Colors.black,
              controller: controller,
              options: <Widget>[
                //IconButton(icon: Icon(Icons.widgets), onPressed: () { controller.isOpen = false;}, iconSize: 48.0, color: Colors.black),
                IconButton(
                    tooltip: 'product Store',
                    icon: Icon(
                      Icons.store,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new MedicineStore()));
                    },
                    iconSize: 48.0,
                    color: Colors.white),
                IconButton(
                    tooltip: 'SEll',
                    icon: Icon(
                      Icons.attach_money,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sell()),
                      );
                    },
                    iconSize: 48.0,
                    color: Colors.white),
                IconButton(
                    tooltip: 'Add Store',
                    icon: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddStore()),
                      );
                    },
                    iconSize: 48.0,
                    color: Colors.white),
                IconButton(
                    tooltip: 'My products',
                    icon: Icon(
                      Icons.local_pharmacy,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyMedicine()),
                      );
                    },
                    iconSize: 48.0,
                    color: Colors.white),
                IconButton(
                    tooltip: 'Log Out',
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _log();
                    },
                    iconSize: 48.0,
                    color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
