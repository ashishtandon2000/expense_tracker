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

  _showNewExpenseDialog() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => AddExpense(
              addExpense: _addExpense,
            ));
  }

  _addExpense(Expense expense) {
    setState(() {
      dummyExpenses.add(expense);
    });
  }

  _removeExpense(Expense expense){
    int index =  dummyExpenses.indexOf(expense);
    if(index>=0){
      setState(() {
        dummyExpenses.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Removed expense - ${expense.title}"),
         duration: const Duration(seconds: 3),
         action: SnackBarAction(label: "UNDO", onPressed: (){
          setState(() {
            dummyExpenses.insert(index, expense);
          });
        }),),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    print("#DEBUG _ RUNNING - ${dummyExpenses.length}");

    Widget widgetContent = const Center(
      child: Text("No expenses yet"),
    );

    if (dummyExpenses.isNotEmpty){
      widgetContent = ExpensesList(itemsList: dummyExpenses,removeItem: _removeExpense,);
    }
    return Scaffold(
      appBar: AppBar(
        title:  Text("Expense Tracker",style: App.text.text1,),
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
            Chart(expenses: dummyExpenses,),
            Expanded(
              child: widgetContent,
            ),
          ],
        ),
      ),
    );
  }
}
