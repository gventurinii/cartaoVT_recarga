
import 'package:cartaovt_app/views/inicio_screen.dart';
import 'package:cartaovt_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {
  group('Testes da Tela de Login', () {
    testWidgets('Test para critério "campo vazio não navega"', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final entrarButton = find.text('Entrar');
      expect(entrarButton, findsOneWidget);
      await tester.tap(entrarButton);
      await tester.pump();

      expect(find.text('Preencher todos os campos.'), findsOneWidget);

      expect(find.byType(InicioScreen), findsNothing);
    });
    
    testWidgets('Teste para o critério "caractere não númerico não é aceito no campo do cartão"', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final cartaoField = find.byType(TextField).at(0);

      await tester.enterText(cartaoField, 'a');
      await tester.pump();

      final controller = tester.widget<TextField>(cartaoField).controller!;
      expect(controller.text, 'a');
    });

    testWidgets('Teste para critério "cartão e senha válidos levam até a Tela 2"', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final cartaoField = find.byType(TextField).at(0);
      await tester.enterText(cartaoField, '4821');

      final senhaField = find.byType(TextField).at(1);
      await tester.enterText(senhaField, '123');
      await tester.pump();

      final entrarButton = find.text('Entrar');
      await tester.tap(entrarButton);
      await tester.pumpAndSettle();

      expect(find.byType(InicioScreen), findsOneWidget);
    });
  });
}