import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/provider/provider.dart';
import 'util/util.dart';
import 'database/database.dart';
import 'widgets/widgets.dart';


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

Future appInIt()async{

  // Init & open global DB
  await initDB();

  // Update user data from DB
  await FinanceProvider.instance.initialize();
  return;
}

/*
* TODO:
*  1. Add methods for making changes in FinanceProvider
*  2. Use Finance provider to show data in UI
*
* */