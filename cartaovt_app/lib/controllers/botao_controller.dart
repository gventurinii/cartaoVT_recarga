import 'package:flutter/foundation.dart';
import '../models/recarga_model.dart';

class BotaoController extends ChangeNotifier {
  static const double valorMinimo = 10.0;
  static const List<double> valoresProntos = [10.0, 20.0, 30.0, 50.0];

  final RecargaModel model = RecargaModel();

  void _atualizarEstadoContinuar() {
    final valor = model.valorSelecionado ?? 0.0;
    model.continuarHabilitado = valor >= valorMinimo;
  }

  void selecionarValorPronto(double valor) {
    model.valorBotaoPronto = valor;
    model.valorSelecionado = valor;
    model.outroValorTexto = '';
    _atualizarEstadoContinuar();
    notifyListeners();
  }

  void alterarOutroValor(String texto) {
    model.outroValorTexto = texto;
    model.valorBotaoPronto = null;

    final normalizado = texto.trim().replaceAll(',', '.');
    if (normalizado.isEmpty) {
      model.valorSelecionado = null;
    } else {
      model.valorSelecionado = double.tryParse(normalizado);
    }

    _atualizarEstadoContinuar();
    notifyListeners();
  }
}