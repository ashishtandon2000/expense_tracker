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

  late List<Expense> calculatedExpenses;

  /// _user will be the inital data that will be used by only the Finance Provider.
  ///
  /// Calculated data from this user will be provided through variables like: calculatedExpenses
  final UserFinance _user = UserFinance();
  
  String _currentSort = FilterValues.timeLatestFirst;

  void sortExpenses(String selection,{List<Expense>? filteredList}){

    _currentSort = selection;
    var bucket = _user.expenseBucket;
    if(filteredList != null && filteredList.isNotEmpty){
       bucket = ExpenseBucket(expenses: filteredList);
    }
    switch (selection){
      case FilterValues.amountHighToLow:
        calculatedExpenses = bucket.amountLowToHigh;
        break;
      case FilterValues.amountLowToHigh:
        calculatedExpenses = bucket.amountHighToLow;
        break;
      case FilterValues.timeLatestFirst:
        calculatedExpenses = bucket.timeLatestFirst;
        break;
      case FilterValues.timeOldestFirst:
        calculatedExpenses = bucket.timeOldestFirst;
        break;
    }

    notifyListeners();
  }

  /// Returns true if filtered list is not empty, otherwise false (false can be used as flag to show popup dialog for message)
  bool searchExpenses(String input){
    if(input == ""){
      sortExpenses(_currentSort);
      return true;
    }
    input = input.toLowerCase();
    final expenseBucket = _user.expenseBucket;
    /// 1. Convert input to lowercase
    /// 2. Filter by input - check if expense field contain search fields
    /// 3. Sort Filtered data


    print("#DEBUG input is -$input");

    final filtered = expenseBucket.expenses.where((expense){
      if(expense.title.toLowerCase().contains(input)){
        return true;
      }
      return false;
    }).toList();

    if(filtered.isEmpty){
      return false;
    }

    sortExpenses(_currentSort,filteredList: filtered);
    // notifyListeners(); // we are sorting at the end which calls changeNotifier, that is why we do not seperately need to call it.
    return true;
  }



  /// Initial data update of _user from the DB when the app loads... Should only run after db is opened
  Future _updateUserFromDB()async{
    _user.expenseBucket = ExpenseBucket(expenses:  DB.present.expenseBox.box.values.toList());

    // var income = DB._userBox.get("income");
    // _user.salary = (income is Income)? income : const Income();

    // _user.investmentBucket = InvestmentBucket(investments:  _dbs.investmentBox.values.toList());
    // _user.otherIncomesBucket = IncomeBucket(incomes:   _dbs.incomeBox.values.toList());
    // _user.liquidFundBucket = LiquidFundsBucket(funds: _dbs.liquidFundBox.values.toList());
    calculatedExpenses = _user.expenseBucket.expenses;
    notifyListeners();
    return;
  }

  Future updateSalary(Income income)async{
    // TODO: Update 1. DB 2. _user

    // Update db...
    DB.userBox.box.put('income', income);
    // Update _user...
    _user.salary = income;
    notifyListeners();
  }

  Future updateExpense(Expense expense,{bool deleteExpense = false})async{

    App.print("#DEBUG | Inside updateExpense----");
    // TODO: Update 1. DB 2. _user
    if(deleteExpense){
      // Add intoDB
      await DB.present.expenseBox.delete(expense.id);
      _user.expenseBucket.removeExpense(expense);
    }else{

      // Add intoDB
      await DB.present.expenseBox.put(expense.id, expense);
      _user.expenseBucket.addExpense(expense);
    }

    calculatedExpenses = _user.expenseBucket.expenses;
    notifyListeners();
  }
}