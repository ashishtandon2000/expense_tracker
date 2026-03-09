
import 'package:expense_tracker/feature/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final auth = context.watch<AuthViewModel>();

    return  Scaffold(
      appBar: AppBar(
        title: const Text("Balancio"),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("${auth.user}"),
          Text("${auth.isAuthenticated}"),
          if(!auth.isAuthenticated)ElevatedButton(onPressed: (){
            auth.signInWithGoogle();
          }, child: Text("Signin")),
          if(auth.isAuthenticated)ElevatedButton(onPressed: auth.signOut, child: Text("SignOut"))
        ]
        ),
      ),
    );
  }
}
