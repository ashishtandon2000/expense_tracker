part of "../widgets.dart";

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.itemsList, super.key});

  final List<Expense> itemsList;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: itemsList.length,
      itemBuilder: (context, index) => ExpensesItem(
        expense: itemsList[index],
      ),
    );
  }
}
