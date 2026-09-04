import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class UserService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Stream<List<AppUser>> obtenerUsuarios() {
    return _firestore
        .collection('users')
        .orderBy('nombre')
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return AppUser.fromMap(
            doc.id,
            doc.data(),
          );
        }).toList();
      },
    );
  }

  Future<void> cambiarEstadoUsuario({
    required String uid,
    required bool activo,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
      'activo': activo,
    });
  }

  Future<void> cambiarRolUsuario({
    required String uid,
    required String nuevoRol,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
      'rol': nuevoRol,
    });
  }
}