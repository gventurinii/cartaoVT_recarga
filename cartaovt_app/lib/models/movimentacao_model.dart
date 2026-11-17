class MovimentacaoModel {
  final String tipo;
  final String descricao;
  final String dataHora;
  final double valor;

  MovimentacaoModel ({
    required this.tipo,
    required this.descricao,
    required this.dataHora,
    required this.valor,
  });
}