import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
    FirebaseFirestore.instance;

  User? get currentUser =>
      _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges =>
      _firebaseAuth.authStateChanges();

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<AppUser?> obtenerAppUserActual() async {
    final firebaseUser =
        _firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    final docRef = _firestore
        .collection('users')
        .doc(firebaseUser.uid);

    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      final nuevoUsuario = AppUser(
        uid: firebaseUser.uid,
        nombre: firebaseUser.email!
            .split('@')
            .first,
        email: firebaseUser.email!,
        rol: 'admin',
        activo: true,
        fechaCreacion: DateTime.now(),
      );

      await docRef.set(
        nuevoUsuario.toMap(),
      );

      return nuevoUsuario;
    }

    return AppUser.fromMap(
      snapshot.id,
      snapshot.data()!,
    );
  }
//////////////////////////////////////////////////////////////////////
  Future<String?> crearUsuarioDesdeAdmin({
    required String nombre,
    required String email,
    required String password,
  }) async {
    FirebaseApp? secondaryApp;

    try {
      secondaryApp =
          await Firebase.initializeApp(
        name:
            'secondary-${DateTime.now().millisecondsSinceEpoch}',
        options:
            DefaultFirebaseOptions
                .currentPlatform,
      );

      final secondaryAuth =
          FirebaseAuth.instanceFor(
        app: secondaryApp,
      );

      final credential =
          await secondaryAuth
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid =
          credential.user!.uid;

      final nuevoUsuario =
          AppUser(
        uid: uid,
        nombre: nombre,
        email: email,
        rol: 'empleado',
        activo: true,
        fechaCreacion:
            DateTime.now(),
      );

      await FirebaseFirestore
          .instance
          .collection('users')
          .doc(uid)
          .set(
            nuevoUsuario.toMap(),
          );

      await secondaryAuth.signOut();

      await secondaryApp.delete();

      return null;
    } catch (e) {
      if (secondaryApp != null) {
        await secondaryApp.delete();
      }

      return e.toString();
    }
  }


}