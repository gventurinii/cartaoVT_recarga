import 'package:flutter/foundation.dart';
import 'package:cartaovt_app/models/cartao_model.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final CartaoModel _cartao = CartaoModel(
    numeroCartao: '4821',
    senha: '123', 
    saldo: 12.50, 
    nomePassageiro: '', 
    ultimaRecarga: '',
  );

  String mensagemErro = '';

  bool validarECarregar(String numeroCartao, String senha) {
    if (numeroCartao.isEmpty || senha.isEmpty) {
      mensagemErro = 'Preencher todos os campos.';
      notifyListeners();
      return false;
    }

    if (numeroCartao != _cartao.numeroCartao || senha != _cartao.senha) {
      mensagemErro = 'Cartão ou senha inválidos.';
      notifyListeners();
      return false;
    }

    mensagemErro = '';
    notifyListeners();
    return true;
  }
}