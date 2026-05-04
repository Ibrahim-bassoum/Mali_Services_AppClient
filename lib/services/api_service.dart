import 'dart:convert';
import 'package:app_mali_services_client/models/artisan_model.dart';
import 'package:http/http.dart' as http;
import '../models/artisan_model.dart'; // Assure-toi d'avoir créé le modèle

class ApiService {
  // IMPORTANT : Remplace par l'IP de ton PC (ex: 192.168.1.10) 
  // car 'localhost' ne marche pas sur un téléphone physique.
  static const String baseUrl = "http://192.168.1.37:8000/api"; 

  Future<List<ArtisanModel>> fetchArtisans() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/artisans'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> artisansJson = responseData['data'];
        
        return artisansJson.map((json) => ArtisanModel.fromJson(json)).toList();
      } else {
        throw Exception('Échec du chargement des artisans');
      }
    } catch (e) {
      throw Exception('Erreur de connexion : $e');
    }
  }
}