
import 'dart:ui';

import 'package:expense_tracker/feature/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:expense_tracker/feature/expenses/domain/entities/expense.dart';
import 'package:expense_tracker/feature/expenses/presentation/viewmodels/expense_dashboard_viewmodel.dart';
import 'package:expense_tracker/feature/expenses/presentation/views/expense_editor_sheet.dart';
import 'package:expense_tracker/feature/expenses/presentation/widgets/expense_dashboard_filters.dart';
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
    // final authLoading = context.select<AuthViewModel, bool>((vm)=>vm.isLoading);

    final visibleList = viewModel.visibleExpenses;
    final hasAnyData = viewModel.totalExpensesCount > 0;

    Widget widgetContent = const Center(
      child: Text("No expenses yet"),
    );

    if (hasAnyData){
      widgetContent = const Column(
        children: [
          Filters(),
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
          ),
          PopupMenuButton<String>(
            onSelected: (value) async{
              if (value == 'logout') {
                showBufferScreen(context);
                await context.read<AuthViewModel>().signOut();
                Navigator.of(context).pop();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),

        ],
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: (width < 600)?Column(
          children: [
            (visibleList.isNotEmpty)?Chart(expenses: visibleList,):const SizedBox(),
            Expanded(child: widgetContent)
          ],
        ):Row(
          children: [
            (visibleList.isNotEmpty)?Expanded(child: Chart(expenses: visibleList,)):const SizedBox(),
            Expanded(
              child: widgetContent,
            ),
          ],
        ),
      ),
    );
  }
}

void showBufferScreen(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}