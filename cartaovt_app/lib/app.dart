import 'package:cartaovt_app/theme/tema.dart';
import 'package:flutter/material.dart';

class CartaoVt_app extends StatefulWidget {
  const CartaoVt_app ({super.key});

  @override
  State<CartaoVt_app> createState() => _CartaoVtState();
}

class _CartaoVtState extends State<CartaoVt_app> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: TemaCartaoVT.escuro(),
      home: const Scaffold(),
    );
  }
  
}