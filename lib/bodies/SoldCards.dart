import 'package:eczane/models/Medicine.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SoldCards extends StatefulWidget {
  @override
  _SoldCardsState createState() => _SoldCardsState();
}

class _SoldCardsState extends State<SoldCards> {
  @override
  Widget build(BuildContext context) {
    final sales = Provider.of<List<Medicine>>(context);

    return ListView.builder(
      itemCount: sales.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0), //sales[index].name
          child: Card(
            margin: EdgeInsets.fromLTRB(10, 6, 10, 0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text("${sales[index].profits}"),
                radius: 25,
                backgroundColor: Colors.green[sales[index].quantity % 9 * 100],
              ),
              title: Text(sales[index].name),
              subtitle: Text('Total Sold pecies are ${sales[index].quantity} '),
            ),
          ),
        );
      },
    );
  }
}
