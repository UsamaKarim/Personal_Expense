import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/services.dart';

import 'widgets/transaction_chart.dart';
import 'widgets/transaction_card.dart';
import 'widgets/add_transaction.dart';

import 'models/transaction_model.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white, fontSize: 15),
          headline4: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          headline5: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          headline6: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TransactionModel> _userTransactions = [];

  void _addTransactionByUser(
      String title, double amount, DateTime selectedDate) {
    final _addTransaction = TransactionModel(
      amount: amount,
      title: title,
      id: DateTime.now().toString(),
      date: selectedDate,
    );
    setState(() {
      _userTransactions.add(_addTransaction);
    });
  }

  void bottomSheetForAddingTransaction(BuildContext context) {
    showModalBottomSheet(
        context: (context),
        builder: (_) {
          return AddTransaction(_addTransactionByUser);
        });
  }

  List<TransactionModel> get _recentTransactions {
    return _userTransactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere(
        (element) => element.id == id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => bottomSheetForAddingTransaction(context),
        )
      ],
      title: Text('Personal Expenses'),
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => bottomSheetForAddingTransaction(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _userTransactions.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'No transaction found',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  child: Image.asset('assets/images/waiting.png'),
                ),
              ],
            )
          : Column(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: TransactionChart(_recentTransactions),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child: TransactionCard(_userTransactions, _deleteTransaction),
                ),
              ],
            ),
    );
  }
}
