import 'package:flutter/material.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ta liste complète des 18 métiers ici
    final List<Map<String, dynamic>> allCategories = [
      {'name': 'Menuisier', 'icon': Icons.carpenter, 'color': Colors.brown},
      {'name': 'Plombier', 'icon': Icons.water_drop, 'color': Colors.blue},
      {'name': 'Électricien', 'icon': Icons.bolt, 'color': Colors.orange},
      {'name': 'Maçon', 'icon': Icons.foundation, 'color': Colors.blueGrey},
      {'name': 'Mécanicien', 'icon': Icons.settings, 'color': Colors.red},
      {'name': 'Couturier', 'icon': Icons.content_cut, 'color': Colors.purple},
      {'name': 'Peintre', 'icon': Icons.format_paint, 'color': Colors.pink},
      {'name': 'Soudeur', 'icon': Icons.precision_manufacturing, 'color': Colors.cyan},
      {'name': 'Climaticien', 'icon': Icons.ac_unit, 'color': Colors.lightBlue},
      {'name': 'Jardinier', 'icon': Icons.yard, 'color': Colors.green},
      {'name': 'Livreur', 'icon': Icons.delivery_dining, 'color': Colors.deepOrange},
      {'name': 'Coiffeur', 'icon': Icons.content_cut_rounded, 'color': Colors.black},
      {'name': 'Carreleur', 'icon': Icons.grid_on, 'color': Colors.blueGrey},
      {'name': 'Vigile', 'icon': Icons.security, 'color': Colors.indigo},
      {'name': 'Ménage', 'icon': Icons.cleaning_services, 'color': Colors.teal},
      {'name': 'Informatique', 'icon': Icons.computer, 'color': Colors.blue},
      {'name': 'Froid', 'icon': Icons.kitchen, 'color': Colors.cyanAccent},
      {'name': 'Électroménager', 'icon': Icons.iron, 'color': Colors.grey},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Toutes les catégories", style: TextStyle(color: Color(0xFF071B44))),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF071B44)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 colonnes pour que ce soit plus aéré sur cette page
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.9,
        ),
        itemCount: allCategories.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                ),
                child: Icon(allCategories[index]['icon'], color: allCategories[index]['color'], size: 30),
              ),
              const SizedBox(height: 10),
              Text(
                allCategories[index]['name'],
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}