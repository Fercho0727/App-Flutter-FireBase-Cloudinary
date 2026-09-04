import 'ingrediente.dart';

class Receta {
  final String id;
  final String nombre;
  final String imagenPath;
  final String categoria;
  final double precio;
  final String tiempoPreparacion;
  final bool disponible;
  final bool favorita;

  final int porcionesBase;

  final List<Ingrediente> ingredientes;

  final List<String> pasos;

  Receta({
    required this.id,
    required this.nombre,
    required this.imagenPath,
    required this.categoria,
    required this.precio,
    required this.tiempoPreparacion,
    required this.disponible,
    required this.favorita,
    required this.porcionesBase,
    required this.ingredientes,
    required this.pasos,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'imagenPath': imagenPath,
      'categoria': categoria,
      'precio': precio,
      'tiempoPreparacion':
          tiempoPreparacion,
      'disponible': disponible,
      'favorita': favorita,
      'porcionesBase': porcionesBase,
      'ingredientes': ingredientes
          .map((ingrediente) {
        return ingrediente.toMap();
      }).toList(),
      'pasos': pasos,
    };
  }

  factory Receta.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return Receta(
      id: documentId,
      nombre: map['nombre'] ?? '',
      imagenPath:
          map['imagenPath'] ?? '',
      categoria:
          map['categoria'] ?? '',
      precio:
          (map['precio'] ?? 0)
              .toDouble(),
      tiempoPreparacion:
          map['tiempoPreparacion'] ??
              '',
      disponible:
          map['disponible'] ?? true,
      favorita:
          map['favorita'] ?? false,
      porcionesBase:
          map['porcionesBase'] ?? 1,
      ingredientes:
          (map['ingredientes']
                  as List<dynamic>)
              .map(
        (ingredienteMap) {
          return Ingrediente.fromMap(
            ingredienteMap,
          );
        },
      ).toList(),
      pasos: List<String>.from(
        map['pasos'] ?? [],
      ),
    );
  }
}