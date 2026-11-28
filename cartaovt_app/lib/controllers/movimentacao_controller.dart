import 'package:flutter/foundation.dart';
import '../models/movimentacao_model.dart';

class MovimentacaoController extends ChangeNotifier {
  final List<MovimentacaoModel> _movimentacoes;

  MovimentacaoController({List<MovimentacaoModel>? movimentacoesIniciais})
      : _movimentacoes = List<MovimentacaoModel>.from(
          movimentacoesIniciais ?? _dadosPadrao(),
        ) {
    ordenarDecrescente();
  }

  static List<MovimentacaoModel> _dadosPadrao() {
    return [
      MovimentacaoModel(
        id: '1',
        descricao: 'Recarga via Pix',
        valor: 20.00,
        dataHora: DateTime(2026, 11, 8, 9, 14),
        tipo: TipoMovimentacao.credito,
      ),
      MovimentacaoModel(
        id: '2',
        descricao: 'Uso · Linha 420',
        valor: 4.40,
        dataHora: DateTime(2026, 11, 8, 9, 40),
        tipo: TipoMovimentacao.debito,
      ),
      MovimentacaoModel(
        id: '3',
        descricao: 'Uso · Linha 115',
        valor: 4.40,
        dataHora: DateTime(2026, 11, 7, 18, 2),
        tipo: TipoMovimentacao.debito,
      ),
      MovimentacaoModel(
        id: '4',
        descricao: 'Recarga via cartão',
        valor: 30.00,
        dataHora: DateTime(2026, 11, 5, 12, 30),
        tipo: TipoMovimentacao.credito,
      ),
      MovimentacaoModel(
        id: '5',
        descricao: 'Uso · Linha 420',
        valor: 4.40,
        dataHora: DateTime(2026, 11, 3, 8, 15),
        tipo: TipoMovimentacao.debito,
      ),
    ];
  }

  List<MovimentacaoModel> get movimentacoes =>
      List<MovimentacaoModel>.unmodifiable(_movimentacoes);

  void ordenarDecrescente() {
    _movimentacoes.sort((a, b) => b.dataHora.compareTo(a.dataHora));
    notifyListeners();
  }

  void adicionarMovimentacao(MovimentacaoModel item) {
    _movimentacoes.add(item);
    ordenarDecrescente();
  }

  String formatarDataHora(DateTime dataHora) {
    final dia = dataHora.day.toString().padLeft(2, '0');
    final mes = dataHora.month.toString().padLeft(2, '0');
    final hora = dataHora.hour.toString().padLeft(2, '0');
    final minuto = dataHora.minute.toString().padLeft(2, '0');
    return '$dia/$mes às $hora:$minuto';
  }

  String formatarValor(MovimentacaoModel item) {
    final partes = item.valor.toStringAsFixed(2).split('.');
    final moeda = 'R\$ ${partes[0]},${partes[1]}';
    final sinal = item.isCredito ? '+' : '-';
    return '$sinal$moeda';
  }
}