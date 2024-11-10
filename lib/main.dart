import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/provider/provider.dart';
import 'models/models.dart';
import 'util/util.dart';
import 'database/database.dart';
import 'widgets/widgets.dart';


Future appInIt()async{
  // Init & open global DB
  await DB.init();

  // Update user data from DB
  await FinanceProvider.instance.initialize();

  return;
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appInIt();

  return runApp(
    ChangeNotifierProvider(
      create: (context)=> FinanceProvider.instance,
      child: MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: darkTheme,
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: const Expenses(),
      ),
    ),
  );
}
/*
* TODO:
*  1. Add methods for making changes in FinanceProvider
*  2. Use Finance provider to show data in UI
*  3. Optimize rebuilding
*  4. Add remaining features
*  5. Beautify UI
*
* // For the first version add:
* - Sorting
* - Switching chart between category and sub category
* */