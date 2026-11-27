import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/botao_controller.dart';
import 'pagamento_screen.dart';

class RecargaValorScreen extends StatefulWidget {
  const RecargaValorScreen({super.key});

  @override
  State<RecargaValorScreen> createState() => _RecargaValorScreenState();
}

class _RecargaValorScreenState extends State<RecargaValorScreen> {
  final BotaoController _controller = BotaoController();
  final TextEditingController _outroValorController = TextEditingController();

  @override
  void dispose() {
    _outroValorController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final model = _controller.model;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Recarregar',
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
                  const Text(
                    'Escolha um valor',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 16),

                  // Quatro opções prontas lado a lado (R$ 10, R$ 20, R$ 30, R$ 50)
                  Row(
                    children: BotaoController.valoresProntos
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final valor = entry.value;
                      final selecionado = model.valorBotaoPronto == valor;

                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: index < BotaoController.valoresProntos.length - 1
                                ? 10
                                : 0,
                          ),
                          child: SizedBox(
                            height: 68,
                            child: Material(
                              color: selecionado
                                  ? (isDark
                                      ? const Color(0xFF2B8A53)
                                      : const Color(0xFF1E7A46))
                                  : (isDark
                                      ? const Color(0xFF1D3526)
                                      : const Color(0xFFE5F2E8)),
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  _controller.selecionarValorPronto(valor);
                                  if (_outroValorController.text.isNotEmpty) {
                                    _outroValorController.clear();
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'R\$',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: selecionado
                                            ? Colors.white
                                            : (isDark
                                                ? const Color(0xFF8CE0AF)
                                                : const Color(0xFF1E7A46)),
                                      ),
                                    ),
                                    Text(
                                      valor.toStringAsFixed(0),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: selecionado
                                            ? Colors.white
                                            : (isDark
                                                ? const Color(0xFF8CE0AF)
                                                : const Color(0xFF1E7A46)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),

                  // Campo de texto "R$ Outro valor"
                  TextField(
                    key: const Key('outro_valor_field'),
                    controller: _outroValorController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                    ],
                    decoration: InputDecoration(
                      hintText: 'R\$ Outro valor',
                      hintStyle: TextStyle(
                        color: isDark
                            ? Colors.grey.shade400
                            : const Color(0xFF6A7075),
                        fontSize: 15,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isDark
                              ? Colors.grey.shade700
                              : const Color(0xFFCBD2D9),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isDark
                              ? Colors.grey.shade700
                              : const Color(0xFFCBD2D9),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isDark
                              ? const Color(0xFF6DD597)
                              : const Color(0xFF1E7A46),
                          width: 1.5,
                        ),
                      ),
                    ),
                    onChanged: _controller.alterarOutroValor,
                  ),

                  const Spacer(),

                  // Botão inferior "Continuar"
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? const Color(0xFF2B8A53)
                            : const Color(0xFF1E7A46),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                        disabledForegroundColor: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade600,
                        elevation: 0,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: model.continuarHabilitado &&
                              model.valorSelecionado != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PagamentoScreen(
                                    valorRecarga: model.valorSelecionado!,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: const Text(
                        'Continuar',
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