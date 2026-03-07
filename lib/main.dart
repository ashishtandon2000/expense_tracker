import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/provider/provider.dart';
import 'feature/auth/data/repositories/firebase_auth_repository.dart';
import 'feature/auth/data/services/firebase_auth_service.dart';
import 'feature/auth/domain/repositories/auth_repository.dart';
import 'feature/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'util/util.dart';
import 'database/database.dart';
import 'widgets/widgets.dart';

Future appInIt() async {
  // Init & open global DB
  await DB.init();

  //Firebase Init
  await Firebase.initializeApp();

  // Update user data from DB
  await FinanceProvider.instance.initialize();

  return;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appInIt();

  return runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuthService()),
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
        ChangeNotifierProvider(
          create: (context) => FinanceProvider.instance,
        )
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: darkTheme,
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: const Expenses(),
      ),
    ),
  );
}
