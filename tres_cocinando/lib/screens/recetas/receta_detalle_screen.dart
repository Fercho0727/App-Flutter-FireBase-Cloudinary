import 'package:flutter/material.dart';

import '../../models/ingrediente.dart';
import '../../models/receta.dart';

//Libreria Fuentes
import '../../core/app_style_text.dart';

class RecetaDetalleScreen extends StatefulWidget {
  final Receta receta;

  const RecetaDetalleScreen({
    super.key,
    required this.receta,
  });

  @override
  State<RecetaDetalleScreen> createState() =>
      _RecetaDetalleScreenState();
}

class _RecetaDetalleScreenState
    extends State<RecetaDetalleScreen> {
  int cantidadPersonas = 10;

  double calcularCantidad(double cantidadBase) {
    return (cantidadBase / widget.receta.porcionesBase) *
        cantidadPersonas;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 247, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(229, 57, 53, 1),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(widget.receta.nombre,
        style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.receta.imagenPath,
              width: double.infinity,
              height: 260,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  height: 260,
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.receta.nombre,
                    style: AppTextStyles.recipeName.copyWith(
                    fontSize: 40,
                    color: Colors.green.shade800
                    ),
                  ),
                   const SizedBox(height: 10),

                  Text(
                    'Receta base para ${widget.receta.porcionesBase} personas',
                    style: AppTextStyles.body,
                  ),

                  const SizedBox(height: 25),

                  Text(
                    'Cantidad de personas',
                    style: AppTextStyles.subtitle,
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: cantidadPersonas.toDouble(),
                          min: 1,
                          max: 200,
                          divisions: 199,
                          label: cantidadPersonas.toString(),
                          onChanged: (value) {
                            setState(() {
                              cantidadPersonas = value.toInt();
                            });
                          },
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(230, 161, 23, 1),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$cantidadPersonas',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Text(
                    'Ingredientes necesarios',
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 15),

                  ...widget.receta.ingredientes.map(
                    (Ingrediente ingrediente) {
                      final cantidadCalculada =
                          calcularCantidad(
                        ingrediente.cantidad,
                      );

                      return Card(
                        margin:
                            const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.restaurant,
                            color: Color.fromRGBO(230, 161, 23, 1),
                          ),
                          title: Text(
                            ingrediente.nombre,
                            style: AppTextStyles.body,
                          ),
                          subtitle: Text(
                            '${cantidadCalculada.toStringAsFixed(2)} ${ingrediente.unidad}',
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  Text(
                    'Paso a paso',
                    style: AppTextStyles.subtitle,
                  ),

                  const SizedBox(height: 15),

                  ...List.generate(
                    widget.receta.pasos.length,
                    (index) {
                      return Container(
                        margin:
                            const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Color.fromRGBO(230, 161, 23, 1),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Text(
                                widget.receta.pasos[index],
                                style: AppTextStyles.body,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}