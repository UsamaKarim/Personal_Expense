import 'package:flutter/foundation.dart';

class TransactionModel {
  final String title;
  final String id;
  final double amount;
  final DateTime date;

  TransactionModel({
    @required this.amount,
    @required this.date,
    @required this.id,
    @required this.title,
  });
}
