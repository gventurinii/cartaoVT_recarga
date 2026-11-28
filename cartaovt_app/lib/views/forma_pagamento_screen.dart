import 'package:flutter/material.dart';
import '../controllers/pagamento_controller.dart';
import '../views/confirmacao_screen.dart';

class FormaPagamentoScreen extends StatefulWidget {
  final double valorRecarga;
  final String? formaInicial;

  const FormaPagamentoScreen({
    super.key,
    required this.valorRecarga,
    this.formaInicial,
  });

  @override
  State<FormaPagamentoScreen> createState() => _FormaPagamentoScreenState();
}

class _FormaPagamentoScreenState extends State<FormaPagamentoScreen> {
  late final PagamentoController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PagamentoController(
      valorRecarga: widget.valorRecarga,
      formaInicial: widget.formaInicial,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildItemPagamento({
    required bool isDark,
    required String titulo,
    required String subtitulo,
    required Widget iconeEsquerdo,
  }) {
    // ignore: unused_local_variable
    final selecionado = _controller.isSelecionado(titulo);

    return InkWell(
      onTap: () => _controller.selecionarFormaPagamento(titulo),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? const Color(0xFF232629)
                    : const Color(0xFFF1F4F6),
              ),
              child: iconeEsquerdo,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitulo,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: isDark
                          ? Colors.grey.shade400
                          : const Color(0xFF5F666C),
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: titulo,
              // ignore: deprecated_member_use
              groupValue: _controller.model.formaPagamentoSelecionada,
              activeColor: isDark
                  ? const Color(0xFF2EB86B)
                  : const Color(0xFF1E7A46),
              // ignore: deprecated_member_use
              onChanged: (value) {
                if (value != null) {
                  _controller.selecionarFormaPagamento(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Forma de pagamento',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 16),
                      children: [
                        const TextSpan(text: 'Valor da recarga: '),
                        TextSpan(
                          text: _controller.valorFormatado,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildItemPagamento(
                    isDark: isDark,
                    titulo: 'Pix',
                    subtitulo: 'Aprovação imediata',
                    iconeEsquerdo: const Icon(
                      Icons.smartphone,
                      size: 24,
                      color: Color(0xFF5B8DEF),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: isDark
                        ? Colors.grey.shade800
                        : const Color(0xFFE5E9EC),
                  ),

                  _buildItemPagamento(
                    isDark: isDark,
                    titulo: 'Cartão de crédito',
                    subtitulo: 'Visa •••• 4821',
                    iconeEsquerdo: const Icon(
                      Icons.credit_card,
                      size: 24,
                      color: Color(0xFF2596BE),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: isDark
                        ? Colors.grey.shade800
                        : const Color(0xFFE5E9EC),
                  ),

                  _buildItemPagamento(
                    isDark: isDark,
                    titulo: 'Boleto',
                    subtitulo: 'Compensação em 1 dia útil',
                    iconeEsquerdo: Icon(
                      Icons.receipt_long_outlined,
                      size: 24,
                      color: isDark ? Colors.grey.shade300 : Colors.black87,
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? const Color(0xFF1F7A47)
                            : const Color(0xFF1E7A46),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                        disabledForegroundColor: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade600,
                        elevation: 0,
                        shape: StadiumBorder(),
                      ),
                      onPressed: _controller.podeConfirmarPagamento()
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmacaoScreen(
                                    valorRecarga: _controller.model.valorRecarga,
                                    formaPagamento: _controller
                                        .model.formaPagamentoSelecionada!,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: Text(
                        'Confirmar pagamento',
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