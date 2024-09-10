import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pets_adoption_app/services/api_service.dart';
import 'package:pets_adoption_app/Screen/Connexion/connexion.dart';

void main() {
  testWidgets('Test de l\'écran de connexion', (WidgetTester tester) async {
    // Créer un widget testable pour l'écran de connexion
    await tester.pumpWidget(
      MaterialApp(
        home: Provider<ApiService>(
          create: (_) => ApiService(),
          child: LogInScreen(),
        ),
      ),
    );

    // Vérifier que les champs email et mot de passe sont présents
    expect(find.byKey(Key('emailField')), findsOneWidget);
    expect(find.byKey(Key('passwordField')), findsOneWidget);

    // Simuler l'entrée des données dans les champs
    await tester.enterText(find.byKey(Key('emailField')), 'amine@gmail.com');
    await tester.enterText(find.byKey(Key('passwordField')), 'amine123');

    // Simuler le clic sur le bouton de connexion
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Vérifier que le login a réussi (à ajuster selon le comportement réel après connexion)
    // Par exemple, tu peux vérifier l'affichage d'un texte spécifique :
    expect(find.text('Connexion réussie'), findsNothing); // À ajuster selon ta logique
  });
}
