import 'package:eczane/%D9%8Dservices/auth.dart';

import 'package:eczane/shared/Loading.dart';

import 'package:flutter/material.dart';

import 'Home.dart';
import 'page2.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final authser _auth = authser();

  void initState() {
    setState(() {
      bool loading = false;
    });
  }

  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String email = "";
  String password = "";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color.fromRGBO(123, 189, 221, 1),
            body: Stack(
              children: <Widget>[
                new Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Center(
                            child: Container(
                                height: 150,
                                child: Image.asset("images/logo.png"))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white.withOpacity(0.7),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() => {email = val});
                                },
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "please enter a valid Id";
                                  else
                                    print("All is Good");
                                },
                                decoration: InputDecoration(
                                  labelText: "email",
                                  // hintText: "ID",
                                  icon: new Icon(Icons.email),
                                  border: InputBorder.none,

                                  //fillColor: Colors.green
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white.withOpacity(0.7),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() => {password = val});
                                },
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "please enter your passworld";
                                  else
                                    print("All is Good");
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  // hintText: "ID",
                                  icon: new Icon(Icons.lock),
                                  border: InputBorder.none,
                                  /*  border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),*/
                                  //fillColor: Colors.green
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RaisedButton(
                                  child: new Text('Login'),
                                  onPressed: () async {
                                    if (_formkey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result = await _auth.signemail(
                                          email, password);
                                      if (result == null) {
                                        setState(() {
                                          error = 'wrong email or password';
                                          loading = false;
                                        });
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()));
                                      }
                                    }
                                  },
                                  color: Colors.white,
                                  textColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      side: BorderSide(color: Colors.black38)),
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      side: BorderSide(color: Colors.black38)),
                                  onPressed: () {
                                    _formkey.currentState.reset();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Page2()),
                                    );
                                  },
                                  child: new Text('Sign up'),
                                  color: Colors.white,
                                  textColor: Colors.black,
                                ),
                              ]),
                        ),
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.redAccent),
                      )
                    ]))),
              ],
            ));
  }
}
