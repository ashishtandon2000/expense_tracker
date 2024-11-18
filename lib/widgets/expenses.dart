part of "widgets.dart";

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final financeProvider = Provider.of<FinanceProvider>(context); // Access provider
    final expenseList = financeProvider.calculatedExpenses;

    Widget widgetContent = const Center(
      child: Text("No expenses yet"),
    );

    if (expenseList.isNotEmpty){
      widgetContent = const Column(
        children: [
          Filters(),
          Expanded(child: ExpensesList()),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: (){
              showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) => const AddExpense());
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
