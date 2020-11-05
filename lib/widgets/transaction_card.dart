import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction_model.dart';

class TransactionCard extends StatefulWidget {
  final List<TransactionModel> addTransaction;
  final Function deleteTx;

  TransactionCard(this.addTransaction, this.deleteTx);

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.addTransaction.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                      child: Text(
                    '\$${widget.addTransaction[index].amount}',
                  )),
                ),
              ),
              title: Text(
                widget.addTransaction[index].title,
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: Text(
                  '${DateFormat.yMMMd().format(widget.addTransaction[index].date)}'),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    widget.deleteTx(widget.addTransaction[index].id);
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          );
        });
  }
}
