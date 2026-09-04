import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

//Fuentes
import '../../core/app_style_text.dart';

class CrearUsuarioScreen
    extends StatefulWidget {
  const CrearUsuarioScreen({
    super.key,
  });

  @override
  State<CrearUsuarioScreen>
      createState() =>
          _CrearUsuarioScreenState();
}

class _CrearUsuarioScreenState
    extends State<CrearUsuarioScreen> {
  final _formKey =
      GlobalKey<FormState>();

  final TextEditingController
      _nombreController =
      TextEditingController();

  final TextEditingController
      _emailController =
      TextEditingController();

  final TextEditingController
      _passwordController =
      TextEditingController();

  bool _isLoading = false;

  bool _obscurePassword = true;

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

      Future<void> _crearUsuario() async {
      if (_isLoading) return;

      if (!_formKey.currentState!
          .validate()) {
        return;
      }

      setState(() {
        _isLoading = true;
      });

    try {
  final authProvider =
      context.read<AuthProvider>();

  final error =
      await authProvider
          .crearUsuarioDesdeAdmin(
    nombre:
        _nombreController.text.trim(),
    email:
        _emailController.text.trim(),
    password:
        _passwordController.text,
  );

  if (!mounted) return;

  if (error != null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          error,
          style: AppTextStyles.body,
        ),
      ),
    );
    return;
  }

  ScaffoldMessenger.of(context)
      .showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        'Usuario creado correctamente.',
        style: AppTextStyles.body,
      ),
    ),
  );

    Navigator.pop(context);
} finally {
  if (mounted) {
    setState(() {
      _isLoading = false;
    });
  }
}
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          Colors.orange.shade50,

      appBar: AppBar(
        backgroundColor:
            const Color.fromRGBO(
          229,
          57,
          53,
          1,
        ),
        foregroundColor:
            Colors.white,
        centerTitle: true,
        title: Text(
          'Nuevo usuario',
           style: AppTextStyles.title
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              TextFormField(
                controller:
                    _nombreController,
                style: AppTextStyles.body,
                decoration:
                    _inputDecoration(
                  'Nombre completo',
                  Icons.person,
                ),
                validator: (
                  value,
                ) {
                  if (value == null ||
                      value
                          .trim()
                          .isEmpty) {
                    return 'Ingresa el nombre';
                  }

                  return null;
                },
              ),
            const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller:
                    _emailController,
                keyboardType:
                    TextInputType
                        .emailAddress,
                style: AppTextStyles.body,
                decoration:
                    _inputDecoration(
                  'Correo electrónico',
                  Icons.email,
                ),
                validator: (
                  value,
                ) {
                  if (value == null ||
                      value
                          .trim()
                          .isEmpty) {
                    return 'Ingresa el correo';
                  }

                  if (!value
                      .contains(
                    '@',
                  )) {
                    return 'Correo inválido';
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller:
                    _passwordController,
                obscureText:
                    _obscurePassword,

                style: AppTextStyles.body,
                decoration:
                    _inputDecoration(
                  'Contraseña inicial',
                  Icons.lock,
                ).copyWith(
                  suffixIcon:
                      IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                            !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons
                              .visibility_off
                          : Icons
                              .visibility,
                    ),
                  ),
                ),
                validator: (
                  value,
                ) {
                  if (value == null ||
                      value
                          .isEmpty) {
                    return 'Ingresa la contraseña';
                  }

                  if (value.length <
                      6) {
                    return 'Mínimo 6 caracteres';
                  }

                  return null;
                },
              ),
                          const SizedBox(
                height: 40,
              ),

              SizedBox(
                width:
                    double.infinity,
                height: 55,
                child:
                    ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors
                            .deepOrange,
                    foregroundColor:
                        Colors.white,
                  ),
                 onPressed:
                    _isLoading
                        ? null
                        : _crearUsuario,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Crear usuario',
                        style: AppTextStyles.button
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 InputDecoration _inputDecoration(
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
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color.fromRGBO(229, 57, 53, 1),
        width: 2,
      ),
    ),
  );
}
}