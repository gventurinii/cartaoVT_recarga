import 'package:cartaovt_app/views/recarga_valor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cartaovt_app/views/recarga_valor_screen.dart';

void main() {
  group('Testes da Tela 3 - RecargaValorScreen', () {
    testWidgets(
      'Exibe quatro opções de valores prontos (R\$ 10, R\$ 20, R\$ 30, R\$ 50) e campo Outro valor',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: RecargaValorScreen()),
        );

        expect(find.text('10'), findsOneWidget);
        expect(find.text('20'), findsOneWidget);
        expect(find.text('30'), findsOneWidget);
        expect(find.text('50'), findsOneWidget);
        expect(find.text('R\$'), findsNWidgets(4));
        expect(find.byKey(const Key('outro_valor_field')), findsOneWidget);
      },
    );

    testWidgets(
      'Selecionar valor pronto limpa Outro valor; digitar em Outro valor desmarca botão pronto',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: RecargaValorScreen()),
        );

        final campoOutroValor = find.byKey(const Key('outro_valor_field'));

        await tester.enterText(campoOutroValor, '25');
        await tester.pump();
        expect(find.text('25'), findsOneWidget);

        await tester.tap(find.text('20'));
        await tester.pump();

        final textFieldWidget = tester.widget<TextField>(campoOutroValor);
        expect(textFieldWidget.controller?.text, isEmpty);

        await tester.enterText(campoOutroValor, '15');
        await tester.pump();

        final material20 = tester.widget<Material>(
          find.ancestor(
            of: find.text('20'),
            matching: find.byType(Material),
          ).first,
        );
        expect(material20.color, isNot(const Color(0xFF1E7A46)));
      },
    );

    testWidgets(
      'Botão Continuar fica desabilitado enquanto valor for inferior a R\$ 10,00',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: RecargaValorScreen()),
        );

        final botaoContinuar = find.widgetWithText(ElevatedButton, 'Continuar');
        final campoOutroValor = find.byKey(const Key('outro_valor_field'));

        expect(tester.widget<ElevatedButton>(botaoContinuar).onPressed, isNull);

        await tester.enterText(campoOutroValor, '5');
        await tester.pump();
        expect(tester.widget<ElevatedButton>(botaoContinuar).onPressed, isNull);

        await tester.enterText(campoOutroValor, '10');
        await tester.pump();
        expect(
          tester.widget<ElevatedButton>(botaoContinuar).onPressed,
          isNotNull,
        );
      },
    );
  });
}