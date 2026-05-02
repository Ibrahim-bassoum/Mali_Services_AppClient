import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          // Photo de profil
          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFF08B64B),
            child: Icon(Icons.person, color: Colors.white), // Plus tard : Image.network de Laravel
          ),
          const SizedBox(width: 12),
          // Texte de bienvenue
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bonjour, Moussa 👋",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF071B44)),
              ),
              Row(
                children: [
                  Icon(Icons.location_on, size: 14, color: Color(0xFF08B64B)),
                  SizedBox(width: 4),
                  Text("Bamako, Mali", style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Boutons de notification et chat
          _buildCircleIcon(Icons.notifications_none_outlined, hasBadge: true),
          const SizedBox(width: 10),
          _buildCircleIcon(Icons.chat_bubble_outline, count: "3"),
        ],
      ),
    );
  }

  // Petit helper pour les icônes rondes avec badges
  Widget _buildCircleIcon(IconData icon, {bool hasBadge = false, String? count}) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(icon, size: 22, color: const Color(0xFF071B44)),
        ),
        if (hasBadge || count != null)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Color(0xFF08B64B), shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: count != null 
                ? Text(count, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                : null,
            ),
          ),
      ],
    );
  }
}