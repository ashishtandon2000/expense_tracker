part of "models.dart";

/// Structure for collection of Expenses...
class ExpenseBucket {
  const ExpenseBucket({required this.expenses});

  final List<Expense> expenses;

  /// To filter out expenses based on category
  ExpenseBucket.forCategory(
      {required List<Expense> expenses, category})
      : expenses =
            expenses.where((expense) => expense.category == category).toList();

  /// To remove particular expense from bucket
  void removeExpense(Expense expense){
    expenses.remove(expense);
  }

  /// To remove particular expense from bucket
  void addExpense(Expense expense){
    expenses.add(expense);
  }

  double get totalExpense => expenses.fold(0, (sum, expense)=>sum+expense.amount);
}
