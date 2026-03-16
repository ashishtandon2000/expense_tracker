library models;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// models...
part 'expense.dart';
part 'investment.dart';
part 'liquid_fund.dart';
part 'user_finance.dart';
part 'income.dart';

// adapters...
part 'adapters/expense_adapter.dart';

// adapters
part 'models.g.dart';

const idGenerator = Uuid();
final formatter = DateFormat.yMd();

/// Function to register all the hive adapters at once
void registerAdapters(){
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(ExpenseCategoryAdapter());
  Hive.registerAdapter(ExpenseSubCategoryAdapter());
}