import 'package:eczane/models/Store.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCards extends StatefulWidget {
  @override
  _StoreCardsState createState() => _StoreCardsState();
}

class _StoreCardsState extends State<StoreCards> {
  @override
  TextEditingController _text = TextEditingController();

  Widget build(BuildContext context) {
    _launchCaller(String num) async {
      String url = "tel:${num}";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    final Storee = Provider.of<List<Store>>(context);

    return ListView.builder(
      itemCount: Storee.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Card(
            color: null,
            margin: EdgeInsets.fromLTRB(6, 4, 6, 0),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      Storee[index].name, //name only
                      style: TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Icon(Icons.note_add),
                      onTap: () {
                        savenote(_text.text,_text.text);
                      },
                    ),
                  ),
                  new FlatButton(
                      color: Colors.green,
                      onPressed: () =>
                          _launchCaller(Storee[index].phone), //phone only
                      child: new Text("Call ")),
                ],
              ),
            ),
          ),
        );
      },
    );
  }void savenote(String note, String od) {
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

                          setState(() {});
                        },
                        child: Text(
                          "save ",
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
}
