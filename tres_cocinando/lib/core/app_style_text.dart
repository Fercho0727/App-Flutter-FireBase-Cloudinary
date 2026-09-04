import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  // Login, texto
  static const TextStyle logoLogin = TextStyle(
    fontFamily: 'IceCreamCake',
    fontSize: 40,
    color: Colors.white,
  );

  // Logo y nombre de la empresa
  static const TextStyle logo = TextStyle(
    fontFamily: 'LetterMagic',
    fontSize: 25,
    color: Colors.white,
  );

  // Título especial de la pantalla principal
  // "¿Qué deseas hacer hoy?"
  //static const TextStyle homeTitle = TextStyle(
    //fontFamily: 'IceCreamCake',

  static final TextStyle homeTitle =
      GoogleFonts.tangerine(  
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 230, 63, 7),
  );

  // Títulos principales
  //static final TextStyle title =
      //GoogleFonts.tangerine(
  static const TextStyle title = TextStyle(
    fontFamily: 'LetterMagic',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  // Subtítulos
  static final TextStyle subtitle =
      GoogleFonts.bebasNeue(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: const Color.fromARGB(255, 31, 30, 30)
  );

  // Texto normal
  static final TextStyle body =
      GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  // Texto pequeño
  static final TextStyle bodySmall =
      GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

 // Boton home
  static final TextStyle buttonHome =
      GoogleFonts.quicksand(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Botones
  static final TextStyle button =
      GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

// Botones
  static final TextStyle buttonUser =
      GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  // Barra de búsqueda
  static final TextStyle search =
      GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  // Ingredientes
  static final TextStyle ingredient =
      GoogleFonts.outfit(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  // Procedimientos
  static final TextStyle procedure =
      GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: Colors.black87,
  );

  // Nombres de recetas en tarjetas
   static final TextStyle recipeName =
    GoogleFonts.tangerine(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
  );

  // Cantidad de personas
  static final TextStyle recipeInfo =
      GoogleFonts.josefinSlab(
    fontSize: 15,
    fontWeight: FontWeight.w900,
    color: Colors.black54,
  );

  // Nombre de personas
 static final TextStyle nameUser =
      GoogleFonts.outfit(
    fontSize: 15,
    fontWeight: FontWeight.w900,
    color: Colors.black54,
  );
}