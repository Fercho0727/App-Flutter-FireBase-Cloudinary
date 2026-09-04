import 'package:flutter/material.dart';

import '../models/receta.dart';

//Libreria Fuentes
import '../../core/app_style_text.dart';

class RecetaCard extends StatelessWidget {
  final Receta receta;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const RecetaCard({
    super.key,
    required this.receta,
    required this.onTap,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                receta.imagenPath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Nombre receta
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          receta.nombre,
                          style: AppTextStyles.recipeName,
                        ),
                      ),

                      if (receta.favorita)
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Categoría
                  Text(
                    'Categoría: ${receta.categoria}',
                    style: AppTextStyles.recipeInfo,
                  ),

                  const SizedBox(height: 6),

                  /// Precio
                  Text(
                    'Precio: Q${receta.precio.toStringAsFixed(0)}',
                    style: AppTextStyles.recipeInfo,
                  ),

                  const SizedBox(height: 6),

                  /// Tiempo
                  Text(
                    'Tiempo: ${receta.tiempoPreparacion}',
                    style: AppTextStyles.recipeInfo,
                  ),

                  const SizedBox(height: 12),

                  /// Disponible
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: receta.disponible
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      receta.disponible
                          ? 'Disponible'
                          : 'No disponible',
                      style: AppTextStyles.recipeInfo.copyWith(
                        color: receta.disponible
                            ? Colors.green.shade800
                            : Colors.red.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  if (onEdit != null || onDelete != null)
                    Row(
                      children: [
                        if (onEdit != null)
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(
                                  230,
                                  161,
                                  23,
                                  1,
                                ),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: onEdit,
                              icon: const Icon(Icons.edit),
                              label: Text(
                                'Editar',
                                style: AppTextStyles.button,
                              ),
                            ),
                          ),

                        if (onEdit != null &&
                            onDelete != null)
                          const SizedBox(width: 10),

                        if (onDelete != null)
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                          20,
                                        ),
                                      ),

                                      title: Text(
                                        '¿Eliminar receta?',
                                        style: AppTextStyles.subtitle,
                                      ),

                                      content: Text(
                                        'Esta acción no se puede deshacer.',
                                        style: AppTextStyles.body,
                                      ),

                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                              context,
                                            );
                                          },
                                          child: Text(
                                            'Cancelar',
                                            style: AppTextStyles.button,
                                          ),
                                        ),

                                        ElevatedButton(
                                          style:
                                              ElevatedButton
                                                  .styleFrom(
                                            backgroundColor:
                                                Colors.red,
                                            foregroundColor:
                                                Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(
                                              context,
                                            );
                                            onDelete!();
                                          },
                                          child: Text(
                                            'Aceptar',
                                            style:
                                                AppTextStyles
                                                    .button,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                              ),
                              label: Text(
                                'Eliminar',
                                style: AppTextStyles.button,
                              ),
                            ),
                          ),
                      ],
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