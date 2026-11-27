import 'package:flutter/foundation.dart';
import '../models/confirmacao_model.dart';

class SaldoController extends ChangeNotifier {
  late ConfirmacaoModel model;

  SaldoController({
    double saldoAnterior = 12.50,
    required double valorRecarga,
    required String formaPagamento,
    String ultimosDigitosCartao = '4821',
  }) {
    model = ConfirmacaoModel(
      saldoAnterior: saldoAnterior,
      valorRecarga: valorRecarga,
      formaPagamento: formaPagamento,
      ultimosDigitosCartao: ultimosDigitosCartao,
    );
  }

  String _formatarMoeda(double valor) {
    final partes = valor.toStringAsFixed(2).split('.');
    return 'R\$ ${partes[0]},${partes[1]}';
  }

  double calcularNovoSaldo(double saldoAnterior, double valorRecarga) {
    final atualizado = ConfirmacaoModel(
      saldoAnterior: saldoAnterior,
      valorRecarga: valorRecarga,
      formaPagamento: model.formaPagamento,
      ultimosDigitosCartao: model.ultimosDigitosCartao,
    );
    model = atualizado;
    notifyListeners();
    return atualizado.novoSaldo;
  }

  String get valorRecargaFormatado => _formatarMoeda(model.valorRecarga);

  String get novoSaldoFormatado => _formatarMoeda(model.novoSaldo);

  String get resumoAdicao => '${valorRecargaFormatado} adicionados ao cartão';

  String get cartaoMascarado => '•••• ${model.ultimosDigitosCartao}';
}