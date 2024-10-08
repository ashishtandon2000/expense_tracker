part of "models.dart";

const idGenerator = Uuid();
final formatter = DateFormat.yMd();

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.category,
      DateTime? dateTime})
      : id = idGenerator.v4(),
        date = dateTime ?? DateTime.now();

  final String id;
  String title; // If we declare fields final we can not reassign them any value.
  int amount;
  DateTime date;
  Category category;

  String get formattedAmount {
    return amount.toStringAsFixed(2);
  }

  String get formattedDate {
    return formatter.format(date);
  }
}

enum Category { essential, nonEssential, investment }

const Map<Category, IconData> categoryIcon = {
  Category.essential: Icons.add_chart_rounded,
  Category.nonEssential: Icons.movie,
  Category.investment: Icons.account_balance_rounded
};
