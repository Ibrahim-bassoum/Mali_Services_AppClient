import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
// Importe tes autres écrans ici quand ils seront créés
// import 'screens/search_screen.dart';
// import 'screens/messages_screen.dart';
// import 'screens/profile_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  // Liste des pages correspondantes aux icônes du bas
  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text("Page Recherche")), // Remplacer par SearchScreen()
    const Center(child: Text("Page Messages")),  // Remplacer par MessagesScreen()
    const Center(child: Text("Page Profil")),    // Remplacer par ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      // Ton bouton central "+" pour une action rapide (ex: poster une annonce)
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF08B64B),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, "Accueil", 0),
            _buildNavItem(Icons.search, "Explorer", 1),
            const SizedBox(width: 40), // Espace pour le bouton +
            _buildNavItem(Icons.assignment, "Missions", 2),
            _buildNavItem(Icons.person, "Profil", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF08B64B) : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF08B64B) : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}