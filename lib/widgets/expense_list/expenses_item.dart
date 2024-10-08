part of "../widgets.dart";

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({required this.expense, super.key});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0,horizontal: 10),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 20,),
            Row(
              children: [
                Text(expense.formattedAmount),
                const Spacer(),
                 Row(
                  children: [
                    Icon(categoryIcon[expense.category]),
                    Text(expense.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
