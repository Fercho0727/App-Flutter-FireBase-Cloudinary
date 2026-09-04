import 'package:flutter/material.dart';

//import '../data/recetas_data.dart';
import '../../widgets/receta_card.dart';
import 'agregar_receta/agregar_editar_receta_screen.dart';
import 'receta_detalle_screen.dart';

import 'package:provider/provider.dart';

import '../../providers/recetas_provider.dart';

import '../../providers/auth_provider.dart';

//Libreria Fuentes
import '../../core/app_style_text.dart';

class RecetasScreen extends StatefulWidget {
  const RecetasScreen({super.key});

  @override
  State<RecetasScreen> createState() => _RecetasScreenState();
}

class _RecetasScreenState extends State<RecetasScreen> {
  final TextEditingController _searchController =
      TextEditingController();
      String searchText = '';

  @override
  Widget build(BuildContext context) {
    final recetas =
    context.watch<RecetasProvider>().recetas;

    final appUser =
    context.watch<AuthProvider>().appUser;


    final filteredRecetas = recetas.where((receta) {
    final query = searchText.toLowerCase();

    return receta.nombre
            .toLowerCase()
            .contains(query) ||
        receta.categoria
            .toLowerCase()
            .contains(query);
    }).toList();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 247, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(229, 57, 53, 1),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 2,
        title: Text(
          'Recetas',
          style: AppTextStyles.title,
        ),
        centerTitle: true,
      ),
      floatingActionButton:
        appUser != null &&
                appUser.esAdmin
            ? FloatingActionButton.extended(
                backgroundColor:
                    const Color.fromRGBO(
                  229,
                  57,
                  53,
                  1,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const AgregarEditarRecetaScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                ),
                label: Text(
                  'Nueva receta',
                  style: AppTextStyles.button,
                ),
                foregroundColor:
                    const Color.fromARGB(
                  255,
                  255,
                  255,
                  255,
                ),
              )
            : null,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                 style: AppTextStyles.search,
                controller: _searchController,

                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },

                decoration: InputDecoration(
                  icon: const Icon(Icons.search),
                  hintText: 'Buscar receta...',
                  hintStyle: AppTextStyles.search,
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child:filteredRecetas.isEmpty
                ? Center(
                  child: Text(
                      'No se encontraron recetas',
                      style: AppTextStyles.subtitle,
                    ),
                  )
              : ListView.builder(
                itemCount: filteredRecetas.length,
                itemBuilder: (context, index) {
                  final receta = filteredRecetas[index];
                  
                  return RecetaCard(
                    receta: receta,

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RecetaDetalleScreen(
                            receta: receta,
                          ),
                        ),
                      );
                    },

                    onEdit: appUser != null &&
                            appUser.esAdmin
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AgregarEditarRecetaScreen(
                                  recetaExistente: receta,
                                ),
                              ),
                            );
                          }
                        : null,

                    onDelete: appUser != null &&
                            appUser.esAdmin
                        ? () {
                            context
                                .read<RecetasProvider>()
                                .eliminarReceta(
                                  receta,
                                );

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    Colors.red,
                                content: Text(
                                  '${receta.nombre} eliminada',
                                  style: AppTextStyles.body,
                                ),
                              ),
                            );
                          }
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}