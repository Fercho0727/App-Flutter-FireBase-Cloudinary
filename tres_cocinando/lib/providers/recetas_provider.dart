import 'package:flutter/material.dart';

import '../models/receta.dart';

import '../services/recetas_service.dart';

class RecetasProvider extends ChangeNotifier {
  final RecetasService _service =
      RecetasService();

  List<Receta> _recetas = [];

  List<Receta> get recetas => _recetas;

  RecetasProvider() {
    escucharRecetas();
  }

  void escucharRecetas() {
    _service.obtenerRecetas().listen(
      (recetasFirestore) {
        _recetas = recetasFirestore;

        notifyListeners();
      },
    );
  }

  Future<void> agregarReceta(
    Receta receta,
  ) async {
    await _service.agregarReceta(
      receta,
    );
  }

  Future<void> eliminarReceta(
    Receta receta,
  ) async {
    await _service.eliminarReceta(
      receta.id,
    );
  }

  Future<void> editarReceta(
    Receta receta,
  ) async {
    await _service.editarReceta(
      receta,
    );
  }
}