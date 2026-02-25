import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

/*
🎯 Role of AuthViewModel

It should:
    Subscribe to authStateChanges()
    Hold AppUser?
    Expose loading state
    Expose error state
    Call signInWithGoogle()
    Call signOut()
    Notify UI on changes

It should NOT:
    Import Firebase
    Know about GoogleSignIn SDK
    Do mapping
    Handle raw User
*/


class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) {
    _listenToAuthChanges();
  }

  AppUser? _user;
  bool _isLoading = false;
  String? _errorMessage;

  StreamSubscription<AppUser?>? _authSubscription;

  // ================================
  // Public Getters
  // ================================

  AppUser? get user => _user;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _user != null;

  // ================================
  // Private Methods
  // ================================

  void _listenToAuthChanges() {
    _authSubscription = _authRepository
        .authStateChanges()
        .listen((appUser) {
      _user = appUser;
      notifyListeners();
    }, onError: (error) {
      _errorMessage = error.toString();
      notifyListeners();
    });
  }

  // ================================
  // Public Actions
  // ================================

  Future<void> signInWithGoogle() async {
    try {
      _setLoading(true);
      _clearError();

      await _authRepository.signInWithGoogle();

      // Do NOT set _user manually.
      // Stream will emit updated user automatically.
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      _setLoading(true);
      await _authRepository.signOut();
      // Stream will emit null automatically.
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // ================================
  // Helpers
  // ================================

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}