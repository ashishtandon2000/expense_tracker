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

  List<Expense> get amountLowToHigh {
    final List<Expense> sorted = List.from(expenses);
    sorted.sort((a,b)=> b.amount.compareTo(a.amount));
    return sorted;
  }

  List<Expense> get amountHighToLow {
    final List<Expense> sorted = List.from(expenses);
    sorted.sort((a,b)=> a.amount.compareTo(b.amount));
    return sorted;
  }

  List<Expense> get timeLatestFirst {
    final List<Expense> sorted = List.from(expenses);
    sorted.sort((a,b)=>b.date.compareTo(a.date));
    return sorted;
  }

  List<Expense> get timeOldestFirst {
    final List<Expense> sorted = List.from(expenses);
    sorted.sort((a,b)=>a.date.compareTo(b.date));
    return sorted;
  }

  double get totalExpense => expenses.fold(0, (sum, expense)=>sum+expense.amount);
}
