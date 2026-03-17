import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();


String formatAmount(double amount) {
  return amount.toStringAsFixed(2);
}

String formatDate(DateTime date) {
  return formatter.format(date);
}