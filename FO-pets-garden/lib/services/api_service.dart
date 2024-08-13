import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost/phpmyadmin/index.php?route=/database/structure&server=1&db=pets_garden";

  Future<List<dynamic>> getAds() async {
    final response = await http.get(Uri.parse(baseUrl + "get_ads.php"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load ads');
    }
  }

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
}
