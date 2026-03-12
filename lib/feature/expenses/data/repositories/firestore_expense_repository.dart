import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/feature/auth/domain/repositories/auth_repository.dart';
import 'package:expense_tracker/feature/expenses/data/services/firestore_expense_service.dart';
import 'package:expense_tracker/feature/expenses/domain/entities/expense.dart';
import 'package:expense_tracker/feature/expenses/domain/repositories/expense_repository.dart';

class FirestoreExpenseRepository implements ExpenseRepository{

  FirestoreExpenseRepository(this._authRepository,this._expenseService);

  final FirestoreExpenseService _expenseService;
  final AuthRepository _authRepository;

  @override
  Future<void> addExpense(Expense expense) async {
    final user = _authRepository.currentUser;
    if(user==null)throw "User Not found";  //TODO: #ERRO Implement

    await _expenseService.addExpense(user.id, _expenseToMap(expense));
  }


  @override
  Future<void> updateExpense(Expense expense)async {
    final user = _authRepository.currentUser;
    if(user==null)throw "User Not found";   // TODO: #ERRO Implement

    await _expenseService.updateExpense(user.id, expense.id, _expenseToMap(expense));
  }

  @override
  Future<void> deleteExpense(String expenseId)async {
    final user = _authRepository.currentUser;
    if(user==null)throw "User Not found";   // TODO: #ERRO Implement

    await _expenseService.deleteExpense(user.id, expenseId);
  }

  @override
  Stream<List<Expense>> watchExpenses() {
    final user = _authRepository.currentUser;
    if(user==null)throw "User Not found";

    return _expenseService.watchExpenses(user.id).map(_docsToExpenses);
  }
  // ============================================================================
  // Private conversion methods...
  // ============================================================================
  Map<String, dynamic> _expenseToMap(Expense expense){
    return {
      'title': expense.title,
      'amount': expense.amount,
      'category': expense.category.name,
      'description': expense.description,
      'date': Timestamp.fromDate(expense.date),
    };
  }

  List<Expense> _docsToExpenses(QuerySnapshot<Map<String, dynamic>> snapshot){
    return snapshot.docs.map(_docToExpense).toList();
  }

  Expense _docToExpense(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    return Expense(
      id: doc.id,
      title: data['title'],
      amount: (data['amount'] as num).toDouble(),
      category: ExpenseCategory.values.firstWhere((category)=>category.name==data["category"]),
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}