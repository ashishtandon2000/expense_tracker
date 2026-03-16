library database;

import 'package:expense_tracker/models/models.dart';
import 'package:hive_flutter/adapters.dart';

import '../util/util.dart';

part 'private_box.dart';

class BoxNames{
  static const expense = "expense";
  static const user = "user";
}

class  CurrentMonthDBs{
  const CurrentMonthDBs({required this.expenseBox});
  // const CurrentMonthDBs({required this.incomeBox, required this.expenseBox, required this.investmentBox, required this.liquidFundBox});
  final PrivateBox<Expense> expenseBox;

  // final PrivateBox<Income> incomeBox;
  // final PrivateBox<Investment> investmentBox;
  // final PrivateBox<LiquidFund> liquidFundBox;
}

class DB {
  DB();

  static late PrivateBox userBox;
  static late CurrentMonthDBs present;
  /// Initial setup required for Hive DB...
  /// 1. Init Flutter
  /// 2. Open globalDBs
  /// 3. Register adapters
  static Future init() async {
    await Hive.initFlutter();
    registerAdapters();

    // Close if any Box is already open
    await Hive.close();
    // Hive.deleteFromDisk(); // delete if required...

    // Open required DBS...
    await _openGlobalDB();
    present = await _openPresentDBs();
  }

  /// Opens all globalDBs of the app
  static Future _openGlobalDB()async{
    // Open and wait set PrivateBox...
    await Hive.openBox(BoxNames.user);
    userBox = PrivateBox(BoxNames.user);
  }

  static Future<CurrentMonthDBs> _openPresentDBs()async{
    final monthYearString = getMonthYearString();

    await Hive.openBox<Expense>("${BoxNames.expense}_$monthYearString");

    return CurrentMonthDBs(
        expenseBox:  PrivateBox<Expense>("${BoxNames.expense}_$monthYearString"),
    );
  }

}


