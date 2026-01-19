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

  /// _user will be the initial data that will be used by only the Finance Provider.
  ///
  /// Calculated data from this user will be provided through variables like: calculatedExpenses
  final UserFinance _user = UserFinance();
  late List<Expense> calculatedExpenses;

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



    final filtered = expenseBucket.expenses.where((expense){
      return (expense.title.toLowerCase().contains(input));
    }).toList();

    // TODO: Remove this later, to implement: when nothing matching found search should hide current list, with graph stats
    if(filtered.isEmpty){
      return false;
    }

    sortExpenses(_currentSort,filteredList: filtered);
    // notifyListeners(); // we are sorting at the end which calls changeNotifier, that is why we do not seperately need to call it.
    return filtered.isEmpty;
  }

  Future updateExpense(Expense expense,{bool deleteExpense = false})async{

    // TODO: Update 1. DB 2. _user
    if(deleteExpense){
      // Add intoDB
      final test =  DB.present.expenseBox.box.containsKey(expense.id);

      final some = await DB.present.expenseBox.delete(expense.id);
      App.print("Deleting - ${[some, test, expense.title, expense.id]}");
      _user.expenseBucket.removeExpense(expense);
    }else{

      // Add intoDB
      final some = await DB.present.expenseBox.put(expense.id, expense);
      final test =  DB.present.expenseBox.box.containsKey(expense.id);
      App.print("Adding - ${[some, test, expense.title, expense.id]}");
      _user.expenseBucket.addExpense(expense);
    }

    calculatedExpenses = _user.expenseBucket.expenses;
    notifyListeners();
  }

  /// Initial data update of _user from the DB when the app loads... Should only run after db is opened
  Future _updateUserFromDB()async{
     // await DB.present.expenseBox.box.clear();

    calculatedExpenses = DB.present.expenseBox.box.values.toList();
    _user.expenseBucket = ExpenseBucket(expenses: calculatedExpenses);

    // #TEMP -
    for(final expense in calculatedExpenses){
      App.print("Expense - ${[expense.title, expense.id]}");
    }

    notifyListeners();
    return;
  }
}


//
// Future updateSalary(Income income)async{
//   // TODO: Update 1. DB 2. _user
//
//   // Update db...
//   DB.userBox.box.put('income', income);
//   // Update _user...
//   _user.salary = income;
//   notifyListeners();
// }
