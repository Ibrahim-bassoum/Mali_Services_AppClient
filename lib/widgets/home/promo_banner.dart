import 'package:flutter/material.dart';
import 'dart:async';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Tes images JPG actuelles (vérifie bien les noms !)
  final List<String> _bannerImages = [
    "assets/image_banner/electrician.jpg",
    "assets/image_banner/macon.jpg",
    "assets/image_banner/menusier.jpg",
    "assets/image_banner/plombier.jpg",
    "assets/image_banner/soudeur.jpg",
  ];

  @override
  void initState() {
    super.initState();
    // Défilement automatique
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % _bannerImages.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000), // Défilement doux
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 250, // Hauteur pour éviter l'overflow
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        // On enlève le fond vert ici, c'est l'image qui fera le fond
      ),
      child: Stack(
        children: [
          // 1. LE FOND : L'IMAGE QUI PREND TOUT L'ESPACE
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: PageView.builder(
              controller: _pageController,
              itemCount: _bannerImages.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                return Image.asset(
                  _bannerImages[index],
                  fit: BoxFit.cover, // Remplit tout le rectangle
                  // width/height ne sont plus nécessaires ici, BoxFit.cover s'en charge
                );
              },
            ),
          ),

          // 2. LE VOILE SOMBRE (Gradient) pour la lisibilité
          // C'est crucial : ça noircit un peu l'image derrière le texte
          // pour que le texte blanc reste lisible
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.8), // Noir opaque à gauche
                    Colors.black.withOpacity(0.5), // Un peu moins opaque
                    Colors.black.withOpacity(0.1), // Presque transparent à droite
                  ],
                ),
              ),
            ),
          ),

          // 3. LE CONTENU (Texte, Coches, Bouton)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Trouvez un professionnel\nfiable et proche de vous",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19, // Un peu plus grand
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Les coches de réassurance
                _buildCheckItem("Artisans qualifiés"),
                _buildCheckItem("Disponibles rapidement"),
                _buildCheckItem("Paiement sécurisé"),
                
                const SizedBox(height: 20),
                
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF08B64B), // Vert MaliServices
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: const Text(
                    "Trouver maintenant →",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),

          // 4. LES INDICATEURS DE PAGE
          Positioned(
            bottom: 15,
            right: 20, // Placés à droite pour ne pas gêner
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _bannerImages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 6,
                  width: _currentPage == index ? 20 : 6,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? const Color(0xFF08B64B) : Colors.white70,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          // Coche verte plus visible
          const Icon(Icons.check_circle, color: Color(0xFF08B64B), size: 16),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}