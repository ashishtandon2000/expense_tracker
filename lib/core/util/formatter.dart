
import 'package:expense_tracker/backup/models/models.dart';

final formatter = DateFormat.yMd();


String get formattedAmount {
  return amount.toStringAsFixed(2);
}

String get formattedDate {
  return formatter.format(date);
}