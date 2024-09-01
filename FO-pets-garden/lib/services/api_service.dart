import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost/BO-pets-garden/";

  // ========================
  // Accounts and Profiles
  // ========================

  // Créer un compte utilisateur et un profil associé
  Future<void> createAccount(Map<String, dynamic> accountData) async {
    final response = await http.post(
      Uri.parse(baseUrl + "create_account.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(accountData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create account');
    }
  }

  // Connexion de l'utilisateur
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl + "login.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == 'success') {
        return responseBody;
      } else {
        throw Exception(responseBody['message']);
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  // Récupérer le profil utilisateur
  Future<Map<String, dynamic>> getProfile(int accountId) async {
    final response = await http.post(
      Uri.parse(baseUrl + "get_profile.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"account_id": accountId}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  // Mettre à jour le profil utilisateur
  Future<void> updateProfile(Map<String, dynamic> profileData) async {
    final response = await http.post(
      Uri.parse(baseUrl + "update_profile.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(profileData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }

  // Supprimer un compte utilisateur
  Future<void> deleteAccount(int accountId) async {
    final response = await http.post(
      Uri.parse(baseUrl + "delete_account.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"id": accountId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete account');
    }
  }

  // Déconnexion de l'utilisateur
  Future<bool> logout() async {
    final response = await http.get(Uri.parse(baseUrl + "logout.php"));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // ========================
  // Ads (Annonces)
  // ========================

  // Récupérer toutes les annonces
  Future<List<dynamic>> getAds() async {
    final response = await http.get(Uri.parse(baseUrl + "get_ads.php"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load ads');
    }
  }

  // Ajouter une annonce
  Future<void> addAd(Map<String, dynamic> adData) async {
    final response = await http.post(
      Uri.parse(baseUrl + "add_ad.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(adData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add ad');
    }
  }

  // Mettre à jour une annonce
  Future<void> updateAd(Map<String, dynamic> adData) async {
    final response = await http.post(
      Uri.parse(baseUrl + "update_ad.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(adData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update ad');
    }
  }

  // Supprimer une annonce
  Future<void> deleteAd(int id) async {
    final response = await http.post(
      Uri.parse(baseUrl + "delete_ad.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"id": id}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete ad');
    }
  }

  // ========================
  // Messages
  // ========================

  // Récupérer les messages pour une annonce spécifique
  Future<List<dynamic>> getMessages(int adId) async {
    final response = await http.post(
      Uri.parse(baseUrl + "get_messages.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"ad_id": adId}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load messages');
    }
  }

  // Envoyer un message pour une annonce spécifique
  Future<void> sendMessage(Map<String, dynamic> messageData) async {
    final response = await http.post(
      Uri.parse(baseUrl + "send_message.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(messageData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }
}
