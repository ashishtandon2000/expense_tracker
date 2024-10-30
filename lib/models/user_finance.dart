part of 'models.dart';

class UserFinance {
  UserFinance(
      {this.salary = const Income(amount: 0, source: ""),
      this.otherIncomes = const IncomeBucket(incomes: []),
      this.expenses = const ExpenseBucket(expenses: []),
      // this.subscriptions = const ExpenseBucket(expenses: [])
      this.liquidFunds = const LiquidFundsBucket(funds: []),
      this.investments = const InvestmentBucket(investments: [])});

  Income salary;
  IncomeBucket otherIncomes;
  LiquidFundsBucket liquidFunds;
  InvestmentBucket investments;
  ExpenseBucket expenses;
  // final ExpenseBucket subscriptions;
}
