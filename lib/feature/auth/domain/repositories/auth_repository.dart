import '../entities/app_user.dart';

/*
🎯 Purpose
    Defines the authentication contract for the app.

📌 Responsibilities
    Expose auth state as Stream<AppUser?>
    Define sign-in methods
    Define sign-out method
    Act as boundary between presentation and data

🚫 Must NOT
    Import Firebase
    Contain implementation
    Contain SDK logic

🧠 Why It Exists
    Enables testing (can mock this)
    Decouples ViewModel from Firebase
    Allows future provider addition (phone, email)
*/

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();

  AppUser? get currentUser;

  Future<void> signInWithGoogle();

  Future<void> signOut();
}