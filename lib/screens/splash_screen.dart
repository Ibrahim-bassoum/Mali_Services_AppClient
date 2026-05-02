import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_mali_services_client/main_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  /// Logique de navigation : Attend 4s et vérifie la connexion
  Future<void> _handleNavigation() async {
    // 1. On attend 4 secondes pour l'effet visuel
    await Future.delayed(const Duration(seconds: 4));

    // 2. On vérifie si un token existe en mémoire
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token'); 

    if (!mounted) return;

    // 3. Direction la bonne page
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/MainNavigator');
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                /// LOGO (icone_app.png)
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF08B64B).withValues(alpha: 0.15),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      "assets/icone_app.png",
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// TITRE MALI SERVICES
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Mali",
                        style: TextStyle(
                          color: Color(0xFF071B44),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: "Services",
                        style: TextStyle(
                          color: Color(0xFF08B64B),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// ETIQUETTE CLIENT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 50, height: 2, color: const Color(0xFF08B64B)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "CLIENT",
                        style: TextStyle(
                          color: Color(0xFF08B64B),
                          fontSize: 20,
                          letterSpacing: 4,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Container(width: 50, height: 2, color: const Color(0xFF08B64B)),
                  ],
                ),

                const SizedBox(height: 40),

                /// SLOGAN
                const Text(
                  "Trouvez les meilleurs artisans\nen quelques clics.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Color(0xFF071B44),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 60),

                /// CHARGEMENT
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation(Color(0xFF08B64B)),
                    backgroundColor: Color(0xFFD7F5E2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}