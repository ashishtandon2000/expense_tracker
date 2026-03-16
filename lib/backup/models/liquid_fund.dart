part of 'models.dart';

/// LiquidFunds provides model for fund that is directly accessible like bank account or wallet
class LiquidFund{
  LiquidFund({required this.amount,required this.description}) : id = idGenerator.v4();

  final String id;
  final double amount;
  final String description;
}

/// This bucket is used for collection of funds.
class LiquidFundsBucket{
  const LiquidFundsBucket({required this.funds});

  final List<LiquidFund> funds;

  double get total => funds.fold(0, (sum, fund)=>sum+fund.amount);
}