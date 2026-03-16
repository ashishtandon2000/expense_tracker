part of '../widgets.dart';

class Chart extends StatelessWidget{
  const Chart({required this.expenses, super.key});

  final List<Expense> expenses;


  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses: expenses, category: ExpenseCategory.essential),
      ExpenseBucket.forCategory(expenses: expenses, category: ExpenseCategory.nonEssential),
      ExpenseBucket.forCategory(expenses: expenses, category: ExpenseCategory.miscellaneous)
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
      for(final bucket in buckets){
        // total += bucket.totalExpense;
        if (bucket.totalExpense > maxTotalExpense) {
          maxTotalExpense = bucket.totalExpense;
        }
      }
    return maxTotalExpense;
  }


  @override
  Widget build(context){
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...buckets.map((bucket){
                 final fill =  bucket.totalExpense / maxTotalExpense;
                  return Expanded(child: ChartBar(fill: fill));})
              ],
                        ),
            ),
          const SizedBox(height: 15,),
          Row(
            children: [
              for(final category in ExpenseCategory.values)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(categoryIcon[category],
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}
