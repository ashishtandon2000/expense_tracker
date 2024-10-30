library database;

import 'package:hive_flutter/adapters.dart';

// late final Box<double>
late final Box userBox;

/// Initial setup required for Hive DB
Future initDB()async{
  await Hive.initFlutter();
  await openGlobalDB();
}

/// Opens all globalDBs of the app
Future openGlobalDB()async{
  userBox = await Hive.openBox<String>('user');
}

/// Function to open the DB, it will return a box with type specified in <T> while calling the function
Future<Box<T>>  openDB<T>(String name,{Duration? openFor}) async{

  /// Open the db...
  final db = await Hive.openBox<T>(name);

  if(openFor!= null){// Close the db if duration is provided (only to be used when we are sure that db is not going to be used after openFor period)
    Future.delayed(openFor,()=> closeDB(db));
  }

  return db;
}

/// Closes the Hive box instantly
void closeDB(Box box)async{
  await box.close();
}
