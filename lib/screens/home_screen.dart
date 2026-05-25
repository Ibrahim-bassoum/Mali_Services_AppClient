import 'package:flutter/material.dart';
import '../widgets/home/artisan_list.dart'; 
import '../widgets/home/search_bar_section.dart';
import '../widgets/home/promo_banner.dart';
import '../widgets/home/categories_grid.dart';
import '../widgets/home/artisan_list.dart';
import '../widgets/home/home_header.dart';
import '../services/api_service.dart';

// CORRECTION DE L'IMPORT : Chemin vers lib/search/main_navigator.dart
// Note : Selon l'emplacement de ton home_screen, le chemin relatif peut varier.
// Si home_screen est dans lib/screens, le chemin est :
import '../widgets/home/main_navigator.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // INITIALISATION DU SERVICE API
  final ApiService _apiService = ApiService();

  // VARIABLE POUR GÉRER L'ÉTAT DE LA NAVIGATION
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB), 
      
      // LE CONTENU PRINCIPAL
      body: SafeArea( 
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            
            // HEADER DYNAMIQUE
            SliverToBoxAdapter(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _apiService.getUserProfile(), 
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data as Map<String, dynamic>;
                    return HomeHeader(
                      name: user['name'] ?? "Utilisateur", 
                    );
                  } 
                  else if (snapshot.hasError) {
                    return const HomeHeader(name: "Utilisateur");
                  }
                  return const HomeHeader(name: "Chargement...");
                }
              ),
            ),

            // BARRE DE RECHERCHE
            const SliverToBoxAdapter(child: SearchSection()),
            
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            // BANNIÈRE PROMO
            const SliverToBoxAdapter(child: PromoBanner()),
            
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // GRILLE DES CATÉGORIES
            const SliverToBoxAdapter(child: CategoriesGrid()),
            
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            // LISTE DES ARTISANS
            const SliverToBoxAdapter(child: ArtisanListSection()),
            
            // Espace pour ne pas que le contenu soit caché par la barre
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),

      // UTILISATION DU WIDGET DONT TU AS PARLÉ
      // Assure-toi que la classe dans main_navigator.dart s'appelle bien MainNavigator
      bottomNavigationBar: MainNavigator(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}