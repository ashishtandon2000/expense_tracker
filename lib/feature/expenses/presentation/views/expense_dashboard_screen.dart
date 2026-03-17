
import 'package:expense_tracker/feature/expenses/domain/entities/expense.dart';
import 'package:expense_tracker/feature/expenses/presentation/viewmodels/expense_dashboard_viewmodel.dart';
import 'package:expense_tracker/feature/expenses/presentation/views/expense_editor_sheet.dart';
import 'package:expense_tracker/feature/expenses/presentation/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/chart/chart.dart';

class ExpenseDashboardScreen extends StatelessWidget {
  const ExpenseDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final viewModel = Provider.of<ExpenseDashboardViewModel>(context); // Access provider
    final expenseList = viewModel.visibleExpenses;

    Widget widgetContent = const Center(
      child: Text("No expenses yet"),
    );

    if (expenseList.isNotEmpty){
      widgetContent = const Column(
        children: [
          // Filters(),
          Expanded(child: ExpensesList()),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Balancio – Expense Tracker"),
        actions: [
          IconButton(
            onPressed: ()async{
              final result = await showModalBottomSheet<Expense>(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) =>const ExpenseEditor());

              if(result==null)return;

              viewModel.addExpense(title: result.title, amount: result.amount, category: result.category, date: result.date,description: result.description);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: (width < 600)?Column(
          children: [
            (expenseList.isNotEmpty)?Chart(expenses: expenseList,):const SizedBox(),
            Expanded(child: widgetContent)
          ],
        ):Row(
          children: [
            (expenseList.isNotEmpty)?Expanded(child: Chart(expenses: expenseList,)):const SizedBox(),
            Expanded(
              child: widgetContent,
            ),
          ],
        ),
      ),
    );
  }
}