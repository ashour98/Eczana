import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eczane/%D9%8Dservices/DatabaseServer.dart';
import 'package:eczane/models/Medicine.dart';
import 'package:flutter/material.dart';
import 'MyDrawer.dart';

class MedicineStore extends StatefulWidget {
  @override
  _MedicineStoreState createState() => _MedicineStoreState();
}

class _MedicineStoreState extends State<MedicineStore> {
  Future _ADD() async {
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          ' Do you want to add this package ? ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          width: 100.0,
                          child: RaisedButton(
                            onPressed: () {
                              getpackage();

                              setState(() {});

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future _REMOVE() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white.withOpacity(0.80),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Enter product  ID ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          ID = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'ID',
                        border: InputBorder.none,
                      ),
                      controller: _ID,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          width: 100.0,
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {});
                              UpdateMedicine();
                              _ID.clear();

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Remove",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController _NAMEcontroller = TextEditingController();
  TextEditingController _PRIcontroller = TextEditingController();
  TextEditingController _Qcontroller = TextEditingController();
  TextEditingController _IDcontroller = TextEditingController();
  TextEditingController _EXcontroller = TextEditingController();
  TextEditingController _PROcontroller = TextEditingController();
  TextEditingController _ID = TextEditingController();

  String n = "";
  String p = "";
  int q = 0;
  String i = "";
  String e = "";
  int pr = 0;
  String ID = "";

  getpackage() async {



    Medicine post = new Medicine(
        name: n, Exp: e, ID: i, price: p, profits: pr, quantity: q);
    Map<String, dynamic> postData = post.toJson();

    Firestore.instance
        .collection('data')
        .document(DatabaseServer.instance.uid)
        .collection('medicines')
        .document(i)
        .setData(postData);

    _formkey.currentState.reset();

    setState(() {});
  }

  UpdateMedicine() async {



    Firestore.instance
        .collection('data')
        .document(DatabaseServer.instance.uid)
        .collection('medicines')
        .document(ID)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(123, 189, 221, 1), //back
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(66, 160, 206, 1),
          title: new Text(" Add product"),
        ),
        drawer: MyDrawer(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "product Name:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(),
                      height: MediaQuery.of(context).size.height / 13,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.7),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => {n = val});
                            },
                            controller: _NAMEcontroller,
                            validator: (value) {
                              if (value.isEmpty)
                                return "please enter  medicine name";
                              else
                                print("All is Good");
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'name',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Price:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(),
                      height: MediaQuery.of(context).size.height / 13,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.7),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() => {p = val});
                            },
                            controller: _PRIcontroller,
                            validator: (value) {
                              if (value.isEmpty)
                                return "please enter Price";
                              else
                                print("All is Good");
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'price',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Quantity:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(),
                      height: MediaQuery.of(context).size.height / 13,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.7),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() => {q = int.parse(val)});
                            },
                            controller: _Qcontroller,
                            validator: (value) {
                              if (value.isEmpty)
                                return "please enter Quantity";
                              else
                                print("All is Good");
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Qty',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "ID:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(),
                          height: MediaQuery.of(context).size.height / 13,
                          width: MediaQuery.of(context).size.width,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white.withOpacity(0.7),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: new TextFormField(
                                onChanged: (val) {
                                  setState(() => {i = val});
                                },
                                controller: _IDcontroller,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "please enter ID";
                                  else
                                    print("All is Good");
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: 'ID'),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.settings_overscan, color: Colors.grey),
                          onPressed: () {
                            _scan(); // Your codes...
                          },
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Expiry Date:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(),
                      height: MediaQuery.of(context).size.height / 13,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.7),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => {e = val});
                            },
                            controller: _EXcontroller,
                            validator: (value) {
                              if (value.isEmpty)
                                return "please enter Expiry date";
                              else
                                print("All is Good");
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Date',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Profits:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(),
                      height: MediaQuery.of(context).size.height / 13,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.7),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() => {pr = int.parse(val)});
                            },
                            controller: _PROcontroller,
                            validator: (value) {
                              if (value.isEmpty)
                                return "please enter Profits";
                              else
                                print("All is Good");
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'profit'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width / 2 - 16,
                            child: RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  side: BorderSide(color: Colors.black38)),
                              onPressed: () {
                                _REMOVE();
                              },
                              label: Text(
                                "Remove",
                                style: TextStyle(color: Colors.black),
                              ),
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.black,
                              ),
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              child: RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.black38)),
                                onPressed: () async {
                                  if (_formkey.currentState.validate()) {
                                    _formkey.currentState.reset();
                                    _NAMEcontroller.clear();
                                    _Qcontroller.clear();
                                    _EXcontroller.clear();
                                    _IDcontroller.clear();
                                    _PRIcontroller.clear();
                                    _PROcontroller.clear();
                                    _ADD();
                                  }
                                },
                                label: Text(
                                  "ADD",
                                  style: TextStyle(color: Colors.black),
                                ),
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.black,
                                ),
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _scan()async {

    try {
      i = await BarcodeScanner
          .scan(); ////////////////////////////////////////////////////////////////////////////////////
      setState(() {
        // result.add(qrResult);
      });
    } catch (ex) {
      setState(() {
        //  result.add("Unknown Error $ex");
      });
    }

  }
}


