import 'package:expense_tracker/core/constants/expense_category.dart';
import 'package:expense_tracker/core/util/formatter.dart';
import 'package:expense_tracker/feature/expenses/domain/entities/expense.dart';
import 'package:flutter/material.dart';

class ExpenseEditor extends StatefulWidget {
  const ExpenseEditor({super.key, this.expense}): editorMode = true;

  const ExpenseEditor.view({super.key, required this.expense}): editorMode = false;

  final Expense? expense;
  final bool editorMode;

  @override
  State<ExpenseEditor> createState() {
    return _ExpenseEditorState();
  }
}

class _ExpenseEditorState extends State<ExpenseEditor> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  DateTime dateInput = DateTime.now();
  ExpenseCategory categoryInput = ExpenseCategory.essential;
  // ExpenseSubCategory subCategoryInput = ExpenseSubCategory.other;

  void _cancelAction() => Navigator.pop(context);

  void _saveAction() {
    final isValid = _validateExpense();
    if (!isValid) {
      return;
    }

    Navigator.pop(context, Expense(
      id: widget.expense?.id ?? "",
      title: titleController.text,
      amount: double.parse(amountController.text),
      category: categoryInput,
      date: dateInput,
      description: descriptionController.text,
    ));
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
  void dispose() {
    super.dispose();

    titleController.dispose();
    amountController.dispose();
    descriptionController.dispose();
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
                    // DropdownButton(
                    //     value: subCategoryInput,
                    //     items: ExpenseSubCategory.values
                    //         .map(
                    //           (subCategory) => DropdownMenuItem(
                    //         value: subCategory,
                    //         child: Text(subCategory.name),
                    //       ),
                    //     )
                    //         .toList(),
                    //     onChanged: (value) {
                    //       if (value != null) {
                    //         setState(() {
                    //           subCategoryInput = value;
                    //         });
                    //       }
                    //     }),
                  ],
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: TextField(
                  controller: descriptionController,
                  minLines: 2,
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)...',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
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


class FormButtons extends StatelessWidget{
  const FormButtons({required this.cancelAction,required this.saveAction, super.key});

  final Function() cancelAction;
  final Function() saveAction;

  @override
  Widget build(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(onPressed: cancelAction, child: const Text("Cancel")),
        const SizedBox(width: 15,),
        ElevatedButton(onPressed: saveAction, child: const Text("Save"))
      ],
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
