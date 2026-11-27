import 'package:flutter/material.dart';
import '../controllers/saldo_controller.dart';
import 'inicio_screen.dart';

class ConfirmacaoScreen extends StatefulWidget {
  final double saldoAnterior;
  final double valorRecarga;
  final String formaPagamento;
  final String ultimosDigitosCartao;

  const ConfirmacaoScreen({
    super.key,
    this.saldoAnterior = 12.50,
    required this.valorRecarga,
    required this.formaPagamento,
    this.ultimosDigitosCartao = '4821',
  });

  @override
  State<ConfirmacaoScreen> createState() => _ConfirmacaoScreenState();
}

class _ConfirmacaoScreenState extends State<ConfirmacaoScreen> {
  late final SaldoController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SaldoController(
      saldoAnterior: widget.saldoAnterior,
      valorRecarga: widget.valorRecarga,
      formaPagamento: widget.formaPagamento,
      ultimosDigitosCartao: widget.ultimosDigitosCartao,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _voltarAoInicio(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => InicioScreen(
          saldoAtualizado: _controller.model.novoSaldo,
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),

                  // Ícone de sucesso
                  Center(
                    child: Container(
                      key: const Key('icone_sucesso_confirmacao'),
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF4ADE80)
                            : const Color(0xFF22A05B),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        size: 42,
                        color: isDark ? const Color(0xFF102217) : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mensagem de conclusão
                  Text(
                    'Recarga concluída!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? const Color(0xFF4ADE80)
                          : const Color(0xFF1E7A46),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Resumo do valor adicionado e últimos dígitos do cartão
                  Text(
                    _controller.resumoAdicao,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? Colors.grey.shade300
                          : const Color(0xFF4A5056),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _controller.cartaoMascarado,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? Colors.grey.shade300
                          : const Color(0xFF4A5056),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Card de "Novo saldo"
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1D2220)
                          : const Color(0xFFE9F4EC),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Novo saldo',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _controller.novoSaldoFormatado,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? const Color(0xFF4ADE80)
                                : const Color(0xFF1E7A46),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Botão "Voltar ao início"
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? const Color(0xFF1F7A47)
                            : const Color(0xFF1E7A46),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () => _voltarAoInicio(context),
                      child: const Text(
                        'Voltar ao início',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}