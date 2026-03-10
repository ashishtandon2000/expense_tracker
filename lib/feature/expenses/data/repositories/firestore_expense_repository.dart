

import 'package:expense_tracker/feature/expenses/data/services/firestore_expense_service.dart';
import 'package:expense_tracker/feature/expenses/domain/entities/expense.dart';
import 'package:expense_tracker/feature/expenses/domain/repositories/expense_repository.dart';

class FirestoreExpenseRepository implements ExpenseRepository{

  FirestoreExpenseRepository(FirestoreExpenseService service):_expenseService = service;

  final FirestoreExpenseService _expenseService;

  @override
  Future<void> addExpense(Expense expense) {
    // TODO: implement addExpense
    throw UnimplementedError();
  }


  @override
  Future<void> updateExpense(Expense expense) {
    // TODO: implement updateExpense
    throw UnimplementedError();
  }

  @override
  Future<void> deleteExpense(String expenseId) {
    // TODO: implement deleteExpense
    throw UnimplementedError();
  }

  @override
  Stream<List<Expense>> watchExpenses() {
    // TODO: implement watchExpenses
    throw UnimplementedError();
  }
}