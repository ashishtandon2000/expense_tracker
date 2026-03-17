import 'package:expense_tracker/feature/expenses/domain/entities/expense.dart';
import 'package:expense_tracker/feature/expenses/presentation/viewmodels/expense_dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key});

  showUndoDialog(BuildContext context,Expense expense,Future Function() saveAction){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Removed: ${expense.title}"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(label: "UNDO", onPressed: saveAction),),
    );
  }

  @override
  Widget build(context) {
    return Consumer<ExpenseDashboardViewModel>(
      builder:(context,myProvider,child)=> ListView.builder(
        itemCount: myProvider.visibleExpenses.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(myProvider.visibleExpenses[index]),
          onDismissed: (direction)async{
            final expense = myProvider.visibleExpenses[index];
            await myProvider.deleteExpense(id: expense.id);
            showUndoDialog(context, expense, () async {
              await myProvider.updateExpense(
                id: expense.id,
                title: expense.title,
                amount: expense.amount,
                category: expense.category,
                date: expense.date,
                description: expense.description,
              );
            });
          },
          background: Container(
            color: Theme.of(context).colorScheme.errorContainer,
          ),
          child: ExpenseItem(
            expense: myProvider.visibleExpenses[index],
          ),
        ),
      ),
    );
  }
}