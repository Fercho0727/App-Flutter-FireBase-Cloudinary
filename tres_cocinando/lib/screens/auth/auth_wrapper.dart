import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../../screens/home/home_screen.dart';

import '../../screens/auth/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider =
        context.watch<AuthProvider>();

    if (authProvider.isLoggedIn) {
      return const HomeScreen();
    }

    return const LoginScreen();
  }
}