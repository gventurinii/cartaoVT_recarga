import 'package:flutter/material.dart';

// Guia de estilos do Empresta AI
class TemaCartaoVT {
  static const corSemente = Color.fromARGB(255, 0, 0, 0);

  static ThemeData claro() => _base(Brightness.light);
  static ThemeData escuro() => _base(Brightness.dark);

  static ThemeData _base(Brightness brilho){
    final cores = ColorScheme.fromSeed(
      seedColor: corSemente,
      brightness: brilho,
    );

    return ThemeData(
      brightness: brilho,
      colorScheme: cores,
      useMaterial3: true,
    );
  }
}