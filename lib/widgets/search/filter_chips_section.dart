import 'package:flutter/material.dart';

class FilterChipsSection extends StatefulWidget {
  const FilterChipsSection({super.key});

  @override
  State<FilterChipsSection> createState() => _FilterChipsSectionState();
}

class _FilterChipsSectionState extends State<FilterChipsSection> {
  // On garde en mémoire quel filtre est sélectionné
  int selectedIndex = 0;

  final List<Map<String, dynamic>> filters = [
    {'label': 'Proche de moi', 'icon': Icons.location_on_outlined},
    {'label': 'Bien notés', 'icon': Icons.star_border},
    {'label': 'Disponibles', 'icon': Icons.circle_outlined},
    {'label': 'Prix', 'icon': Icons.sell_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Filtres rapides",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF071B44)),
          ),
        ),
        SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemCount: filters.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => setState(() => selectedIndex = index),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF08B64B) : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : Colors.grey.shade300,
                    ),
                    boxShadow: isSelected 
                      ? [BoxShadow(color: const Color(0xFF08B64B).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]
                      : [],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        filters[index]['icon'],
                        size: 18,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        filters[index]['label'],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}