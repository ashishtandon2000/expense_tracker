import '../entities/expense.dart';

abstract class ExpenseRepository{
  String get  nextExpenseId;

  Stream<List<Expense>> watchExpenses();
  Future<void> addExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(String expenseId);
}