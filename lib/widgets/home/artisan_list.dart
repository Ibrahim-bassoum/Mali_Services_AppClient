import 'package:flutter/material.dart';
// Importation de la page de profil pour la navigation
import '../../screens/artisan_profile_screen.dart';

class ArtisanListSection extends StatelessWidget {
  const ArtisanListSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Données fictives pour tes artisans à Bamako
    final List<Map<String, dynamic>> artisans = [
      {
        'name': 'Modibo Diallo',
        'job': 'Plombier',
        'rating': 4.8,
        'location': 'Kalaban Coura',
        'bio': 'Expert en dépannage et installation sanitaire depuis 10 ans.',
      },
      {
        'name': 'Adama Traoré',
        'job': 'Électricien',
        'rating': 4.5,
        'location': 'Sébénikoro',
        'bio': 'Spécialiste en installation solaire et maintenance électrique.',
      },
      {
        'name': 'Bakary Koné',
        'job': 'Menuisier',
        'rating': 4.9,
        'location': 'Baco Djicoroni',
        'bio': 'Fabrication de meubles sur mesure et aménagement intérieur.',
      },
      {
        'name': 'Sékou Touré',
        'job': 'Maçon',
        'rating': 4.7,
        'location': 'Hamdallaye',
        'bio': 'Construction de villas et rénovation de bâtiments.',
      },
    ];

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

        // --- LISTE DES ARTISANS ---
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Important pour le défilement fluide du Home
          itemCount: artisans.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // NAVIGATION : On envoie les données de l'artisan à la page de profil
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtisanProfileScreen(artisan: artisans[index]),
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
                    // Avatar de l'artisan
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
                    
                    // Détails (Nom, Métier, Note, Lieu)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            artisans[index]['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF071B44),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            artisans[index]['job'],
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
                                "${artisans[index]['rating']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(Icons.location_on, color: Colors.redAccent, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                artisans[index]['location'],
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
                    
                    // Petite flèche pour indiquer qu'on peut cliquer
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
        ),
        
        // Espace en bas pour ne pas que le dernier artisan soit collé à la barre de navigation
        const SizedBox(height: 20),
      ],
    );
  }
}