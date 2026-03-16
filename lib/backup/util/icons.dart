part of 'util.dart';

/// Category Icons
const Map<ExpenseCategory, IconData> categoryIcon = {
  ExpenseCategory.essential: Icons.shopping_cart,          // Essentials, often associated with shopping
  ExpenseCategory.nonEssential: Icons.local_activity,      // Non-essentials, like entertainment or outings
  ExpenseCategory.miscellaneous: Icons.miscellaneous_services // Miscellaneous items
};

/// Subcategory Icons
const Map<ExpenseSubCategory, IconData> subCategoryIcon = {
  ExpenseSubCategory.food: Icons.fastfood,                // Food items
  ExpenseSubCategory.living: Icons.home,                  // Living expenses, like rent or utilities
  ExpenseSubCategory.travel: Icons.directions_car,        // Travel-related expenses, such as transportation
  ExpenseSubCategory.shopping: Icons.shopping_bag,        // Shopping for non-essentials
  ExpenseSubCategory.other: Icons.more_horiz              // Any other miscellaneous category
};