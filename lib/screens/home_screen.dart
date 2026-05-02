import 'package:flutter/material.dart';
// Import du premier widget que nous avons créé
import '../widgets/home/home_header.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB), 
      body: const SafeArea(
        child: CustomScrollView(
          slivers: [
            
            // ==========================================
            // WIDGET 1 : HEADER (Déjà codé)
            // ==========================================
            SliverToBoxAdapter(
              child: HomeHeader(),
            ),

            // ==========================================
            // PROCHAIN WIDGET : BARRE DE RECHERCHE
            // (À insérer ici : SearchBarSection)
            // ==========================================
            SliverToBoxAdapter(
              child: SizedBox(height: 10), // Espace temporaire
            ),

            // ==========================================
            // PROCHAIN WIDGET : BANNER PROMO
            // (À insérer ici : PromoBanner)
            // ==========================================
            SliverToBoxAdapter(
              child: SizedBox(height: 20), // Espace temporaire
            ),

            // ==========================================
            // PROCHAIN WIDGET : GRILLE DES CATÉGORIES
            // (À insérer ici : CategoryGrid)
            // ==========================================
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Catégories populaires",
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold, 
                    color: Color(0xFF071B44)
                  ),
                ),
              ),
            ),

            // ==========================================
            // PROCHAIN WIDGET : LISTE DES ARTISANS
            // (À insérer ici : ArtisanListSection)
            // ==========================================
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Professionnels proches",
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold, 
                    color: Color(0xFF071B44)
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
      
      // BOUTON CENTRAL "+"
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF08B64B),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // BARRE DE NAVIGATION
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home, color: Color(0xFF08B64B)), onPressed: () {}),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            const SizedBox(width: 40), // Espace pour le bouton FAB
            IconButton(icon: const Icon(Icons.assignment_outlined), onPressed: () {}),
            IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}