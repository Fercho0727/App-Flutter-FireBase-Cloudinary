import 'package:flutter/material.dart';

import '../../../../models/nueva_receta_data.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';

//Libreria Fuentes
import '../../../../core/app_style_text.dart';


class RecetaInfoStep extends StatefulWidget {
  final NuevaRecetaData recetaData;
  final VoidCallback onNext;
  

  const RecetaInfoStep({
    super.key,
    required this.recetaData,
    required this.onNext,
  });

  @override
  State<RecetaInfoStep> createState() =>
      _RecetaInfoStepState();
}

class _RecetaInfoStepState extends State<RecetaInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  late final TextEditingController nombreController;
  late final TextEditingController imagenController;
  late final TextEditingController categoriaController;
  late final TextEditingController precioController;
  late final TextEditingController tiempoController;
  late final TextEditingController porcionesController;

  @override
  void initState() {
  super.initState();

  nombreController = TextEditingController(
    text: widget.recetaData.nombre,
  );

  imagenController = TextEditingController(
    text: widget.recetaData.imagenPath,
  );

  categoriaController = TextEditingController(
    text: widget.recetaData.categoria,
  );

  precioController = TextEditingController(
    text: widget.recetaData.precio == 0
        ? ''
        : widget.recetaData.precio.toString(),
  );

  tiempoController = TextEditingController(
    text:
        widget.recetaData.tiempoPreparacion,
  );

  porcionesController =
      TextEditingController(
    text:
        widget.recetaData.porcionesBase
            .toString(),
  );
}

Future<void> seleccionarImagen() async {
  final pickedFile =
      await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 70,
  );

  if (pickedFile != null) {
    setState(() {
      widget.recetaData.imagenPath =
          pickedFile.path;
    });
  }
}

  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nombreController,
              style: AppTextStyles.body,
              decoration: inputDecoration(
                'Nombre de la receta',
                Icons.restaurant_menu,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa el nombre';
                }

                return null;
              },
            ),
            
            const SizedBox(height: 20),

          /* TextFormField(
              controller: imagenController,
              decoration: inputDecoration(
                'URL de la imagen',
                Icons.image,
              ),
              onChanged: (value) {
                widget.recetaData.imagenPath = value;
              },
            ),*/

            //BOTON PARA SELECCIONAR IMAGENES
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepOrange,
                  foregroundColor:
                      Colors.white,
                  minimumSize:
                      const Size(
                    double.infinity,
                    55,
                  ),
                ),
                onPressed:
                    seleccionarImagen,
                icon: const Icon(
                  Icons.photo,
                ),
                label: Text(
                  'Seleccionar imagen',
                  style: AppTextStyles.button,
                ),
              ),
            ),

            //VISUALIZAR IMAGEN

            const SizedBox(height: 20),

             if (widget.recetaData.imagenPath
                  .isNotEmpty)
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20),
                  child: widget.recetaData.imagenPath
                          .startsWith('http')
                      ? Image.network(
                          widget.recetaData
                              .imagenPath,
                          height: 220,
                          width:
                              double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return Container(
                              height: 220,
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(
                                  Icons
                                      .image_not_supported,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        )
                      : Image.file(
                          File(
                            widget.recetaData
                                .imagenPath,
                          ),
                          height: 220,
                          width:
                              double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),

            TextFormField(
              controller: categoriaController,
              style: AppTextStyles.body,
              decoration: inputDecoration(
                'Categoría',
                Icons.category,
              ),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: precioController,
              keyboardType: TextInputType.number,
              style: AppTextStyles.body,
              decoration: inputDecoration(
                'Precio',
                Icons.attach_money,
              ),
            ),
            const SizedBox(height: 20),

            TextFormField(
              controller: tiempoController,
              style: AppTextStyles.body,
              decoration: inputDecoration(
                'Tiempo preparación',
                Icons.timer,
              ),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: porcionesController,
              keyboardType: TextInputType.number,
              style: AppTextStyles.body,
              decoration: inputDecoration(
                'Porciones base',
                Icons.people,
              ),
            ),
            const SizedBox(height: 20),

            SwitchListTile(
              value: widget.recetaData.disponible,
              activeColor: Colors.deepOrange,
              title: Text('Disponible', 
              style: AppTextStyles.body
              ),
              onChanged: (value) {
                setState(() {
                  widget.recetaData.disponible = value;
                });
              },
            ),

            SwitchListTile(
              value: widget.recetaData.favorita,
              activeColor: Colors.deepOrange,
              title: Text('Favorita',
              style: AppTextStyles.body
              ),
              onChanged: (value) {
                setState(() {
                  widget.recetaData.favorita = value;
                });
              },
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  widget.recetaData.nombre =
                      nombreController.text;

                  /*widget.recetaData.imagenPath =
                      imagenController.text;*/

                  widget.recetaData.categoria =
                      categoriaController.text;

                  widget.recetaData.precio =
                      double.tryParse(precioController.text) ?? 0;

                  widget.recetaData.tiempoPreparacion =
                      tiempoController.text;

                  widget.recetaData.porcionesBase =
                      int.tryParse(porcionesController.text) ?? 1;

                  widget.onNext();
                },
                child: Text(
                  'Siguiente',
                  style: AppTextStyles.buttonHome,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(
  String label,
  IconData icon,
) {
  return InputDecoration(
    labelText: label,
    labelStyle: AppTextStyles.body,
    prefixIcon: Icon(icon),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
  }
}