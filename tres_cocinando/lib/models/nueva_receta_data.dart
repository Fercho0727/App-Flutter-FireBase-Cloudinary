import 'ingrediente.dart';

class NuevaRecetaData {
  String nombre = '';
  String imagenPath = '';
  String categoria = '';
  double precio = 0;
  String tiempoPreparacion = '';
  int porcionesBase = 1;
  bool disponible = true;
  bool favorita = false;

  List<Ingrediente> ingredientes = [];

  List<String> pasos = [];
}