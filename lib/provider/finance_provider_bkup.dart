// part of 'provider.dart';
//
//
// /// This provider serves as intermediate between DB, UI
// class FinanceProvider extends ChangeNotifier{
//
//   // 1. Create a private constructor...
//   FinanceProvider._privateConstructor();
//
//   // 2. Create Instance of class...
//   static final FinanceProvider instance = FinanceProvider._privateConstructor();
//
//   // 3. Define a initializer function that will be called through the static singleton instance of this class
//   Future<void> initialize() async {
//     // Load existing Data from DB
//     await _updateUserFromDB();
//   }
//
//   // // Private static variable to hold the singleton instance
//   // static FinanceSummary? _instance;
//   //
//   // /// Factory constructor to return the singleton instance
//   // factory FinanceSummary() {
//   //   // If an instance is already created, return it; otherwise, create it
//   //   _instance ??= FinanceSummary._privateConstructor();
//   //   return _instance!;
//   // }
//
//   late final CurrentMonthDBs _dbs;
//   final UserFinance user = UserFinance();
//
//
//   /// Initial data update of user from the DB when the app loads...
//   ///
//   /// Should only run after db is opened
//   Future _updateUserFromDB()async{
//     user.expenseBucket = ExpenseBucket(expenses:  _dbs.expenseBox.values.toList());
//
//     // var income = DB.userBox.get("income");
//     // user.salary = (income is Income)? income : const Income();
//
//     // user.investmentBucket = InvestmentBucket(investments:  _dbs.investmentBox.values.toList());
//     // user.otherIncomesBucket = IncomeBucket(incomes:   _dbs.incomeBox.values.toList());
//     // user.liquidFundBucket = LiquidFundsBucket(funds: _dbs.liquidFundBox.values.toList());
//
//     notifyListeners();
//     return;
//   }
//
//   Future updateSalary(Income income)async{
//     // TODO: Update 1. DB 2. user
//
//     // Update db...
//     userBox.put('income', income);
//     // Update user...
//     user.salary = income;
//     notifyListeners();
//   }
//
//   Future updateExpense(Expense expense,{bool deleteExpense = false})async{
//
//     App.print("#DEBUG | Inside updateExpense----");
//   // TODO: Update 1. DB 2. user
//     if(deleteExpense){
//       // Add intoDB
//       await _dbs.expenseBox.delete(expense.id);
//       user.expenseBucket.removeExpense(expense);
//     }else{
//
//       // Add intoDB
//       await _dbs.expenseBox.put(expense.id, expense);
//       user.expenseBucket.addExpense(expense);
//     }
//     notifyListeners();
//   }
// }