import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String nombre;
  final String email;
  final String rol;
  final bool activo;
  final DateTime fechaCreacion;

  const AppUser({
    required this.uid,
    required this.nombre,
    required this.email,
    required this.rol,
    required this.activo,
    required this.fechaCreacion,
  });

  bool get esAdmin => rol == 'admin';

  factory AppUser.fromMap(
    String uid,
    Map<String, dynamic> data,
  ) {
    return AppUser(
      uid: uid,
      nombre: data['nombre'] ?? '',
      email: data['email'] ?? '',
      rol: data['rol'] ?? 'empleado',
      activo: data['activo'] ?? true,
      fechaCreacion:
          (data['fechaCreacion'] as Timestamp?)
              ?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'email': email,
      'rol': rol,
      'activo': activo,
      'fechaCreacion': Timestamp.fromDate(
        fechaCreacion,
      ),
    };
  }
}