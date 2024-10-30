part of 'provider.dart';

class CurrentMonthDBs {
  const CurrentMonthDBs({required this.incomeBox, required this.expenseBox, required this.investmentBox, required this.liquidFundBox});
  final Box<Income> incomeBox;
  final Box<Expense> expenseBox;
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

  bool dataLoaded = false;
  late final CurrentMonthDBs _dbs;
  final UserFinance user = UserFinance();

  Future _openDBs()async{
    final monthYearString = _getMonthYearString();

    _dbs = CurrentMonthDBs(
        incomeBox: await openDB<Income>("income_$monthYearString"),
        expenseBox: await openDB<Expense>("expense_$monthYearString"),
        investmentBox: await openDB("investment_$monthYearString"),
        liquidFundBox: await openDB("liquidFund_$monthYearString")
    );
    return;
  }

  String _getMonthYearString(){
    final current = DateTime.now();
    final month = DateFormat.MMMM().format(current);
    final year = DateFormat.y().format(current);

    return "$month\_$year";
  }

  /// Initial data update of user from the DB when the app loads...
  ///
  /// Should only run after db is opened
  Future _updateUserFromDB()async{

    var income = userBox.get("income");
    user.salary = (income is Income)? income : const Income();
    user.expenses = ExpenseBucket(expenses: await _updateExpenseFromDB());
    user.investments = InvestmentBucket(investments: await _updateInvestmentFromDB());
    user.otherIncomes = IncomeBucket(incomes: await _updateIncomeFromDB());
    user.liquidFunds = LiquidFundsBucket(funds: await _updateLiquidFundFromDB());

    return;
  }

  Future<List<Expense>> _updateExpenseFromDB() async{
    return _dbs.expenseBox.values.toList();
  }

  Future<List<Investment>> _updateInvestmentFromDB()async{
    return _dbs.investmentBox.values.toList();
  }

  Future<List<Income>> _updateIncomeFromDB()async{
    return _dbs.incomeBox.values.toList();
  }

  Future<List<LiquidFund>> _updateLiquidFundFromDB()async{
    return _dbs.liquidFundBox.values.toList();
  }

  Future updateSalary()async{}

  Future addExpense()async{}

}