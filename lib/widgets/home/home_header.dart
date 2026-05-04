import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String name; // La variable qui reçoit le nom de Laravel

  const HomeHeader({
    super.key, 
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          // 1. Photo de profil
          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFF08B64B),
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),

          // 2. Texte de bienvenue (CORRIGÉ AVEC EXPANDED)
          Expanded( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Bonjour, $name 👋",
                  style: const TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold, 
                    color: Color(0xFF071B44)
                  ),
                  overflow: TextOverflow.ellipsis, // Coupe le texte avec "..." si trop long
                  maxLines: 1,
                ),
                const Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Color(0xFF08B64B)),
                    SizedBox(width: 4),
                    Text("Bamako, Mali", style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10), // Espace de sécurité

          // 3. Boutons d'action
          _buildCircleIcon(Icons.notifications_none_outlined, hasBadge: true),
          const SizedBox(width: 10),
          _buildCircleIcon(Icons.chat_bubble_outline, count: "3"),
        ],
      ),
    );
  }

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