import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';
import 'database/database.dart';
import 'widgets/widgets.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appInIt();

  return runApp(
    MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: darkTheme,
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: const Expenses(),
    ),
  );
}

Future appInIt()async{

  // Init & open global DB
  await initDB();
  return;
}

/*
* TODO:
*  1. Add methods for making changes in FinanceProvider
*  2. Use Finance provider to show data in UI
*
* */