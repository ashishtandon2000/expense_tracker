part of "../widgets.dart";

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.itemsList,required this.removeItem, super.key});

  final List<Expense> itemsList;
  final void Function(Expense) removeItem;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: itemsList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(itemsList[index]),
        onDismissed: (direction){
          removeItem(itemsList[index]);

          // itemsList.removeAt(index);
          // // Here we are able to make changes in the expense list of expenses.dart because in dart lists, maps, sets etc are passed by reference.
          // // Because of which child widget and parent widget both are referring to same expense list.
        },
        child: ExpensesItem(
          expense: itemsList[index],
        ),
      ),
    );
  }
}
