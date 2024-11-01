part of "../widgets.dart";

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key});

  @override
  Widget build(context) {
    return Consumer<FinanceProvider>(
      builder:(context,myProvider,child)=> ListView.builder(
        itemCount: myProvider.user.expenseBucket.expenses.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(myProvider.user.expenseBucket.expenses[index]),
          onDismissed: (direction){
            myProvider.updateExpense(myProvider.user.expenseBucket.expenses[index],deleteExpense: true);

            // itemsList.removeAt(index);
            // // Here we are able to make changes in the expense list of expenses.dart because in dart lists, maps, sets etc are passed by reference.
            // // Because of which child widget and parent widget both are referring to same expense list.
          },
          background: Container(
            color: Theme.of(context).colorScheme.errorContainer,
          ),
          child: ExpensesItem(
            expense: myProvider.user.expenseBucket.expenses[index],
          ),
        ),
      ),
    );
  }
}
