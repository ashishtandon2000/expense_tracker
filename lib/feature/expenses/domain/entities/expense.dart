import '../../../../core/constants/expense_category.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final String description;
  final DateTime date;

  const Expense(
      {required this.id,
        required this.title,
        required this.amount,
        required this.category,
        required this.date,
        this.description = '',
        });
}


// TODO:
// 1. Add tags.
// 2. Add reoccurring feature later