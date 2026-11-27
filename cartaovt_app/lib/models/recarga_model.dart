class RecargaModel {
  double? valorSelecionado;
  double? valorBotaoPronto;
  String outroValorTexto;
  bool continuarHabilitado;

  RecargaModel({
    this.valorSelecionado,
    this.valorBotaoPronto,
    this.outroValorTexto = '',
    this.continuarHabilitado = false,
  });
}