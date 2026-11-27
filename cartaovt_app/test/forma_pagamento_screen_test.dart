import 'package:cartaovt_app/views/forma_pagamento_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testes da Tela 4 - FormaPagamentoScreen', () {
    testWidgets(
      'Renderiza corretamente o valor exato da recarga repassado para a tela',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormaPagamentoScreen(valorRecarga: 20.0),
          ),
        );

        final textRich = tester.widget<Text>(
          find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                widget.textSpan != null &&
                widget.textSpan!.toPlainText() == 'Valor da recarga: R\$ 20,00',
          ),
        );
        expect(textRich.textSpan?.toPlainText(), 'Valor da recarga: R\$ 20,00');
      },
    );

    testWidgets(
      'Exibe os itens Pix, Cartão de crédito e Boleto na árvore de widgets',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormaPagamentoScreen(valorRecarga: 20.0),
          ),
        );

        expect(find.text('Pix'), findsOneWidget);
        expect(find.text('Cartão de crédito'), findsOneWidget);
        expect(find.text('Boleto'), findsOneWidget);
      },
    );

    testWidgets(
      'Selecionar múltiplos métodos sucessivamente mantém apenas o último ativo',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormaPagamentoScreen(valorRecarga: 20.0),
          ),
        );

        await tester.tap(find.text('Pix'));
        await tester.pump();

        Radio<String> pixRadio = tester.widget(
          find.byWidgetPredicate(
            (widget) => widget is Radio<String> && widget.value == 'Pix',
          ),
        );
        // ignore: deprecated_member_use
        expect(pixRadio.groupValue, 'Pix');

        await tester.tap(find.text('Cartão de crédito'));
        await tester.pump();

        pixRadio = tester.widget(
          find.byWidgetPredicate(
            (widget) => widget is Radio<String> && widget.value == 'Pix',
          ),
        );
        Radio<String> cartaoRadio = tester.widget(
          find.byWidgetPredicate(
            (widget) =>
                widget is Radio<String> && widget.value == 'Cartão de crédito',
          ),
        );
        // ignore: deprecated_member_use
        expect(pixRadio.groupValue, 'Cartão de crédito');
        // ignore: deprecated_member_use
        expect(cartaoRadio.groupValue, 'Cartão de crédito');

        await tester.tap(find.text('Boleto'));
        await tester.pump();

        cartaoRadio = tester.widget(
          find.byWidgetPredicate(
            (widget) =>
                widget is Radio<String> && widget.value == 'Cartão de crédito',
          ),
        );
        Radio<String> boletoRadio = tester.widget(
          find.byWidgetPredicate(
            (widget) => widget is Radio<String> && widget.value == 'Boleto',
          ),
        );
        // ignore: deprecated_member_use
        expect(cartaoRadio.groupValue, 'Boleto');
        // ignore: deprecated_member_use
        expect(boletoRadio.groupValue, 'Boleto');
      },
    );
  });
}