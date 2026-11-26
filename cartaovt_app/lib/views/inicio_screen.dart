import 'package:cartaovt_app/controllers/inicio_controller.dart';
import 'package:flutter/material.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  final InicioController _controller = InicioController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller, 
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Olá, ${_controller.cartao.nomePassageiro}'),
            automaticallyImplyLeading: false,
          ),

          body: Padding(
            padding: EdgeInsets.all(16.0),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Text('Saldo disponível',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),

                        SizedBox(height: 8),
                        Text(
                          _controller.saldoFormatado,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),

                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              _controller.ultimoDigitosCartao,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => EscolherValoresScreen()),
                    );
                  }, 

                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    'Recarregar saldo',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                Spacer(),

                Text(
                  _controller.textoUltimaRecarga,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              if (index == 1) {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => HistoricoScreen()),
                );
              }
            },
            
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'Histórico',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        );
      }
    );
  }
}



class EscolherValoresScreen extends StatelessWidget {
  const EscolherValoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recarregar')),
      body: const Center(child: Text('Escolha um valor')),
    );
  }
}

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico')),
      body: const Center(child: Text('Nenhum histórico disponível')),
    );
  }
}