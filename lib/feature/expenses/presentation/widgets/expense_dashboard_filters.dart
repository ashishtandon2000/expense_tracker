import 'package:expense_tracker/core/constants/expense_category.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../viewmodels/expense_dashboard_viewmodel.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ExpenseDashboardViewModel>();
    final currentSort = context.select<ExpenseDashboardViewModel, ExpenseSort>((vm)=>vm.currentSort);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          const Expanded(child: SearchBox()),
          const Text("Sort By: "),
          DropdownButton<ExpenseSort>(
            value: currentSort,
            onChanged: (value) {
              if (value != null) {
                vm.setSort(value);
              }
            },
            items: const [
              DropdownMenuItem(
                value: ExpenseSort.latestFirst,
                child: Text("Latest first"),
              ),
              DropdownMenuItem(
                value: ExpenseSort.oldestFirst,
                child: Text("Oldest first"),
              ),
              DropdownMenuItem(
                value: ExpenseSort.amountLowToHigh,
                child: Text("Low to high"),
              ),
              DropdownMenuItem(
                value: ExpenseSort.amountHighToLow,
                child: Text("High to low"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ExpenseDashboardViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SearchBar(
        elevation: const WidgetStatePropertyAll(0),
        leading: const Icon(Icons.search),
        onChanged: (value) {
          vm.setSearchQuery(value);
        },
      ),
    );
  }
}


void noSearchMatchMsg(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("No matching expenses found"),
      duration: Duration(seconds: 2),
    ),
  );
}