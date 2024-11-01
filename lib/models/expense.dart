part of "models.dart";

enum ExpenseCategory { essential, nonEssential, miscellaneous }

enum ExpenseSubCategory { food, living, travel, shopping, other}

const Map<ExpenseCategory, IconData> categoryIcon = {
  ExpenseCategory.essential: Icons.add_chart_rounded,
  ExpenseCategory.nonEssential: Icons.movie,
  ExpenseCategory.miscellaneous: Icons.account_balance_rounded
};

/// Structure for single Expense object...
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.subCategory,
    DateTime? dateTime,
    this.isRecurring = false,
  })  : id = idGenerator.v4(),
        date = dateTime ?? DateTime.now();

  final String id;
  DateTime date;

  String title; // If we declare fields final we can not reassign them any value.
  int amount;
  ExpenseCategory category;
  ExpenseSubCategory subCategory;
  final bool isRecurring;

  String get formattedAmount {
    return amount.toStringAsFixed(2);
  }

  String get formattedDate {
    return formatter.format(date);
  }

  // Convert an Expense object to a JSON map
  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'title': title,
    'amount': amount,
    'category': category.index,
    'subCategory': subCategory.index,
    'isRecurring': isRecurring,
  };

  // Convert a JSON map to an Expense object
  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    title: json['title'],
    amount: json['amount'],
    category: ExpenseCategory.values[json['category']],
    subCategory: ExpenseSubCategory.values[json['subCategory']],
    dateTime: DateTime.parse(json['date']),
    isRecurring: json['isRecurring'] ?? false,
  );
}

/// Structure for collection of Expenses...
class ExpenseBucket {
  const ExpenseBucket({required this.expenses});

  final List<Expense> expenses;

  /// To filter out expenses based on category
  ExpenseBucket.forCategory(
      {required List<Expense> expenses, category})
      : expenses =
            expenses.where((expense) => expense.category == category).toList();

  /// To remove particular expense from bucket
  void removeExpense(Expense expense){
    expenses.remove(expense);
  }

  /// To remove particular expense from bucket
  void addExpense(Expense expense){
    expenses.add(expense);
  }

  double get totalExpense => expenses.fold(0, (sum, expense)=>sum+expense.amount);
}
