/*
🎯 Purpose
    Low-level wrapper around FirebaseAuth SDK.

📌 Responsibilities
    Talk directly to Firebase SDK
    Perform Google OAuth credential handling
    Call FirebaseAuth.instance
    Return Firebase User?
    Expose raw authStateChanges() stream

🚫 Must NOT
    Return AppUser
    Know about repository
    Know about ViewModel
    Contain business mapping logic

🧠 Why It Exists
    Separates raw SDK interaction from repository logic.
*/


import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService{
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  Future<void> initialize() async {
    await _googleSignIn.initialize();
  }

  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<UserCredential> signInWithGoogle() async {

    final account = await _googleSignIn.authenticate();

    final googleAuth = account.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.idToken,
      idToken: googleAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}