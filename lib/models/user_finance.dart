part of 'models.dart';

class UserFinance {
  UserFinance(
      {required this.salary,
      this.otherIncomes = const IncomeBucket(incomes: []),
      this.expenses = const  ExpenseBucket(expenses: []),
      // this.subscriptions = const ExpenseBucket(expenses: [])
      this.liquidFunds = const LiquidFundsBucket(funds: []),
      this.investments = const InvestmentBucket(investments: [])});

  final Income salary;
  final IncomeBucket otherIncomes;
  final LiquidFundsBucket liquidFunds;
  final InvestmentBucket investments;
  final ExpenseBucket expenses;
  // final ExpenseBucket subscriptions;
}
