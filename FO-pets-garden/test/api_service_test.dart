import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pets_adoption_app/services/api_service.dart'; // Ton service de connexion

// Créer un mock pour simuler l'API
class MockClient extends Mock implements http.Client {}

void main() {
  group('Test unitaire pour la connexion', () {
    // Initialiser le client mocké
    final client = MockClient();
    final apiService = ApiService();

    // Exemple de test pour une connexion réussie
    test('Connexion réussie', () async {
      // Simuler une réponse de l'API avec succès
      when(client.post(
        Uri.parse('http://localhost/BO-pets-garden/login.php'),
        headers: anyNamed('headers'),
        body: json.encode({
          "email": "test@example.com",
          "password": "password123"
        }),
      )).thenAnswer((_) async => http.Response(
          json.encode({"status": "success", "account_id": "1"}), 200));

      // Exécuter la méthode login
      final result = await apiService.login('test@example.com', 'password123');

      // Vérifier que la réponse est correcte
      expect(result['status'], equals('success'));
      expect(result['account_id'], equals('1'));
    });

    // Exemple de test pour une connexion échouée
    test('Connexion échouée', () async {
      // Simuler une réponse de l'API avec échec
      when(client.post(
        Uri.parse('http://localhost/BO-pets-garden/login.php'),
        headers: anyNamed('headers'),
        body: json.encode({
          "email": "wrong@example.com",
          "password": "wrongpassword"
        }),
      )).thenAnswer((_) async => http.Response(
          json.encode({"status": "error", "message": "Invalid credentials"}), 401));

      // Exécuter la méthode login et capturer l'exception
      expect(
        () async => await apiService.login('wrong@example.com', 'wrongpassword'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
