import 'package:flutter/material.dart';
import '../controllers/movimentacao_controller.dart';
import '../models/movimentacao_model.dart';

class HistoricoScreen extends StatefulWidget {
  final List<MovimentacaoModel>? movimentacoes;

  const HistoricoScreen({super.key, this.movimentacoes});

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  late final MovimentacaoController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MovimentacaoController(
      movimentacoesIniciais: widget.movimentacoes,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final itens = _controller.movimentacoes;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Histórico',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: SafeArea(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: itens.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: isDark
                    ? Colors.grey.shade800
                    : const Color(0xFFE5E9EC),
              ),
              itemBuilder: (context, index) {
                final item = itens[index];
                final isCredito = item.isCredito;
                final corValor = isCredito
                    ? (isDark
                        ? const Color(0xFF39D98A)
                        : const Color(0xFF1E7A46))
                    : (isDark
                        ? const Color(0xFFFF6B6B)
                        : const Color(0xFFC62828));

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        child: Icon(
                          isCredito
                              ? Icons.credit_card
                              : Icons.directions_bus,
                          size: 22,
                          color: isCredito
                              ? (isDark
                                  ? const Color(0xFF56CCF2)
                                  : const Color(0xFF1E7A46))
                              : (isDark
                                  ? const Color(0xFFF2C94C)
                                  : const Color(0xFF374151)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.descricao,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              _controller.formatarDataHora(item.dataHora),
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
                      const SizedBox(width: 12),
                      Text(
                        _controller.formatarValor(item),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: corValor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}