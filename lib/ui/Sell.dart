import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eczane/%D9%8Dservices/DatabaseServer.dart';
import 'package:eczane/models/Medicine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'MyDrawer.dart';

class Sell extends StatefulWidget {
  @override
  SellState createState() => SellState();
}

class SellState extends State<Sell> {
  int total = 0;
  TextEditingController _id = TextEditingController();
  TextEditingController _cash = TextEditingController(text: '0');

  Future _bye() async {
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
                    Row(
                      children: <Widget>[
                        Text(
                          'total price =',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          (total).toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Enter cash recived:'),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _cash,
                      decoration: InputDecoration(
                        hintText: 'Cash Recived',
                        border: InputBorder.none,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text('change: '),
                        Text(((int.parse(_cash.text) - total)).toString()),
                      ],
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          updateqantiti();

                          _bye();

                          SetSoldMed();
                          // _cash.clear();
                        },
                        child: Text(
                          "calculate",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  // String result = "'choose different sell method',";
  int t = 1;
  int x = 1;
  String qrResult;
  Future _EnterId() async {
    if (t == 1)
      //result.removeAt(0);
      t++;
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
                    Text(
                      ' Enter ID ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'ID',
                        border: InputBorder.none,
                      ),
                      controller: _id,
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          // result.add(_id.text);
                          getUserTaskList(_id.text);

                          setState(() {});

                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future _scan() async {
    if (t == 1)
      // result.removeAt(0);
      t++;
    try {
      qrResult = await BarcodeScanner
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

  Medicine m = new Medicine(
      quantity: 1,
      profits: 1,
      price: "10",
      ID: "12345679",
      Exp: "23/2",
      name: "dawa");
  static List<Medicine> s = new List<Medicine>();
  Map<String, dynamic> dada;
  SetSoldMed() async {
    x = 0;

    l.forEach((i) async {
      Medicine post = new Medicine(
          // quantity:i.quantity, name: i.name, profits:  i.profits ,ID: i.ID );
          quantity: defaultValue[x],
          name: i.name,
          profits: i.profits * defaultValue[x],
          ID: i.ID);

      Map<String, dynamic> postData = post.toJson();

      Medicine obj;

      Firestore.instance
          .collection('data')
          .document(DatabaseServer.instance.uid)
          .collection('SoldMed')
          .document(i.ID)
          .get()
          .then((docSnapshot) => {
                if(docSnapshot.exists)
                  {
                    print(docSnapshot.exists),
                    print('1'),
                    obj = new Medicine(
                        name: postData["name"],
                        ID: postData["ID"],
                        quantity: dada["quantity"] +
                            postData["quantity"], //snapshot bdl postdata
                        profits:
                            dada["profits"] + postData["profits"]),
                    dada = obj.toJson(),
                    Firestore.instance
                        .collection('data')
                        .document(DatabaseServer.instance.uid)
                        .collection('SoldMed')
                        .document(i.ID)
                        .updateData(dada),
                  }
                else
                  {
                    print(docSnapshot.exists),
                    print('2'),
                    obj = new Medicine(
                        name: postData["name"],
                        ID: postData["ID"],
                        quantity: postData["quantity"] +
                            postData["quantity"], //snapshot bdl postdata
                        profits:
      postData["profits"] + postData["profits"]),
                    dada = postData,
                    print('ayyyy'),
                    Firestore.instance
                        .collection('data')
                        .document(DatabaseServer.instance.uid)
                        .collection('SoldMed')
                        .document(i.ID)
                        .setData(postData)
                  }
              });

      x++;
    });
  }

  updateqantiti() async {
    t = 0;

    l.forEach((i) {
      Firestore.instance
          .collection('data')
          .document(DatabaseServer.instance.uid)
          .collection('medicines')
          .document(i.ID)
          .updateData({"quantity": i.quantity - defaultValue[t]});
      t++;
    });
  }

  getUserTaskList(String id) async {
    print(DatabaseServer.instance.uid);

    DocumentSnapshot snapshot = await Firestore.instance
        .collection('data')
        .document(DatabaseServer.instance.uid)
        .collection('medicines')
        .document(id)
        .get();

    Medicine obj = new Medicine(
        quantity: snapshot["quantity"],
        profits: snapshot["profits"],
        price: snapshot["price"],
        ID: snapshot["ID"],
        Exp: snapshot["Exp"],
        name: snapshot["name"]);

    if (snapshot["quantity"] <= 0) {
      obj = new Medicine(
          quantity: snapshot["quantity"],
          profits: snapshot["profits"],
          price: snapshot["price"],
          ID: snapshot["ID"],
          Exp: snapshot["Exp"],
          name: "This product is not available for now");
      l.add(obj);
    } else {
      l.add(obj);
      total += (int.parse(obj.price));
    }

    setState(() {});

    _id.clear();
  }

  rest() {
    print('good');
    s = l;
    clear();
  }

  List<Medicine> l = new List<Medicine>();

  @override
  void initState() {
    super.initState();
  }

  var defaultValue = [
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(123, 189, 221, 1), //back

      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 160, 206, 1),
        title: new Text("Sell"),
        actions: <Widget>[
          Center(child: Text("reset all")),
          InkWell(child: Icon(Icons.refresh), onTap: () => rest()),
        ],
      ),
      drawer: MyDrawer(),

      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.55,
            child: ListView.builder(
              itemCount: l.length,
              itemBuilder: (_, index) {
                return SizedBox(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        l[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: new Column(
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "price=" +
                                      "\$${int.parse(l[index].price) * defaultValue[index]}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Counter(
                                    initialValue: defaultValue[index],
                                    minValue: 0,
                                    maxValue: 100,
                                    step: 1,
                                    decimalPlaces: 0,
                                    color: Colors.blueGrey,
                                    onChanged: (value) {
                                      setState(() {
                                        if (defaultValue[index] < value)
                                          total += int.parse(l[index].price);

                                        if (defaultValue[index] > value)
                                          total -= int.parse(l[index].price);

                                        defaultValue[index] = value;
                                        print(defaultValue[index]);
                                      });
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
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
                      _scan();
                      getUserTaskList(qrResult);
                    },
                    label: Text(
                      "Scan Barcode",
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.settings_overscan,
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
                          borderRadius: new BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.black38)),
                      onPressed: () async {
                        _EnterId();
                      },
                      label: Text(
                        "ADD Manuel",
                        style: TextStyle(color: Colors.black),
                      ),
                      icon: Icon(
                        Icons.keyboard,
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

      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total   =',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(total.toString() + ' JD',
                    style: TextStyle(color: Colors.black, fontSize: 20.0)),
              ),
            ),
            IconButton(
                icon: Icon(Icons.done_outline),
                onPressed: () {
                  _bye();
                },
                iconSize: 40.0,
                color: Colors.green),
          ],
        ),
      ),
    );
  }

  clear() {
    print('jod');
    l.clear();
    total = 0;
    defaultValue = [
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1
    ];
    setState(() {});
  }
}
