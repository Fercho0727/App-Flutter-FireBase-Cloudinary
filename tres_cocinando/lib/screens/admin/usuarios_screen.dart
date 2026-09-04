import 'package:flutter/material.dart';

import '../../services/user_service.dart';
import '../../models/app_user.dart';

import 'crear_usuario_screen.dart';

import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

//Fuentes
import '../../core/app_style_text.dart';

class UsuariosScreen extends StatelessWidget {
  UsuariosScreen({super.key});

  final UserService _userService =
      UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor:
            const Color.fromRGBO(229, 57, 53, 1,),
        foregroundColor:
            Colors.white,

        title: Text(
          'Administración de usuarios',
          style: AppTextStyles.title
        ),
        centerTitle: true,

      ),

        floatingActionButton:
            FloatingActionButton(
          backgroundColor:
              Colors.deepOrange,
          foregroundColor:
              Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const CrearUsuarioScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.person_add,
          ),
        ),


      body: StreamBuilder<List<AppUser>>(
        stream:
            _userService.obtenerUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final usuarios =
              snapshot.data ?? [];

          if (usuarios.isEmpty) {
            return const Center(
              child: Text(
                'No hay usuarios registrados.',
              ),
            );
          }

          return ListView.builder(
            padding:
                const EdgeInsets.all(12),
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final usuario =
                  usuarios[index];

              return Card(
                margin:
                    const EdgeInsets.only(
                  bottom: 12,
                ),
                child: ListTile(

                  onTap: () {
                    _mostrarDialogoUsuario(
                      context,
                      usuario,
                    );
                  },

                  leading: CircleAvatar(
                    child: Text(
                      usuario.nombre
                              .isNotEmpty
                          ? usuario.nombre[0]
                              .toUpperCase()
                          : '?',
                    ),
                  ),
                   title: Text(
                    usuario.nombre,
                    style: AppTextStyles.nameUser
                  ),
                  subtitle: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        usuario.email,
                        style: AppTextStyles.bodySmall
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Rol: ${usuario.rol}',
                        style: AppTextStyles.body
                      ),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(
                      usuario.activo
                          ? 'Activo'
                          : 'Inactivo',
                        style: AppTextStyles.bodySmall
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _mostrarDialogoUsuario(
    BuildContext context,
    AppUser usuario,
  ) {

    final authProvider =
    context.read<AuthProvider>();

    final usuarioActual =
        authProvider.user;


    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            usuario.nombre,
            style: AppTextStyles.nameUser
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                usuario.email,
                style: AppTextStyles.body
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Rol: ${usuario.rol}',
                style: AppTextStyles.body
              ),
              Text(
                usuario.activo
                    ? 'Estado: Activo'
                    : 'Estado: Inactivo',
                  style: AppTextStyles.body
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: Text(
                'Cancelar',
                style: AppTextStyles.buttonUser
              ),
            ),

           if (usuario.uid !=
                usuarioActual?.uid)
              ElevatedButton(
                onPressed: () async {
                  await _userService
                      .cambiarRolUsuario(
                    uid: usuario.uid,
                    nuevoRol:
                        usuario.rol ==
                                'admin'
                            ? 'empleado'
                            : 'admin',
                  );

                  if (context.mounted) {
                    Navigator.pop(
                      dialogContext,
                    );
                  }
                },
                child: Text(
                  usuario.rol == 'admin'
                      ? 'Hacer empleado'
                      : 'Hacer admin',
                      style: AppTextStyles.buttonUser
                ),
              ),

            if (usuario.uid !=
              usuarioActual?.uid)
            ElevatedButton(
              onPressed: () async {
                await _userService
                    .cambiarEstadoUsuario(
                  uid: usuario.uid,
                  activo:
                      !usuario.activo,
                );

                if (context.mounted) {
                  Navigator.pop(
                    dialogContext,
                  );
                }
              },
              child: Text(
                usuario.activo
                    ? 'Desactivar'
                    : 'Activar',
                    style: AppTextStyles.buttonUser
              ),
            ),
          ],
        );
      },
    );
  }
}