# App-Flutter-FireBase-Cloudinary
3Cocinando — Gestión de Recetas

Aplicación móvil desarrollada para 3Cocinando, una empresa dedicada al servicio de catering. La aplicación funciona como un recetario digital interno que permite centralizar, consultar y administrar las recetas utilizadas por el equipo de trabajo.

El sistema cuenta con autenticación mediante Firebase Authentication y almacenamiento de información mediante Cloud Firestore, incorporando un sistema de roles para controlar las funcionalidades disponibles para cada tipo de usuario.


✨ Características principales

🔐 Autenticación y usuarios
Inicio de sesión mediante correo electrónico y contraseña.
Gestión de usuarios mediante Firebase Authentication.
Sistema de roles con usuarios Administrador y Empleado.
Los administradores pueden crear nuevos usuarios desde la aplicación.
Los nuevos usuarios creados por un administrador reciben automáticamente el rol de empleado.
Gestión del estado de los usuarios: habilitar y deshabilitar cuentas.
Modificación y eliminación de usuarios.
Control de acceso según el rol del usuario.

👨‍💼 Administradores

Los administradores cuentan con acceso completo a las funcionalidades de gestión:

Crear usuarios.
Modificar información de usuarios.
Cambiar roles.
Habilitar o deshabilitar usuarios.
Eliminar usuarios.
Crear y administrar recetas.
Editar recetas existentes.
Eliminar recetas.

👨‍🍳 Empleados

Los empleados cuentan con acceso a las funcionalidades necesarias para consultar el recetario:

Visualizar las recetas disponibles.
Consultar la información de las recetas.
Acceder únicamente a las secciones permitidas para su rol.

Las opciones administrativas no están disponibles para los usuarios con rol de empleado.

🗄️ Backend y almacenamiento

El proyecto utiliza servicios de Firebase para gestionar la información y autenticación:

Firebase Authentication: autenticación y gestión de cuentas.
Cloud Firestore: almacenamiento de usuarios, recetas y demás información de la aplicación.
Firebase Security Rules: control de acceso a los datos almacenados en Firestore.

🛠️ Tecnologías utilizadas
-Flutter
-Dart
-Firebase Authentication
-Cloud Firestore
-Cloudinary

🎯 Objetivo del proyecto

El objetivo de la aplicación es proporcionar a 3Cocinando una herramienta centralizada para la gestión y consulta de recetas, facilitando el acceso a la información culinaria del equipo y proporcionando diferentes niveles de acceso de acuerdo con las responsabilidades de cada usuario.

El proyecto fue desarrollado teniendo en cuenta la necesidad de contar con una aplicación sencilla de utilizar, con autenticación, gestión de usuarios y control de permisos.

🔒 Seguridad

La aplicación utiliza autenticación y reglas de seguridad de Firebase para proteger la información almacenada en la base de datos.

📱 Estado del proyecto

Proyecto desarrollado y utilizado como aplicación interna para la gestión de recetas de 3Cocinando.


Portfolio Notice

This repository contains the source code of a Flutter application developed for a catering company. Production credentials, signing keys, private configuration files, and real user data have been intentionally excluded from this repository.
