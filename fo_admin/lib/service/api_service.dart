import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Méthode pour obtenir les annonces (Ads)
  Future<List<dynamic>> getAds() async {
    final url = Uri.parse('$baseUrl/get_ads.php');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> ads = json.decode(response.body);
        return ads;
      } else {
        throw Exception('Erreur lors de la récupération des annonces');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  // Méthode pour obtenir les profils (Profiles)
  Future<List<dynamic>> getProfiles() async {
    final url = Uri.parse('$baseUrl/get_profiles.php');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> profiles = json.decode(response.body);
        return profiles;
      } else {
        throw Exception('Erreur lors de la récupération des profils');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }
}
