part of "../widgets.dart";

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
    return Consumer<FinanceProvider>(
      builder:(context,myProvider,child)=> ListView.builder(
        itemCount: myProvider.calculatedExpenses.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(myProvider.calculatedExpenses[index]),
          onDismissed: (direction)async{
            final expense = myProvider.calculatedExpenses[index];
            await myProvider.updateExpense(expense,deleteExpense: true);
            showUndoDialog(context,expense,()async{
              await myProvider.updateExpense(expense);
            });
          },
          background: Container(
            color: Theme.of(context).colorScheme.errorContainer,
          ),
          child: ExpensesItem(
            expense: myProvider.calculatedExpenses[index],
          ),
        ),
      ),
    );
  }
}
