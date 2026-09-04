class Ingrediente {
  final String nombre;
  final double cantidad;
  final String unidad;

  Ingrediente({
    required this.nombre,
    required this.cantidad,
    required this.unidad,
  });
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'cantidad': cantidad,
      'unidad': unidad,
    };
  }

  factory Ingrediente.fromMap(
    Map<String, dynamic> map,
  ) {
    return Ingrediente(
      nombre: map['nombre'] ?? '',
      cantidad:
          (map['cantidad'] ?? 0)
              .toDouble(),
      unidad: map['unidad'] ?? '',
    );
  }
}