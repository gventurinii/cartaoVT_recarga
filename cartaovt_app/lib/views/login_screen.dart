import 'package:cartaovt_app/controllers/login_controller.dart';
import 'package:cartaovt_app/views/inicio_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

    final LoginController _controller = LoginController();

    final TextEditingController _cartaoController = TextEditingController();
    final TextEditingController _senhaController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _cartaoController.dispose();
    _senhaController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: AnimatedBuilder(
        animation: _controller, 
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.directions_bus, size: 64, color: Colors.green),
                SizedBox(height: 16),
                Text(
                  'CartãoVT Recarga',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 32),

                // Campo do cartão: aceita somente números (RN01)
                TextField(
                  controller: _cartaoController,
                  decoration: InputDecoration(
                    labelText: 'Número do cartão',
                    prefixIcon: Icon(Icons.credit_card),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // Campo da senha: formato oculto obscureText: true (RN02)
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(),
                  ),
                ),
          
                // Mensagem de erro vinda do Controller (NR03)
                if (_controller.mensagemErro.isNotEmpty) ...[
                  SizedBox(height: 12),
                  Text(
                    _controller.mensagemErro,
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
              ],
              
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.all(16),
                ),
                onPressed: () {
                  bool autorizado = _controller.validarECarregar(
                    _cartaoController.text,
                    _senhaController.text,
                  );
                  
                  if (autorizado) {
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => InicioScreen()),
                    );
                  }
                },
                child: Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
            ),
          );
        },
      ),
    );
  }
}