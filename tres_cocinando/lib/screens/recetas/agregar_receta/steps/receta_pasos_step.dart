import 'package:flutter/material.dart';

//import '../../../data/recetas_data.dart';
import 'package:provider/provider.dart';
import '../../../../providers/recetas_provider.dart';
import '../../../../models/receta.dart';
import '../../../../models/nueva_receta_data.dart';

import '../../recetas_screen.dart';

import '/../../services/cloudinary_service.dart';

//Fuentes
import '../../../../core/app_style_text.dart';


class RecetaPasosStep extends StatefulWidget {
  final NuevaRecetaData recetaData;
  final VoidCallback onBack;
  final Receta? recetaOriginal;

  const RecetaPasosStep({
    super.key,
    required this.recetaData,
    required this.onBack,
    this.recetaOriginal,
  });

  @override
  State<RecetaPasosStep> createState() =>
      _RecetaPasosStepState();
}
class _RecetaPasosStepState
    extends State<RecetaPasosStep> {
  final pasoController = TextEditingController();

  bool _guardando = false;

  void agregarPaso() {
    if (pasoController.text.isEmpty) {
      return;
    }

    widget.recetaData.pasos.add(
      pasoController.text,
    );

    setState(() {});

    pasoController.clear();
  }
  Future<void> guardarReceta() async {

     if (_guardando) return;

  setState(() {
    _guardando = true;
  });

  try {

    String imageUrl =
          widget.recetaData.imagenPath;

      if (widget.recetaData.imagenPath
              .isNotEmpty &&
          !widget.recetaData.imagenPath
              .startsWith('http')) {
        final uploadedUrl =
            await CloudinaryService
                .subirImagen(
          widget.recetaData.imagenPath,
        );

        if (uploadedUrl != null) {
          imageUrl = uploadedUrl;
        }
      }


    final recetaNueva = Receta(
      id: widget.recetaOriginal?.id ?? '',
      nombre: widget.recetaData.nombre,
      imagenPath: imageUrl,
      categoria: widget.recetaData.categoria,
      precio: widget.recetaData.precio,
      tiempoPreparacion:
          widget.recetaData.tiempoPreparacion,
      disponible: widget.recetaData.disponible,
      favorita: widget.recetaData.favorita,
      porcionesBase:
          widget.recetaData.porcionesBase,
      ingredientes:
          widget.recetaData.ingredientes,
      pasos: widget.recetaData.pasos,
    );

 final provider =
    context.read<RecetasProvider>();

if (widget.recetaOriginal == null) {
  provider.agregarReceta(
    recetaNueva,
  );
} else {
  provider.editarReceta(
    recetaNueva,
  );
}

 /* WidgetsBinding.instance
    .addPostFrameCallback((_) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) =>
          const RecetasScreen(),
    ),
    (route) => false,
  );
});*/

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        widget.recetaOriginal == null
            ? 'Receta creada'
            : 'Receta actualizada',
      ),
    ),
  );

  Navigator.pop(context);
} finally {
    if (mounted) {
      setState(() {
        _guardando = false;
      });
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: pasoController,
            maxLines: 3,
            style: AppTextStyles.body,
            decoration: InputDecoration(
              labelText: 'Escribe un paso',
              labelStyle: AppTextStyles.bodySmall,
              prefixIcon: const Icon(Icons.list),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
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
              onPressed: agregarPaso,
              icon: const Icon(Icons.add),
              label: Text(
                'Agregar paso',
                style: AppTextStyles.button
              ),
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount:
                  widget.recetaData.pasos.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Colors.deepOrange,
                      foregroundColor:
                          Colors.white,
                      child: Text(
                        '${index + 1}',
                        style: AppTextStyles.button
                      ),
                    ),
                    title: Text(
                      widget.recetaData
                          .pasos[index],
                      style: AppTextStyles.procedure,
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.recetaData.pasos
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
                    foregroundColor:
                        Colors.white,
                  ),
                  onPressed: widget.onBack,
                  child: Text('Atrás', style: AppTextStyles.button),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed:
                      _guardando ? null : guardarReceta,
                  child: _guardando
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Guardar receta',
                          style:
                              AppTextStyles.button,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}