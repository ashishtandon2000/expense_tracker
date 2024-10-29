part of 'models.dart';

//
class Income{
  const Income({
    required this.amount,
    required this.source,
    this.isFixed = true,
    this.isRecurring = true, // if the income is recurring then it should automatically be added to new months funds automatically
});

  final bool isFixed;
  final bool isRecurring;
  final String source;
  final double amount;
}

class IncomeBucket {
  const IncomeBucket({required this.incomes});

  final List<Income> incomes;

  double get total =>  incomes.fold(0, (sum, income)=> sum+income.amount);
}