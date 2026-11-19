class CartaoModel {
  String numeroCartao;
  String senha;
  String nomePassageiro;
  double saldo;
  String ultimaRecarga;


  CartaoModel( {
    required this.numeroCartao,
    required this.senha,
    required this.nomePassageiro,
    required this.saldo,
    required this.ultimaRecarga,
  });
}