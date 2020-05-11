import 'package:chatify/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../services/snackbar_service.dart';

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
      AuthResult _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);

      user = _result.user;
      status = AuthStatus.Authenticated;

      SnackBarService.instance.showSnackBarSuccess('Welcome, ${user.email}');
      // Update lastSeen time
      NavigationService.instance.navigateToReplacement("home");
    } catch (e) {
      status = AuthStatus.Error;
      user = null;

      SnackBarService.instance.showSnackBarError('Error authenticating');
    }

    notifyListeners();
  }

  void registerUserWithEmailAndPassword(String _email, String _password,
      Future<void> onSuccess(String _uid)) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      AuthResult _result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user;
      status = AuthStatus.Authenticated;
      await onSuccess(user.uid);
      SnackBarService.instance.showSnackBarSuccess("Welcome, ${user.email}");
      // Update lastSeen time
      NavigationService.instance.goBack();
      NavigationService.instance.navigateToReplacement("home");
    } catch (error) {
      status = AuthStatus.Error;
      user = null;
      SnackBarService.instance.showSnackBarError("Error registering user");
    }

    notifyListeners();
  }
}
