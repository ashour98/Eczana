import 'package:eczane/%D9%8Dservices/DatabaseServer.dart';
import 'package:eczane/bodies/MedicineCards.dart';
import 'package:eczane/models/Medicine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyDrawer.dart';

class MyMedicine extends StatefulWidget {
  @override
  _MyMedicineState createState() => _MyMedicineState();
}

class _MyMedicineState extends State<MyMedicine> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Medicine>>.value(
      value: DatabaseServer.instance.medicines,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(123, 189, 221, 1), //back

        appBar: AppBar(
          backgroundColor: Color.fromRGBO(66, 160, 206, 1),
          title: new Text("My Products"),
        ),
        drawer: MyDrawer(),
        body: MedicineCards(),
      ),
    );
  }
}
