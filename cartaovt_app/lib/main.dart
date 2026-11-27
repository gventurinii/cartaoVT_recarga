import 'package:flutter/material.dart';
import 'views/login_screen.dart';

void main() {
  runApp(const CartaoVTApp());
}

class CartaoVTApp extends StatelessWidget {
  const CartaoVTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CartãoVT Recarga',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E7A46),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E7A46),
          brightness: Brightness.dark,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}