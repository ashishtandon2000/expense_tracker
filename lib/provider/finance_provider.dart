part of 'provider.dart';


/// This provider serves as intermediate between DB, UI
class FinanceProvider extends ChangeNotifier{

  /// Process to form singleton class....
  // 1. Create a private constructor...
  FinanceProvider._privateConstructor();
  // 2. Create Instance of class...
  static final FinanceProvider instance = FinanceProvider._privateConstructor();
  // 3. Define a initializer function that will be called through the static singleton instance of this class
  Future<void> initialize() async {
    // Load existing Data from DB
    await _updateUserFromDB();
  }

  final UserFinance user = UserFinance();

  /// Initial data update of user from the DB when the app loads... Should only run after db is opened
  Future _updateUserFromDB()async{
    user.expenseBucket = ExpenseBucket(expenses:  DB.present.expenseBox.box.values.toList());

    // var income = DB.userBox.get("income");
    // user.salary = (income is Income)? income : const Income();

    // user.investmentBucket = InvestmentBucket(investments:  _dbs.investmentBox.values.toList());
    // user.otherIncomesBucket = IncomeBucket(incomes:   _dbs.incomeBox.values.toList());
    // user.liquidFundBucket = LiquidFundsBucket(funds: _dbs.liquidFundBox.values.toList());

    notifyListeners();
    return;
  }

  Future updateSalary(Income income)async{
    // TODO: Update 1. DB 2. user

    // Update db...
    DB.userBox.box.put('income', income);
    // Update user...
    user.salary = income;
    notifyListeners();
  }

  Future updateExpense(Expense expense,{bool deleteExpense = false})async{

    App.print("#DEBUG | Inside updateExpense----");
    // TODO: Update 1. DB 2. user
    if(deleteExpense){
      // Add intoDB
      await DB.present.expenseBox.delete(expense.id);
      user.expenseBucket.removeExpense(expense);
    }else{

      // Add intoDB
      await DB.present.expenseBox.put(expense.id, expense);
      user.expenseBucket.addExpense(expense);
    }
    notifyListeners();
  }
}