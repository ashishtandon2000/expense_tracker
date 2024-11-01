part of 'provider.dart';

class CurrentMonthDBs {
  const CurrentMonthDBs({required this.incomeBox, required this.expenseBox, required this.investmentBox, required this.liquidFundBox});
  final Box<Income> incomeBox;
  final Box expenseBox;
  final Box<Investment> investmentBox;
  final Box<LiquidFund> liquidFundBox;
}

/// This provider serves as intermediate between DB, UI
class FinanceProvider extends ChangeNotifier{

  // 1. Create a private constructor...
  FinanceProvider._privateConstructor();

  // 2. Create Instance of class...
  static final FinanceProvider instance = FinanceProvider._privateConstructor();

  // 3. Define a initializer function that will be called through the static singleton instance of this class
  Future<void> initialize() async {
    // Open DBs of present month
    await _openDBs();
    // Load existing Data from DB
    await _updateUserFromDB();
  }

  // // Private static variable to hold the singleton instance
  // static FinanceSummary? _instance;
  //
  // /// Factory constructor to return the singleton instance
  // factory FinanceSummary() {
  //   // If an instance is already created, return it; otherwise, create it
  //   _instance ??= FinanceSummary._privateConstructor();
  //   return _instance!;
  // }

  late final CurrentMonthDBs _dbs;
  final UserFinance user = UserFinance();

  Future _openDBs()async{
    final monthYearString = getMonthYearString();

    _dbs = CurrentMonthDBs(
        incomeBox: await openDB<Income>("income_$monthYearString"),
        expenseBox: await openDB("expense_$monthYearString"),
        investmentBox: await openDB("investment_$monthYearString"),
        liquidFundBox: await openDB("liquidFund_$monthYearString")
    );
    return;
  }

  /// Initial data update of user from the DB when the app loads...
  ///
  /// Should only run after db is opened
  Future _updateUserFromDB()async{

    var income = userBox.get("income");
    user.salary = (income is Income)? income : const Income();
    user.expenseBucket = ExpenseBucket(expenses: await _getExpenseFromDB());
    user.investmentBucket = InvestmentBucket(investments:  _dbs.investmentBox.values.toList());
    user.otherIncomesBucket = IncomeBucket(incomes:   _dbs.incomeBox.values.toList());
    user.liquidFundBucket = LiquidFundsBucket(funds: _dbs.liquidFundBox.values.toList());

    notifyListeners();
    return;
  }

  Future<List<Expense>> _getExpenseFromDB() async {

    // Step 1: Retrieve all JSON strings from the expenseBox
    final jsonExpenses = _dbs.expenseBox.values.toList();

    // Step 2: Convert each JSON map to an Expense object
    final expenses = jsonExpenses.map((expense) => Expense.fromJson(Map<String, dynamic>.from(expense))).toList();

    return expenses;
  }


  Future updateSalary(Income income)async{
    // TODO: Update 1. DB 2. user

    // Update db...
    userBox.put('income', income);
    // Update user...
    user.salary = income;
    notifyListeners();
  }

  Future updateExpense(Expense expense,{bool deleteExpense = false})async{

    App.print("#DEBUG | Inside updateExpense----");
  // TODO: Update 1. DB 2. user
    if(deleteExpense){
      // Add intoDB
      await _dbs.expenseBox.delete(expense.id);
      user.expenseBucket.removeExpense(expense);
    }else{

      // Add intoDB
      await _dbs.expenseBox.put(expense.id, expense.toJson());
      user.expenseBucket.addExpense(expense);
    }
    notifyListeners();
  }
}