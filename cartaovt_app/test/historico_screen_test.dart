import 'package:cartaovt_app/models/movimentacao_model.dart';
import 'package:cartaovt_app/views/historico_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testes da Tela 6 - HistoricoScreen', () {
    final movimentacoesSimuladas = [
      MovimentacaoModel(
        id: 'a',
        descricao: 'Uso · Linha 420',
        valor: 4.40,
        dataHora: DateTime(2026, 11, 8, 9, 40),
        tipo: TipoMovimentacao.debito,
      ),
      MovimentacaoModel(
        id: 'b',
        descricao: 'Recarga via Pix',
        valor: 20.00,
        dataHora: DateTime(2026, 11, 8, 9, 14),
        tipo: TipoMovimentacao.credito,
      ),
      MovimentacaoModel(
        id: 'c',
        descricao: 'Uso · Linha 115',
        valor: 4.40,
        dataHora: DateTime(2026, 11, 7, 18, 2),
        tipo: TipoMovimentacao.debito,
      ),
    ];

    testWidgets(
      'Renderiza movimentações em ordem cronológica decrescente (mais recente primeiro)',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: HistoricoScreen(movimentacoes: movimentacoesSimuladas),
          ),
        );

        final posRecente = tester.getTopLeft(find.text('08/11 às 09:40')).dy;
        final posMeio = tester.getTopLeft(find.text('08/11 às 09:14')).dy;
        final posAntigo = tester.getTopLeft(find.text('07/11 às 18:02')).dy;

        expect(posRecente, lessThan(posMeio));
        expect(posMeio, lessThan(posAntigo));
      },
    );

    testWidgets(
      'Exibe data, hora, descrição e valor formatado para cada transação',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: HistoricoScreen(movimentacoes: movimentacoesSimuladas),
          ),
        );

        expect(find.text('Uso · Linha 420'), findsOneWidget);
        expect(find.text('08/11 às 09:40'), findsOneWidget);
        expect(find.text('-R\$ 4,40'), findsOneWidget);

        expect(find.text('Recarga via Pix'), findsOneWidget);
        expect(find.text('08/11 às 09:14'), findsOneWidget);
        expect(find.text('+R\$ 20,00'), findsOneWidget);

        expect(find.text('Uso · Linha 115'), findsOneWidget);
        expect(find.text('07/11 às 18:02'), findsOneWidget);
      },
    );

    testWidgets(
      'Aplica sinal + e cor verde para créditos e sinal − e cor vermelha para débitos',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: HistoricoScreen(movimentacoes: movimentacoesSimuladas),
          ),
        );

        final textoCredito = tester.widget<Text>(find.text('+R\$ 20,00'));
        final textoDebito = tester.widget<Text>(find.text('−R\$ 4,40').first);

        expect(textoCredito.data, startsWith('+'));
        expect(textoCredito.style?.color, const Color(0xFF1E7A46));

        expect(textoDebito.data, startsWith('-'));
        expect(textoDebito.style?.color, const Color(0xFFC62828));
      },
    );

    testWidgets(
      'Utiliza ListView na árvore de widgets e suporta múltiplos itens',
      (WidgetTester tester) async {
        final muitosItens = List.generate(
          15,
          (i) => MovimentacaoModel(
            id: '$i',
            descricao: 'Uso · Linha ${400 + i}',
            valor: 4.40,
            dataHora: DateTime(2026, 11, 1, 8, 0).add(Duration(hours: i)),
            tipo: i.isEven ? TipoMovimentacao.debito : TipoMovimentacao.credito,
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: HistoricoScreen(movimentacoes: muitosItens),
          ),
        );

        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Uso · Linha 414'), findsOneWidget);
      },
    );
  });
}