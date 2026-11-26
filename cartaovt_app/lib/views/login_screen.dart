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
  bool _senhaEscondida = true;

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
                Icon(Icons.directions_bus, size: 72, color: Colors.green),
                SizedBox(height: 16),
                Text(
                  'CartãoVT Recarga',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  'Consulte o saldo e recarregue seu cartão de vale-transporte.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 16),
                
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
                  obscureText: _senhaEscondida,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      tooltip: _senhaEscondida ? 'Mostrar senha' : 'Ocultar senha',
                      icon: Icon(
                        _senhaEscondida ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _senhaEscondida = !_senhaEscondida;
                        });
                      },
                    ),
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