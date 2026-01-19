part of "../widgets.dart";

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({required this.expense, super.key});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title),
            const SizedBox(
              height: 20,
            ),
            if (expense.description.isNotEmpty)
              Text(
                expense.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w300, // thin/light
                      color: Colors.white.withOpacity(0.65),
                      height: 1.3,
                    ),
              ),
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
