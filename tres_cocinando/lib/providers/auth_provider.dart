import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

import '../models/app_user.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService =
      AuthService();

  User? _user;

  User? get user => _user;

  AppUser? _appUser;

  AppUser? get appUser => _appUser;

  bool get esAdmin =>
    _appUser?.esAdmin ?? false;

  bool get isLoggedIn => _user != null;

  AuthProvider() {
    _authService.authStateChanges.listen(
      (User? user) async {
        _user = user;

        if (user != null) {
          _appUser = await _authService
              .obtenerAppUserActual();

          if (_appUser != null &&
              !_appUser!.activo) {
            await _authService.logout();
            _user = null;
            _appUser = null;
          }
        } else {
          _appUser = null;
        }

        notifyListeners();
      },
    );
  }
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.login(
        email: email,
        password: password,
      );

      _appUser = await _authService
        .obtenerAppUserActual();

      if (_appUser == null) {
        return 'No se pudo cargar el usuario.';
      }

      if (!_appUser!.activo) {
        await _authService.logout();
        _appUser = null;

        return 'Esta cuenta ha sido desactivada. Contacta al administrador.';
      }

      notifyListeners();

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      await _authService.register(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> crearUsuarioDesdeAdmin({
    required String nombre,
    required String email,
    required String password,
  }) async {
    return await _authService
        .crearUsuarioDesdeAdmin(
      nombre: nombre,
      email: email,
      password: password,
    );
  }


  Future<void> logout() async {
    _appUser = null;

    await _authService.logout();

    notifyListeners();
  }
}