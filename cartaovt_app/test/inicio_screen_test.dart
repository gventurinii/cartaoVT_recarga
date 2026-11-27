import 'package:cartaovt_app/controllers/inicio_controller.dart';
import 'package:cartaovt_app/views/inicio_screen.dart';
import 'package:cartaovt_app/views/recarga_valor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testes da Tela de início', () {

    testWidgets('Teste para o critério "A tela exibe a saudação com o nome do passageiro e o valor do saldo formatado"', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: InicioScreen()));

      expect(find.text('Olá, ${InicioController().cartao.nomePassageiro}'), findsOneWidget);
      expect(find.text('R\$ 12,50'), findsOneWidget);
    });

    testWidgets('Teste para o critério "A tela exibe os 4 últimos digítos do cartão e o texto de apoio da última recarga"', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: InicioScreen()));
      
      expect(find.text('Cartão **** 4821'), findsOneWidget);
      expect(find.text('Última recarga: 03/11 às 08:12'), findsOneWidget);
    });

    testWidgets('Teste para o critério "Ao tocar no botão + Recarregar saldo, o aplicativo transiciona para a Tela 3', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: InicioScreen()));
      
      final botaoRecarregar = find.text('+ Recarregar saldo');
      expect(botaoRecarregar, findsOneWidget);
      await tester.tap(botaoRecarregar);
      await tester.pumpAndSettle();
      
      expect(find.byType(RecargaValorScreen), findsOneWidget);
    });

    testWidgets('Teste para o critério A barra de navegação inferior exibe as opções Início, Histórico e Perfil', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: InicioScreen()));

      expect(find.text('Início'), findsOneWidget);
      expect(find.text('Histórico'), findsOneWidget);
      expect(find.text('Perfil'), findsOneWidget);
      
      await tester.tap(find.text('Histórico'));
      await tester.pumpAndSettle();

      expect(find.byType(HistoricoScreen), findsOneWidget);
    });
  });
}

class HistoricoScreen {
}