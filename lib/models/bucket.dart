part of "models.dart";

class ExpenseBucket{
  const ExpenseBucket({required this.category,required this.expenses});
  final Category category;
  final List<Expense> expenses;

  /// To filter out expenses based on category
  ExpenseBucket.forCategory({required List<Expense> expenses, required this.category}):expenses = expenses.where((expense)=>expense.category == category).toList();

  double get totalExpense{
    double total = 0;
      for (final expense in expenses){
        total += expense.amount;
      }

    return total;
  }
}