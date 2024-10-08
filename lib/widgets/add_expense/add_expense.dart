part of "../widgets.dart";

class AddExpense extends StatefulWidget {
  const AddExpense({required this.addExpense, super.key});

  final void Function(Expense) addExpense;

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime dateInput = DateTime.now();
  Category categoryInput = Category.essential;

  void _cancelAction() => Navigator.pop(context);

  void _saveAction() {
    print("Saving -> ${titleController.text} ${amountController.text}");
    final isValid = _validateExpense();
    if (!isValid) {
      return;
    }
    widget.addExpense(Expense(
        title: titleController.text,
        amount: int.parse(amountController.text),
        category: categoryInput,
        dateTime: dateInput));

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                    value: categoryInput,
                    items: Category.values
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
                FormButtons(
                  cancelAction: _cancelAction,
                  saveAction: _saveAction,
                ),
              ],
            ),
          )
        ],
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
