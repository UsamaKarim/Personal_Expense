import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction_model.dart';

class TransactionChart extends StatelessWidget {
  TransactionChart(this.recentTransactions);
  final List<TransactionModel> recentTransactions;

  List<Map<String, Object>> get generateChartData {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get spendingOfWeek {
    return generateChartData.fold(
      0.0,
      (previousValue, element) => previousValue + element['amount'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return spendingOfWeek == 0.0
        ? Container()
        : LayoutBuilder(builder: (context, constraints) {
            return Card(
              margin: EdgeInsets.all(20),
              elevation: 50,
              child: Row(
                children: generateChartData.map((e) {
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.15,
                          child: FittedBox(
                            child: Text(
                              '\$${(e['amount'] as double).toStringAsFixed(0)}',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.05,
                        ),
                        Container(
                          width: 10,
                          height: constraints.maxHeight * 0.60,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  color: Color.fromRGBO(220, 220, 220, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              FractionallySizedBox(
                                heightFactor: spendingOfWeek == 0.0
                                    ? 0.0
                                    : (e['amount'] as double) / spendingOfWeek,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.05,
                        ),
                        Container(
                          height: constraints.maxHeight * 0.15,
                          child: FittedBox(
                            child: Text(
                              '${e['day']}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          });
  }
}
