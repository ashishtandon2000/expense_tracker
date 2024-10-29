part of "models.dart";

enum ExpenseCategory { essential, nonEssential, investment }

const Map<ExpenseCategory, IconData> categoryIcon = {
  ExpenseCategory.essential: Icons.add_chart_rounded,
  ExpenseCategory.nonEssential: Icons.movie,
  ExpenseCategory.investment: Icons.account_balance_rounded
};

/// Structure for single Expense object...
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.category,
    DateTime? dateTime,
    this.isRecurring = false,
  })  : id = idGenerator.v4(),
        date = dateTime ?? DateTime.now();

  final bool isRecurring;
  final String id;
  String title; // If we declare fields final we can not reassign them any value.
  int amount;
  DateTime date;
  ExpenseCategory category;

  String get formattedAmount {
    return amount.toStringAsFixed(2);
  }

  String get formattedDate {
    return formatter.format(date);
  }
}

/// Structure for collection of Expenses...
class ExpenseBucket {
  const ExpenseBucket({required this.expenses});

  final List<Expense> expenses;

  /// To filter out expenses based on category
  ExpenseBucket.forCategory(
      {required List<Expense> expenses, category})
      : expenses =
            expenses.where((expense) => expense.category == category).toList();

  double get totalExpense => expenses.fold(0, (sum, expense)=>sum+expense.amount);
}
