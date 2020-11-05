import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction(this.addTransaction);

  final Function addTransaction;

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void addDatatoTransactionCard() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredamount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredamount <= 0 || selectedDate == null) {
      return;
    }
    widget.addTransaction(enteredTitle, enteredamount, selectedDate);
    Navigator.of(context).pop();
  }

  void selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            onSubmitted: (value) => addDatatoTransactionCard(),
            controller: titleController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            onSubmitted: (value) => addDatatoTransactionCard(),
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                selectedDate == null
                    ? ''
                    : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                style: TextStyle(
                  fontSize: 14,
                ),
              )),
              FlatButton(
                onPressed: selectDate,
                child: Text(
                  'Select Date',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          RaisedButton(
            onPressed: addDatatoTransactionCard,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Add Transaction',
              style: TextStyle(
                color: Theme.of(context).textTheme.button.color,
                fontSize: Theme.of(context).textTheme.button.fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
