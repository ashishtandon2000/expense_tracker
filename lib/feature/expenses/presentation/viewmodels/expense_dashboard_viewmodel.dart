
import 'dart:async';

import 'package:expense_tracker/feature/expenses/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constants/expense_category.dart';
import '../../domain/repositories/expense_repository.dart';


class ExpenseDashboardViewModel extends ChangeNotifier {
  ExpenseDashboardViewModel(this._expenseRepository){
    _startListening();
  }

  final ExpenseRepository _expenseRepository;

  StreamSubscription<List<Expense>>? _subscription;

  final List<Expense> _allExpenses = [];
  List<Expense> visibleExpenses = [];

  String _searchQuery = '';
  ExpenseSort _currentSort = ExpenseSort.latestFirst;

//  ======================================================
//  Public Methods:
//  ======================================================

  Future<void> addExpense({
    required String title,
    required double amount,
    required ExpenseCategory category,
    required DateTime date,
    String description = '',
  })async{
    final newExpenseId =  _expenseRepository.nextExpenseId;
    
    final expense = Expense(id: newExpenseId, title: title, amount: amount, category: category, date: date,description: description);
    await _expenseRepository.addExpense(expense);
  }

  Future<void> updateExpense({
    required String id,
    required String title,
    required double amount,
    required ExpenseCategory category,
    required DateTime date,
    String description = '',
  })async {

    final expense = Expense(id: id, title: title, amount: amount, category: category, date: date,description: description);
    await _expenseRepository.updateExpense(expense);
  }

  Future<void> deleteExpense({required String id})async{
    await _expenseRepository.deleteExpense(id);
  }

  void setSort(ExpenseSort sort) {
    _currentSort = sort;
    _applyFiltersAndSorting();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFiltersAndSorting();
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

//  ======================================================
// Private Methods:
//  ======================================================

  void _startListening() {

    _subscription = _expenseRepository.watchExpenses().listen((expenses) {
      _allExpenses
        ..clear()
        ..addAll(expenses);

      _applyFiltersAndSorting();
      notifyListeners();
    });
  }

  void _applyFiltersAndSorting() {
    List<Expense> filtered = List.from(_allExpenses);

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered
          .where((e) => e.title.toLowerCase().contains(query))
          .toList();
    }

    switch (_currentSort) {
      case ExpenseSort.latestFirst:
        filtered.sort((a, b) => b.date.compareTo(a.date));
        break;

      case ExpenseSort.oldestFirst:
        filtered.sort((a, b) => a.date.compareTo(b.date));
        break;

      case ExpenseSort.amountHighToLow:
        filtered.sort((a, b) => b.amount.compareTo(a.amount));
        break;

      case ExpenseSort.amountLowToHigh:
        filtered.sort((a, b) => a.amount.compareTo(b.amount));
        break;
    }

    visibleExpenses = filtered;
  }
}