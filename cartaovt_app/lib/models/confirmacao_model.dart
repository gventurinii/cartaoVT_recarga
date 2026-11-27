class ConfirmacaoModel {
  final double saldoAnterior;
  final double valorRecarga;
  final String formaPagamento;
  final String ultimosDigitosCartao;
  final double novoSaldo;

  ConfirmacaoModel({
    required this.saldoAnterior,
    required this.valorRecarga,
    required this.formaPagamento,
    required this.ultimosDigitosCartao,
  }) : novoSaldo = saldoAnterior + valorRecarga;
}