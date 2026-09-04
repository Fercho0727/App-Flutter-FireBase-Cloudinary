import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/receta.dart';

class RecetasService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final String collection = 'recetas';

  Future<void> agregarReceta(
    Receta receta,
  ) async {
    await _firestore
        .collection(collection)
        .add(
          receta.toMap(),
        );
  }
Stream<List<Receta>> obtenerRecetas() {
    return _firestore
        .collection(collection)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Receta.fromMap(
            doc.data(),
            doc.id,
          );
        }).toList();
      },
    );
  }

  Future<void> eliminarReceta(
    String recetaId,
  ) async {
    await _firestore
        .collection(collection)
        .doc(recetaId)
        .delete();
  }
  Future<void> editarReceta(
    Receta receta,
  ) async {
    await _firestore
        .collection(collection)
        .doc(receta.id)
        .update(
          receta.toMap(),
        );
  }
}