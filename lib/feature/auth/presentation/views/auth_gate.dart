import 'package:expense_tracker/feature/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:expense_tracker/feature/auth/presentation/views/auth_screen.dart';
import 'package:expense_tracker/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {

    final isAuthenticated = context.select<AuthViewModel, bool>((vm)=>vm.isAuthenticated);

    if(isAuthenticated)return const Expenses();

    return const AuthScreen();
  }
}
