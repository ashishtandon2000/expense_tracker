 /*
🎯 Purpose
    Concrete implementation of AuthRepository. 🔄 Mapping Happens Here

📌 Responsibilities
    Implements AuthRepository
    Uses FirebaseAuthService
    Maps Firebase User → AppUser
    Converts SDK models into domain entity
    Handles transformation logic

This is where:
    Firebase User → AppUser
    conversion must happen.

🚫 Must NOT
    Be used directly by UI
    Expose Firebase types
    Contain UI logic

🧠 Why It Exists
    This is the bridge between:
    Data layer
    Domain layer
    It ensures clean separation and testability.
*/


 import 'package:firebase_auth/firebase_auth.dart';

 import '../../domain/entities/app_user.dart';
 import '../../domain/repositories/auth_repository.dart';
 import '../services/firebase_auth_service.dart';

 class FirebaseAuthRepository implements AuthRepository {
   final FirebaseAuthService _authService;

   FirebaseAuthRepository(this._authService);

   AppUser? _currentUser;

   @override
   Stream<AppUser?> authStateChanges() {
     return _authService.authStateChanges().map((user){
       _currentUser = _mapUser(user);
       return _currentUser;
     });
   }

   @override
  AppUser? get currentUser => _currentUser;

   @override
   Future<void> signInWithGoogle() async {
     await _authService.signInWithGoogle();
   }

   @override
   Future<void> signOut() async {
     await _authService.signOut();
   }

   AppUser? _mapUser(User? firebaseUser) {
     if (firebaseUser == null) return null;

     return AppUser(
       id: firebaseUser.uid,
       email: firebaseUser.email,
       displayName: firebaseUser.displayName,
       photoUrl: firebaseUser.photoURL,
     );
   }
 }