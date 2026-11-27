import 'package:cartaovt_app/controllers/saldo_controller.dart';
import 'package:cartaovt_app/views/confirmacao_screen.dart';
import 'package:cartaovt_app/views/inicio_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testes da Tela 5 - ConfirmacaoScreen e SaldoController', () {
    testWidgets(
      'Exibe ícone de sucesso, texto de conclusão, valor adicionado e dígitos do cartão',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ConfirmacaoScreen(
              saldoAnterior: 12.50,
              valorRecarga: 20.0,
              formaPagamento: 'Pix',
              ultimosDigitosCartao: '4821',
            ),
          ),
        );

        expect(
          find.byKey(const Key('icone_sucesso_confirmacao')),
          findsOneWidget,
        );
        expect(find.text('Recarga concluída!'), findsOneWidget);
        expect(find.text('R\$ 20,00 adicionados ao cartão'), findsOneWidget);
        expect(find.text('•••• 4821'), findsOneWidget);
        expect(find.text('Novo saldo'), findsOneWidget);
        expect(find.text('R\$ 32,50'), findsOneWidget);
      },
    );

    test('SaldoController soma corretamente o saldo anterior ao valor da recarga', () {
      final controller = SaldoController(
        saldoAnterior: 12.50,
        valorRecarga: 20.0,
        formaPagamento: 'Pix',
      );

      final resultado = controller.calcularNovoSaldo(12.50, 20.0);

      expect(resultado, 32.50);
      expect(controller.novoSaldoFormatado, 'R\$ 32,50');
    });

    testWidgets(
      'Ao tocar em Voltar ao início, remove telas intermediárias e retorna para InicioScreen com saldo atualizado',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const InicioScreen(),
            routes: {
              '/confirmacao': (context) => const ConfirmacaoScreen(
                    saldoAnterior: 12.50,
                    valorRecarga: 20.0,
                    formaPagamento: 'Pix',
                    ultimosDigitosCartao: '4821',
                  ),
            },
          ),
        );

        final navigator = tester.state<NavigatorState>(find.byType(Navigator));
        navigator.pushNamed('/confirmacao');
        await tester.pumpAndSettle();

        expect(find.byType(ConfirmacaoScreen), findsOneWidget);

        await tester.tap(find.text('Voltar ao início'));
        await tester.pumpAndSettle();

        expect(find.byType(ConfirmacaoScreen), findsNothing);
        expect(find.byType(InicioScreen), findsOneWidget);
        expect(find.text('R\$ 32,50'), findsOneWidget);
      },
    );
  });
}