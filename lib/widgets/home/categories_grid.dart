import 'package:flutter/material.dart';
// Importation de la page que nous avons créée ensemble
import '../../screens/all_categories_screen.dart'; 

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste des 8 catégories prioritaires pour l'accueil
    final List<Map<String, dynamic>> categories = [
      {'name': 'Menuisier', 'icon': Icons.carpenter, 'color': Colors.brown},
      {'name': 'Plombier', 'icon': Icons.water_drop, 'color': Colors.blue},
      {'name': 'Électricien', 'icon': Icons.bolt, 'color': Colors.orange},
      {'name': 'Maçon', 'icon': Icons.foundation, 'color': Colors.blueGrey},
      {'name': 'Mécanicien', 'icon': Icons.settings, 'color': Colors.red},
      {'name': 'Couturier', 'icon': Icons.content_cut, 'color': Colors.purple},
      {'name': 'Peintre', 'icon': Icons.format_paint, 'color': Colors.pink},
      {'name': 'Soudeur', 'icon': Icons.precision_manufacturing, 'color': Colors.cyan},
    ];

    return Column(
      children: [
        // --- ENTÊTE DE LA SECTION ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Catégories populaires",
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: Color(0xFF071B44)
                ),
              ),
              TextButton(
                onPressed: () {
                  // ACTION : Ouvre la page de tous les métiers
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllCategoriesScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Voir tout", 
                  style: TextStyle(
                    color: Color(0xFF08B64B), 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),

        // --- GRILLE DES ICÔNES ---
        GridView.builder(
          shrinkWrap: true, 
          physics: const NeverScrollableScrollPhysics(), 
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, 
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.8, 
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Action quand on clique sur un métier précis
                print("Recherche pour : ${categories[index]['name']}");
              },
              borderRadius: BorderRadius.circular(15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      categories[index]['icon'],
                      color: categories[index]['color'],
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    categories[index]['name'],
                    style: const TextStyle(
                      fontSize: 11, 
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF071B44)
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}