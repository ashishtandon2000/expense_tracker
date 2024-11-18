part of "../widgets.dart";

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  late FinanceProvider financeProvider;

  DateTime dateInput = DateTime.now();
  ExpenseCategory categoryInput = ExpenseCategory.essential;
  ExpenseSubCategory subCategoryInput = ExpenseSubCategory.other;


  void _cancelAction() => Navigator.pop(context);

  void _saveAction() {
    final isValid = _validateExpense();
    if (!isValid) {
      return;
    }
    financeProvider.updateExpense(
        Expense(
        title: titleController.text,
        amount: int.parse(amountController.text),
        category: categoryInput,
        subCategory: subCategoryInput,
        date: DateTime.now(),
        id: idGenerator.v4(),
        isRecurring: false));

    Navigator.pop(context);
  }

  bool _validateExpense() {
    final amount = double.tryParse(amountController.text);

    if (titleController.text.trim() == "" || amount == null || amount <= 0) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text(
                  "Make sure you have entered valid data.",
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text("Okey"))
                ],
              ));
      return false;
    }
    return true;
  }

  void _changeDate() async {
    final currentTime = DateTime.now();
    final initialTime = currentTime.add(-const Duration(days: 365));
    final pickedTime = await showDatePicker(
      context: context,
      firstDate: initialTime,
      lastDate: currentTime,
      initialDate: dateInput,
    );
    if (pickedTime != null) {
      setState(() {
        dateInput = pickedTime;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    financeProvider = Provider.of<FinanceProvider>(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    titleController.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// This will provide the height of offset we are getting from bottom if any. For example when keyboard is opened it will provide the height of keyboard.
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.maxFinite,
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(16,60,16,16+keyboardHeight),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: " Rs. ",
                        label: Text("Amount"),
                      ),
                    ),
                  ),
                  Text(
                    formatter.format(dateInput),
                  ),
                  IconButton(
                    onPressed: _changeDate,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    DropdownButton(
                        value: categoryInput,
                        items: ExpenseCategory.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              categoryInput = value;
                            });
                          }
                        }),
                    const SizedBox(width: 30,),
                    DropdownButton(
                        value: subCategoryInput,
                        items: ExpenseSubCategory.values
                            .map(
                              (subCategory) => DropdownMenuItem(
                            value: subCategory,
                            child: Text(subCategory.name),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              subCategoryInput = value;
                            });
                          }
                        }),
                  ],
                ),
              ),
              FormButtons(
                cancelAction: _cancelAction,
                saveAction: _saveAction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One way of capturing text field inputs....With OnChangeFunction & without controller
// class _AddExpenseState extends State<AddExpense>{
//   late Expense newExpense;
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           TextField(
//             onChanged: (title){
//               newExpense.title = title;
//             },
//             maxLength: 50,
//             decoration: const InputDecoration(
//               label: Text("Title"),
//             ),
//           )
//         ],
//       ),);
//   }
//
// }
