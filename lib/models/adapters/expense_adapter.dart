part of '../models.dart';

@HiveType(typeId: 1)
enum ExpenseCategory {
  @HiveField(0)
  essential,
  @HiveField(1)
  nonEssential,
  @HiveField(2)
  miscellaneous,
}

@HiveType(typeId: 2)
enum ExpenseSubCategory {
  @HiveField(0)
  food,
  @HiveField(1)
  living,
  @HiveField(2)
  travel,
  @HiveField(3)
  shopping,
  @HiveField(4)
  other,
}

/// Structure for single Expense object...
@HiveType(typeId: 3)
class Expense  {
  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.subCategory,
    required this.date,
    required this.id,
    required this.isRecurring,
  });

  Expense.create({
    required this.title,
    required this.amount,
    required this.category,
    required this.subCategory,
    DateTime? dateTime,
    String? id,
    this.isRecurring = false,
  })  : id = id?? idGenerator.v4(),
        date = dateTime ?? DateTime.now();

  @HiveField(0)
  final String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2, defaultValue: "undefined-title")
  String title; // If we declare fields final we can not reassign them any value.

  @HiveField(3, defaultValue: 0)
  int amount;

  @HiveField(4,defaultValue: ExpenseCategory.miscellaneous)
  ExpenseCategory category;

  @HiveField(5,defaultValue: ExpenseSubCategory.other)
  ExpenseSubCategory subCategory;

  @HiveField(6)
  final bool isRecurring;

  String get formattedAmount {
    return amount.toStringAsFixed(2);
  }

  String get formattedDate {
    return formatter.format(date);
  }
}