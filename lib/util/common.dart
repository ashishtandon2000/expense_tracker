part of 'util.dart';

void _appPrint(Object? object){
  print(object);
}

String getMonthYearString(){
  final current = DateTime.now();
  final month = DateFormat.MMMM().format(current);
  final year = DateFormat.y().format(current);

  return "$month\_$year";
}

