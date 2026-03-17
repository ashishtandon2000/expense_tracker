import 'package:flutter/material.dart';

import 'expense_category.dart';

/// Category Icons
const Map<ExpenseCategory, IconData> categoryIcon = {
  ExpenseCategory.essential: Icons.fastfood,          // Essentials, often associated with shopping
  ExpenseCategory.nonEssential: Icons.shopping_cart,      // Non-essentials, like entertainment or outings
  ExpenseCategory.miscellaneous: Icons.miscellaneous_services // Miscellaneous items
};

