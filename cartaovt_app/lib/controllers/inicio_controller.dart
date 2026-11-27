import 'package:cartaovt_app/models/cartao_model.dart';
import 'package:flutter/foundation.dart';

class InicioController extends ChangeNotifier {
  final CartaoModel cartao = CartaoModel(
    numeroCartao: '4821', 
    senha: '1234',
    nomePassageiro: 'Gabriel',
    saldo: 12.50, 
    ultimaRecarga: '03/11 às 08:12',
    );

  String get saldoFormatado {
    return 'R\$ ${cartao.saldo.toStringAsFixed(2).replaceFirst('.', ',')}';
  }

  String get ultimoDigitosCartao {
    return 'Cartão **** ${cartao.numeroCartao}';
  }

  String get textoUltimaRecarga {
    return 'Última recarga: ${cartao.ultimaRecarga}';
  }

  void atualizarSaldo(double novoSaldo) {
  cartao.saldo = novoSaldo;
  notifyListeners();
}
}