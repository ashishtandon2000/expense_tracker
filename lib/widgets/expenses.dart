part of "widgets.dart";

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> dummyExpenses = [
    Expense(
      title: "First Expense",
      amount: 100,
      category: Category.investment,
      dateTime: DateTime.now(),
    ),
    Expense(
        title: "Second Expense",
        amount: 200,
        category: Category.investment,
        dateTime: DateTime.now()),
  ];

  _showNewExpenseDialog(){
    showModalBottomSheet(context: context, builder: (ctx)=> AddExpense(addExpense: _addNewExpense,));
  }

  _addNewExpense(Expense expense){
    setState(() {
      dummyExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _showNewExpenseDialog,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              child: ExpensesList(itemsList: dummyExpenses),
            ),
          ],
        ),
      ),
    );
  }
}
