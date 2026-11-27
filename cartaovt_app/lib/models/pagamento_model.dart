class PagamentoModel {
  final double valorRecarga;
  String? formaPagamentoSelecionada;

  PagamentoModel({
    required this.valorRecarga,
    this.formaPagamentoSelecionada,
  });

  bool get possuiFormaSelecionada =>
      formaPagamentoSelecionada != null && formaPagamentoSelecionada!.isNotEmpty;
}