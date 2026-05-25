import 'dart:convert';
import 'package:app_mali_services_client/models/artisan_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Assure-toi d'avoir créé le modèle

class ApiService {
  // IMPORTANT : Remplace par l'IP de ton PC (ex: 192.168.1.10) 
  // car 'localhost' ne marche pas sur un téléphone physique.
  static const String baseUrl ="http://172.20.10.4:8000/api"; 

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


Future<Map<String, dynamic>> getUserProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('auth_token'); // Vérifie bien le nom ici !

  final response = await http.get(
    Uri.parse('$baseUrl/user'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    
    // DEBUG : On affiche tout dans la console VS Code
    print("----- DEBUG MALI SERVICES -----");
    print("Réponse brute du serveur : ${response.body}");
    
    if (responseData.containsKey('data')) {
       print("Nom trouvé dans 'data' : ${responseData['data']['name']}");
       return responseData['data'];
    }
    
    print("Clé 'data' absente, retour du body complet.");
    return responseData;
  } else {
    print("Erreur API : ${response.statusCode}");
    throw Exception('Erreur de profil');
  }
}
}