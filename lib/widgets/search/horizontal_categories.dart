import 'package:flutter/material.dart';

class HorizontalCategories extends StatelessWidget {
  const HorizontalCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // On reprend ta liste de la Home
    final List<Map<String, dynamic>> categories = [
      {'name': 'Électricité', 'icon': Icons.bolt, 'color': Colors.green},
      {'name': 'Plomberie', 'icon': Icons.water_drop, 'color': Colors.blue},
      {'name': 'Maçonnerie', 'icon': Icons.foundation, 'color': Colors.orange},
      {'name': 'Couture', 'icon': Icons.content_cut, 'color': Colors.purple},
      {'name': 'Mécanique', 'icon': Icons.build, 'color': Colors.red},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Catégories populaires", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF071B44))),
              TextButton(onPressed: () {}, child: const Text("Voir tout", style: TextStyle(color: Color(0xFF08B64B)))),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                width: 90,
                margin: const EdgeInsets.only(right: 15, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(categories[index]['icon'], color: categories[index]['color'], size: 30),
                    const SizedBox(height: 8),
                    Text(
                      categories[index]['name'],
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}