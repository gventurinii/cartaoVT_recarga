import 'package:flutter/foundation.dart';
import '../models/pagamento_model.dart';

class PagamentoController extends ChangeNotifier {
  static const List<String> opcoesPagamento = [
    'Pix',
    'Cartão de crédito',
    'Boleto',
  ];

  final PagamentoModel model;

  PagamentoController({
    required double valorRecarga,
    String? formaInicial,
  }) : model = PagamentoModel(
          valorRecarga: valorRecarga,
          formaPagamentoSelecionada: formaInicial,
        );

  String get valorFormatado {
    final partes = model.valorRecarga.toStringAsFixed(2).split('.');
    return 'R\$ ${partes[0]},${partes[1]}';
  }

  void selecionarFormaPagamento(String forma) {
    if (!opcoesPagamento.contains(forma)) return;
    model.formaPagamentoSelecionada = forma;
    notifyListeners();
  }

  bool isSelecionado(String forma) {
    return model.formaPagamentoSelecionada == forma;
  }

  bool podeConfirmarPagamento() {
    return model.possuiFormaSelecionada && model.valorRecarga > 0;
  }
}