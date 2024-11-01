part of 'models.dart';

class UserFinance {
  UserFinance(
      {this.salary = const Income(amount: 0, source: ""),
      this.otherIncomesBucket = const IncomeBucket(incomes: []),
      this.expenseBucket = const ExpenseBucket(expenses: []),
      // this.subscriptions = const ExpenseBucket(expenses: [])
      this.liquidFundBucket = const LiquidFundsBucket(funds: []),
      this.investmentBucket = const InvestmentBucket(investments: [])});

  Income salary;
  IncomeBucket otherIncomesBucket;
  LiquidFundsBucket liquidFundBucket;
  InvestmentBucket investmentBucket;
  ExpenseBucket expenseBucket;
  // final ExpenseBucket subscriptions;
}
