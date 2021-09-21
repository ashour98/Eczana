import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eczane/%D9%8Dservices/DatabaseServer.dart';
import 'package:eczane/models/Medicine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicineCards extends StatefulWidget {
  @override
  _MedicineCardsState createState() => _MedicineCardsState();
}

class _MedicineCardsState extends State<MedicineCards> {
  done(int x, od) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser _result = await _auth.currentUser();
    Firestore.instance
        .collection('data')
        .document(DatabaseServer.instance.uid)
        .collection('medicines')
        .document(od)
        .updateData({'quantity': (x + int.parse(next))});

    Firestore.instance
        .collection('data')
        .document(DatabaseServer.instance.uid)
        .collection('medicines')
        .document(od)
        .updateData({'Exp': NewExp});

    setState(() {});
  }

  save(od) async {
    Firestore.instance
        .collection('data')
        .document(DatabaseServer.instance.uid)
        .collection('medicines')
        .document(od)
        .updateData({'note': _text.text});

    setState(() {});
  }

  TextEditingController _Count = TextEditingController();
  TextEditingController _EXP = TextEditingController();
  TextEditingController _text = TextEditingController();
  String next = "";
  String NewExp = "";
  @override
  Widget build(BuildContext context) {
    List<Medicine> medicenee = Provider.of<List<Medicine>>(context);
    var items = List<Medicine>();
    medicenee.forEach((i) {
      items.add(i);
    });

    void filter(String val) {
      List<Medicine> TempList = new List<Medicine>();

      if (val.isNotEmpty) {
        medicenee.forEach((item) {
          if (item.name.contains(val)) {
            TempList.add(item);
          }
        });

        medicenee.clear();
        medicenee.addAll(TempList);
      } else {
        print(items);
        medicenee.clear();
        medicenee.addAll(items);
      }

      setState(() {});
    }

    TextEditingController editingController = TextEditingController();
    List<String> _locations = ['A-Z', 'QTY']; // Option 2
    String _selectedLocation; // Option 2
    ;

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.white.withOpacity(0.7),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 255,
                    child: TextField(
                      controller: editingController,
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: InkWell(
                              onTap: () => filter(editingController.text),
                              child: Icon(Icons.search)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)))),
                      onChanged: (val) {},
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButtonHideUnderline(
                    child: SizedBox(
                      width: 75,
                      height: 30,
                      child: new ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          hint: Text('Sort'), // Not necessary for Option 1
                          value: _selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              //List<Medicine>l=new List<Medicine>();
                              if (newValue == 'QTY')
                                setState(() {
                                  medicenee.clear();
                                  medicenee.addAll(items);

                                  medicenee.sort((a, b) =>
                                      a.quantity.compareTo(b.quantity));
                                });
                              if (newValue == 'A-Z')
                                setState(() {
                                  medicenee.clear();
                                  medicenee.addAll(items);

                                  medicenee
                                      .sort((a, b) => a.name.compareTo(b.name));
                                });
                              print(newValue);
                              _selectedLocation = newValue;
                            });
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: medicenee.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: InkWell(
                      child: Card(
                        margin: EdgeInsets.fromLTRB(10, 6, 10, 0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(medicenee[index].quantity.toString()),
                            radius: 25,
                            backgroundColor: Colors
                                .green[medicenee[index].quantity % 9 * 100],
                          ),
                          title: Text(medicenee[index].name),
                          subtitle: Text(
                              'sell price is  ${medicenee[index].price} Dinar'),
                          trailing: InkWell(
                            child: Icon(Icons.note_add),
                            onTap: () {
                              savenote(
                                  medicenee[index].note, medicenee[index].ID);
                            },
                          ),
                        ),
                      ),
                      onTap: () {
                        INFO(medicenee[index].Exp, medicenee[index].quantity,
                            medicenee[index].ID);
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void savenote(String note, String od) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white.withOpacity(0.80),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 150,
                width: 300,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _text,
                    ),
                    Divider(),
                    SizedBox(
                      width: 100.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          save(od);

                          setState(() {});
                        },
                        child: Text(
                          "save note",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  void INFO(String date, int q, String od) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white.withOpacity(0.80),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 150,
                width: 100,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Center(child: Text('this product is valid tell ${date}')),
                    Divider(),
                    SizedBox(
                      width: 100.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          UpdateCard(q, od);

                          setState(() {});
                        },
                        child: Text(
                          "Update!",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  void UpdateCard(int q, String od) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white.withOpacity(0.80),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 350,
                width: 350,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          '     Enter number of pecies to add or remove  ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onChanged: (val) {
                          setState(() {
                            next = val;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '  number',
                          border: InputBorder.none,
                        ),
                        controller: _Count,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          '     Enter nearest expire date   ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onChanged: (val) {
                          setState(() {
                            NewExp = val;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '  date',
                          border: InputBorder.none,
                        ),
                        controller: _EXP,
                      ),
                      SizedBox(
                        width: 100.0,
                        child: RaisedButton(
                          onPressed: () {
                            done(q, od);

                            setState(() {});
                            _EXP.clear();
                            _Count.clear();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "done",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
