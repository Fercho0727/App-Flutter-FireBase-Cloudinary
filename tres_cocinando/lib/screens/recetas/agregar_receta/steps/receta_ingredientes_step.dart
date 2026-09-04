import 'package:flutter/material.dart';

import '../../../../models/ingrediente.dart';
import '../../../../models/nueva_receta_data.dart';

//Libreria Fuentes
import '../../../../core/app_style_text.dart';

class RecetaIngredientesStep extends StatefulWidget {
  final NuevaRecetaData recetaData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const RecetaIngredientesStep({
    super.key,
    required this.recetaData,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<RecetaIngredientesStep> createState() =>
      _RecetaIngredientesStepState();
}
class _RecetaIngredientesStepState
    extends State<RecetaIngredientesStep> {
  final nombreController = TextEditingController();
  final cantidadController = TextEditingController();
  final unidadController = TextEditingController();

  void agregarIngrediente() {
    if (nombreController.text.isEmpty ||
        cantidadController.text.isEmpty ||
        unidadController.text.isEmpty) {
      return;
    }

    widget.recetaData.ingredientes.add(
      Ingrediente(
        nombre: nombreController.text,
        cantidad:
            double.tryParse(cantidadController.text) ?? 0,
        unidad: unidadController.text,
      ),
    );

    setState(() {});

    nombreController.clear();
    cantidadController.clear();
    unidadController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: nombreController,
             style: AppTextStyles.body,
            decoration: decoration(
              'Ingrediente',
              Icons.restaurant,
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: cantidadController,
            keyboardType: TextInputType.number,
            style: AppTextStyles.body,
            decoration: decoration(
              'Cantidad',
              Icons.scale,
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: unidadController,
            style: AppTextStyles.body,
            decoration: decoration(
              'Unidad',
              Icons.straighten,
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
              onPressed: agregarIngrediente,
              icon: const Icon(Icons.add),
              label: Text(
                'Agregar ingrediente',
                 style: AppTextStyles.button
              ),
            ),
          ),
const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount:
                  widget.recetaData.ingredientes.length,
              itemBuilder: (context, index) {
                final ingrediente =
                    widget.recetaData.ingredientes[index];

                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.restaurant,
                    ),
                    title: Text(
                      ingrediente.nombre,
                    ),
                    subtitle: Text(
                      '${ingrediente.cantidad} ${ingrediente.unidad}',
                      style: AppTextStyles.bodySmall,
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.recetaData.ingredientes
                              .removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: widget.onBack,
                  child: Text('Atrás',  style: AppTextStyles.button),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: widget.onNext,
                  child: Text('Siguiente',  style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
   InputDecoration decoration(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyles.bodySmall,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}