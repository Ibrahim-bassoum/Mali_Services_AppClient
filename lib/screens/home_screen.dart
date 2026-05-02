import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/auth_screen.dart'; // Vérifie que le dossier s'appelle bien services

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color maliServicesGreen = Color(0xFF10B981);
  static const Color bgColor = Color(0xFFF8F9FA);
  
  String userName = "Client";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? "Client";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(),
              
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 15),
                child: Text("Catégories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              _buildCategories(),

              _buildStatusCard(),

              const Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 15),
                child: Text("Artisans à proximité", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              _buildArtisanCards(),
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: maliServicesGreen,
        label: const Text("Trouver un artisan", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        icon: const Icon(LucideIcons.search, color: Colors.white, size: 20),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: maliServicesGreen,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) async {
          if (index == 3) { // Profil / Déconnexion
            await AuthService.logout();
            if (mounted) Navigator.pushReplacementNamed(context, '/welcome');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(LucideIcons.compass), label: "Explorer"),
          BottomNavigationBarItem(icon: Icon(LucideIcons.clipboardList), label: "Demandes"),
          BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: "Profil"),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bonjour, $userName 👋", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const Row(
                children: [
                  Icon(LucideIcons.mapPin, color: maliServicesGreen, size: 16),
                  Text(" Bamako, Mali", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          const CircleAvatar(
            radius: 25, 
            backgroundColor: Colors.white, 
            child: Icon(LucideIcons.bell, color: Colors.black, size: 20)
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: const TextField(
          decoration: InputDecoration(
            icon: Icon(LucideIcons.search, color: maliServicesGreen, size: 20),
            hintText: "Que cherchez-vous ?",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        children: [
          _catItem("Plomberie", LucideIcons.droplets),
          _catItem("Électricité", LucideIcons.zap),
          _catItem("Couture", LucideIcons.scissors),
          _catItem("Maçonnerie", LucideIcons.hammer),
        ],
      ),
    );
  }

  Widget _catItem(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
            ),
            child: Icon(icon, color: maliServicesGreen, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: maliServicesGreen.withOpacity(0.1), 
          borderRadius: BorderRadius.circular(15)
        ),
        child: const Row(
          children: [
            Icon(LucideIcons.info, color: maliServicesGreen, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text("Prêt pour un nouveau service ?", 
                style: TextStyle(color: maliServicesGreen, fontWeight: FontWeight.bold))
            ),
            Icon(LucideIcons.chevronRight, size: 18, color: maliServicesGreen),
          ],
        ),
      ),
    );
  }

  Widget _buildArtisanCards() {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 30, 
                  backgroundColor: bgColor, 
                  child: Icon(LucideIcons.user, color: Colors.grey)
                ),
                SizedBox(height: 10),
                Text("Artisan Pro", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.star, color: Colors.amber, size: 12),
                    Text(" 4.9 • 2km", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}