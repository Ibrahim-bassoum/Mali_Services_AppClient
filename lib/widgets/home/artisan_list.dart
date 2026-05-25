import 'package:flutter/material.dart';
import '../../screens/artisan_profile_screen.dart';
import '../../services/api_service.dart';
import '../../models/artisan_model.dart';

class ArtisanListSection extends StatefulWidget {
  const ArtisanListSection({super.key});

  @override
  State<ArtisanListSection> createState() => _ArtisanListSectionState();
}

class _ArtisanListSectionState extends State<ArtisanListSection> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- TITRE DE LA SECTION ---
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            "Professionnels proches",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF071B44),
            ),
          ),
        ),

        // --- FUTUREBUILDER CONNECTÉ À TON API ---
        FutureBuilder<List<ArtisanModel>>(
          future: _apiService.fetchArtisans(),
          builder: (context, snapshot) {
            // 1. ÉTAT DE CHARGEMENT
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: CircularProgressIndicator(color: Color(0xFF08B64B)),
                ),
              );
            }

            // 2. GESTION DES ERREURS
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Erreur de chargement des artisans",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              );
            }

            // 3. RÉCUPÉRATION DES DONNÉES
            final List<ArtisanModel> artisans = snapshot.data ?? [];

            if (artisans.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Aucun artisan disponible."),
                ),
              );
            }

            // 4. AFFICHAGE DE LA LISTE
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Scroll géré par la Home
              itemCount: artisans.length,
              itemBuilder: (context, index) {
                final artisan = artisans[index];

                return GestureDetector(
                  onTap: () {
                    // Vérifie que ArtisanProfileScreen accepte un objet ArtisanModel
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtisanProfileScreen(artisan: artisan),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Avatar (Statique pour le moment, ou dynamique si tu as l'URL)
                        Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            color: const Color(0xFF08B64B).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF08B64B),
                            size: 35,
                          ),
                        ),
                        const SizedBox(width: 15),

                        // Détails de l'artisan (Utilisation des champs de ton ArtisanModel)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                artisan.name, // Ton modèle utilise 'name'
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF071B44),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                artisan.specialty, // Ton modèle utilise 'specialty'
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.orange, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${artisan.rating}", // Ton modèle utilise 'rating'
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.location_on, color: Colors.redAccent, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    artisan.location, // Ton modèle utilise 'location'
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}