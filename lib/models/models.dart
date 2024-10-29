library models;

// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

part 'expense.dart';
part 'investment.dart';
part 'liquid_fund.dart';
part 'finance_summary.dart';
part 'user_finance.dart';
part 'income.dart';

const idGenerator = Uuid();
final formatter = DateFormat.yMd();