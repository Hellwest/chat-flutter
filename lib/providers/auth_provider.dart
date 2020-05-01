import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier {
  FirebaseUser user;
  AuthStatus status;
  
  FirebaseAuth _auth;

  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
  }

  void loginUserWithEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;

    notifyListeners();
    
    try {
      AuthResult _result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);

      user = _result.user;
      status = AuthStatus.Authenticated;

      // Navigate to HomePage
      print('Logged in successfully');
    } catch (e) {
      status = AuthStatus.Error;
      print('Login error');
      // Display error
    }

    notifyListeners();
  }
}
