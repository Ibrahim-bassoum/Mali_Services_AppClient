import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Utilisation de la couleur cohérente avec le reste de l'app
  static const Color maliServicesGreen = Color(0xFF10B981); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ton Logo
              Image.asset(
                'assets/logo.png',
                height: 250, 
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              
              Text(
                "Le service expert\nà portée de main",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 15),
              
              Text(
                "Trouvez les meilleurs artisans du Mali\npour tous vos travaux et dépannages.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15, 
                  color: const Color(0xFF6B7280), 
                  height: 1.5
                ),
              ),
              const SizedBox(height: 60),

              // BOUTON SE CONNECTER (via Route)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maliServicesGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    "SE CONNECTER", 
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // BOUTON CRÉER UN COMPTE (via Route)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: maliServicesGreen, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    "CRÉER UN COMPTE", 
                    style: GoogleFonts.poppins(color: maliServicesGreen, fontWeight: FontWeight.w600)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}