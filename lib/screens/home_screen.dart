import 'package:flutter/material.dart';
import '../widgets/home/home_header.dart'; 
import '../widgets/home/search_bar_section.dart';
import '../widgets/home/promo_banner.dart';
import '../widgets/home/categories_grid.dart';
import '../widgets/home/artisan_list.dart';

// 1. AJOUTE CET IMPORT
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 2. INITIALISE TON SERVICE
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB), 
      // Retire le 'const' devant SafeArea car le contenu va devenir dynamique
      body: SafeArea( 
        child: CustomScrollView(
          slivers: [
            
            // ==========================================
            // WIDGET 1 : HEADER DYNAMIQUE
            // ==========================================
            SliverToBoxAdapter(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _apiService.getUserProfile(), // Appelle ta nouvelle fonction
             builder: (context, snapshot) {
      // 1. CAS DE SUCCÈS
                if (snapshot.hasData) {
                              // On définit 'user' ICI, à l'intérieur du bloc où on l'utilise
                        final user = snapshot.data as Map<String, dynamic>;
    
                            return HomeHeader(
                                    name: user['name'] ?? "Utilisateur", 
                               );
                   } 

                   // 2. CAS D'ERREUR
                else if (snapshot.hasError) {
                              return const HomeHeader(name: "Erreur API");
                   }

                           // 3. CAS DE CHARGEMENT
                         return const HomeHeader(name: "Chargement...");
              }
              ),
            ),

            // On garde le reste en 'const' pour l'instant
            const SliverToBoxAdapter(child: SearchSection()),
            
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            const SliverToBoxAdapter(child: PromoBanner()),
            
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            const SliverToBoxAdapter(child: CategoriesGrid()),
            
            const SliverToBoxAdapter(child: ArtisanListSection()),
          ],
        ),
      ),
    );
  }
}