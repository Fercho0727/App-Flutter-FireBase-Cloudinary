import 'package:flutter/material.dart';

import '../../../models/nueva_receta_data.dart';
import '../../../models/receta.dart';

import 'steps/receta_info_step.dart';
import 'steps/receta_ingredientes_step.dart';
import 'steps/receta_pasos_step.dart';

//Libreria Fuentes
import '../../../core/app_style_text.dart';

class AgregarEditarRecetaScreen
    extends StatefulWidget {
  final Receta? recetaExistente;

  const AgregarEditarRecetaScreen({
    super.key,
    this.recetaExistente,
  });
  @override
  State<AgregarEditarRecetaScreen> createState() =>
      _AgregarEditarRecetaScreenState();
}

class _AgregarEditarRecetaScreenState
    extends State<AgregarEditarRecetaScreen> {
  final PageController _pageController =
      PageController();

  late NuevaRecetaData recetaData;

  int currentStep = 0;

  bool get isEditing =>
      widget.recetaExistente != null;
       @override
  void initState() {
    super.initState();

    recetaData = NuevaRecetaData();

    if (isEditing) {
      final receta = widget.recetaExistente!;

      recetaData.nombre = receta.nombre;
      recetaData.imagenPath = receta.imagenPath;
      recetaData.categoria = receta.categoria;
      recetaData.precio = receta.precio;
      recetaData.tiempoPreparacion =
          receta.tiempoPreparacion;
      recetaData.disponible =
          receta.disponible;
      recetaData.favorita =
          receta.favorita;
      recetaData.porcionesBase =
          receta.porcionesBase;

      recetaData.ingredientes =
          List.from(receta.ingredientes);

      recetaData.pasos =
          List.from(receta.pasos);
    }
  }
  void nextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });

      _pageController.nextPage(
        duration:
            const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });

      _pageController.previousPage(
        duration:
            const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,

      appBar: AppBar(
        backgroundColor:
            const Color.fromRGBO(
          229,
          57,
          53,
          1,
        ),

        foregroundColor: Colors.white,

        title: Text(
          isEditing
              ? 'Editar receta'
              : 'Nueva receta',
            style: AppTextStyles.title,
        ),

        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          Text(
            'Paso ${currentStep + 1} de 3',
            style: AppTextStyles.subtitle.copyWith(
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 14),

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: LinearProgressIndicator(
              value: (currentStep + 1) / 3,
              minHeight: 10,
              borderRadius:
                  BorderRadius.circular(20),
              backgroundColor:
                  Colors.grey.shade300,
              color: Colors.deepOrange,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: PageView(
              controller: _pageController,

              physics:
                  const NeverScrollableScrollPhysics(),

              children: [
                RecetaInfoStep(
                  recetaData: recetaData,
                  onNext: nextStep,
                ),

                RecetaIngredientesStep(
                  recetaData: recetaData,
                  onNext: nextStep,
                  onBack: previousStep,
                ),

                RecetaPasosStep(
                  recetaData: recetaData,
                  recetaOriginal:
                      widget.recetaExistente,
                  onBack: previousStep,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}