import 'package:flutter/material.dart';

import '../recetas/recetas_screen.dart';

import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../admin/usuarios_screen.dart';

//Libreria Fuentes
import '../../core/app_style_text.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final authProvider =
    context.watch<AuthProvider>();

    final appUser =
    authProvider.appUser;


    return Scaffold(
      backgroundColor:
          const Color.fromRGBO(250, 248, 245, 1),

      /*appBar: AppBar(
        backgroundColor:
            const Color.fromRGBO(229, 57, 53, 1),

        foregroundColor: Colors.white,

        centerTitle: true,

        title: const Text(
          'Tres Cocinando',
        ),
      ),*/
      appBar: AppBar(
        backgroundColor:
            const Color.fromRGBO(229, 57, 53, 1),

        foregroundColor: Colors.white,
        title: const Text(
          'Bienvenidos',
          style: AppTextStyles.logo,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final authProvider =
                  context.read<AuthProvider>();

              await authProvider.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(30),

                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/Logo_3cocinando.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),

            Text(
              '¿Qué deseas hacer hoy?',
              style: AppTextStyles.homeTitle,
            ),

            const SizedBox(height: 40),

            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton(
                    context,
                    title: 'Recetas',
                    icon: Icons.restaurant_menu,
                    screen: const RecetasScreen(),
                  ),

                  /*buildButton(
                    context,
                    title: 'Pedidos',
                    icon: Icons.receipt_long,
                    screen: const Placeholder(),
                  ),
                   buildButton(
                    context,
                    title: 'Clientes',
                    icon: Icons.people,
                    screen: const Placeholder(),
                  ),

                  buildButton(
                    context,
                    title: 'Reportes',
                    icon: Icons.bar_chart,
                    screen: const Placeholder(),
                  ),*/

                  if (appUser != null &&
                    appUser.esAdmin)
                  IconButton(
                    icon: const Icon(
                      Icons.people,
                      size: 36,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              UsuariosScreen(),
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
  Widget buildButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget screen,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color.fromRGBO(230, 161, 23, 1),

          foregroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),
        ),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ),
          );
        },

        icon: Icon(
          icon,
          size: 28,
        ),

        label: Text(
          title,
          style: AppTextStyles.buttonHome,
        ),
      ),
    );
  }
}