import 'package:flutter/material.dart';
import '../widgets/search/filter_chips_section.dart';
import '../widgets/search/horizontal_categories.dart';
import '../widgets/search/artisan_search_card.dart';
import 'package:app_mali_services_client/widgets/home/search_bar_section.dart';

// AJOUTE CES DEUX IMPORTS
import '../services/api_service.dart';
import '../models/artisan_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // On initialise le service
    final ApiService apiService = ApiService();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Recherche", style: TextStyle(color: Color(0xFF071B44), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: SearchSection(),
            ),
            const FilterChipsSection(),
            const HorizontalCategories(),

            const Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Artisans disponibles", 
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            // --- DEBUT DE LA ZONE DYNAMIQUE ---
            FutureBuilder<List<ArtisanModel>>(
              future: apiService.fetchArtisans(), // On appelle Laravel
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF08B64B)));
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erreur : ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Aucun artisan trouvé en base de données"));
                } else {
                  // On crée la liste dynamiquement
                  return Column(
                    children: snapshot.data!.map((artisan) {
                      return ArtisanSearchCard(
                        name: artisan.name,              // Vient d'Adama dans Laravel
                        job: artisan.specialty,         // Vient d'Adama dans Laravel
                        rating: 4.5,                    // Tu pourras dynamiser plus tard
                        reviewCount: 10,
                        location: artisan.location,     // Vient de Laravel
                        distance: "À proximité",
                        interventionTime: "Rapide",
                        isAvailable: artisan.isAvailable,
                      );
                    }).toList(),
                  );
                }
              },
            ),
            // --- FIN DE LA ZONE DYNAMIQUE ---
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}