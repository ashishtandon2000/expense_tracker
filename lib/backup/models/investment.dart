part of 'models.dart';

enum InvestmentCategory {
  rd,
  fd,
  sip,
  pf
}

/// Investment provides model/structure for single investment
class Investment{
  Investment({required this.amount, required this.category, required this.description}): id = idGenerator.v4();

  final String id;
  final double amount;
  final InvestmentCategory category;
  final String description;

  // TODO: Add these information in future: 1. Rate 2. Duration
}

/// Structure for collection of investments
class InvestmentBucket{
  const InvestmentBucket({required this.investments});

  final List<Investment> investments;

  double get total => investments.fold(0, (sum, investment)=>sum + investment.amount);
}