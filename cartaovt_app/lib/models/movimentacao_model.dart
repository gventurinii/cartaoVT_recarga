enum TipoMovimentacao {
  credito,
  debito,
}

class MovimentacaoModel {
  final String id;
  final String descricao;
  final double valor;
  final DateTime dataHora;
  final TipoMovimentacao tipo;

  const MovimentacaoModel({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.dataHora,
    required this.tipo,
  });

  bool get isCredito => tipo == TipoMovimentacao.credito;
}