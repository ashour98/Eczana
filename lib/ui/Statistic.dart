import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eczane/models/Medicine.dart';
import 'package:eczane/ui/Sell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MyDrawer.dart';
import 'dart:math' as math;
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:eczane/%D9%8Dservices/DatabaseServer.dart';
import 'package:eczane/bodies/SoldCards.dart';
import 'package:provider/provider.dart';

bool f = false;
math.Random random = new math.Random();
List<double> result;
List<double> _generateRandomData(int count) {
  result = <double>[];
  result.clear();

  for (int i = 0; i < count; i++) {
    result.add((random.nextInt(100) + 0.0));
  }

  return result;
}

class statis extends StatefulWidget {
  @override
  _statisState createState() => _statisState();
}

class _statisState extends State<statis> {
  @override
  var data = _generateRandomData(24);

  /// not outo generate but get

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Medicine>>.value(
      value: DatabaseServer.instance.sold,
      child: new Scaffold(
        backgroundColor: Color.fromRGBO(123, 189, 221, 1), //back
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(66, 160, 206, 1),
          title: new Text("Statistics"),
        ),
        drawer: MyDrawer(),
        body: SizedBox(
          height: 700,
          width: 500,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Statistics:',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              InkWell(
                child: Card(
                  child: Container(
                    height: MediaQuery.of(context).size.width / 2,

                    width: MediaQuery.of(context).size.width,
                    // height: double.infinity,
                    child: new Sparkline(
                      data: data,
                      lineColor: Colors.black,
                      fillMode: FillMode.below,
                      fillColor: Colors.black12,
                      pointsMode: PointsMode.all,
                      pointSize: 5.0,
                      pointColor: Colors.red,
                    ),
                  ),
                ),
                onTap: () => setState(() {}),
              ),
              SingleChildScrollView(
                child: Container(height: 270, child: SoldCards()),
              ),
            ],
          ),
        ),

        // )),
      ),
    );
  }
}
