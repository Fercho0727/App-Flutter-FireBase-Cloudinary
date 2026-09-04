import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'providers/recetas_provider.dart';

//import 'screens/home/home_screen.dart';

import 'providers/auth_provider.dart';

import 'screens/auth/auth_wrapper.dart';

//import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RecetasProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tres Cocinando',
        theme: ThemeData(
          //textTheme: GoogleFonts.poppinsTextTheme(),
          primarySwatch: Colors.deepOrange,
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}