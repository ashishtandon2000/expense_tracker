import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/feature/expenses/data/repositories/firestore_expense_repository.dart';
import 'package:expense_tracker/feature/expenses/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/feature/expenses/presentation/viewmodels/expense_dashboard_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feature/auth/data/repositories/firebase_auth_repository.dart';
import 'feature/auth/data/services/firebase_auth_service.dart';
import 'feature/auth/domain/repositories/auth_repository.dart';
import 'feature/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'feature/auth/presentation/views/auth_gate.dart';
import 'feature/expenses/data/services/firestore_expense_service.dart';


Future appInIt() async {
  //Firebase Init
  await Firebase.initializeApp();

  return;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appInIt();

  return runApp(
    MultiProvider(
      providers: [
        // AUTH Provider....
        Provider<FirebaseAuthService>(create: (_) {
          final service = FirebaseAuthService();
          service.initialize();
          return service;
        }),
        Provider<AuthRepository>(
          create: (context) => FirebaseAuthRepository(
            context.read<FirebaseAuthService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            context.read<AuthRepository>(),
          ),
        ),

        // Expense Provider...
        Provider<FirestoreExpenseService>(create: (_)=> FirestoreExpenseService()),
        Provider<ExpenseRepository>(create: (context)=>FirestoreExpenseRepository(
          context.read<AuthRepository>(),
          context.read<FirestoreExpenseService>()
        ),
        ),
        ChangeNotifierProvider(
          create: (context) => ExpenseDashboardViewModel(
            context.read<ExpenseRepository>()
          ),
        )
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const AuthGate(),
      ),
    ),
  );
}
