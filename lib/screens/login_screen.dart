import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/auth_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color maliServicesGreen = Color(0xFF10B981);
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    if (_phoneController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await AuthService.login(
      _phoneController.text, 
      _passwordController.text
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Numéro ou mot de passe incorrect")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black), 
          onPressed: () => Navigator.pop(context)
        )
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 10),
            
            // --- AJOUT DU LOGO ---
            Image.asset(
              'assets/logo.png',
              height: 150, // Taille ajustée pour laisser de la place au clavier
              fit: BoxFit.contain,
            ),
            
            const SizedBox(height: 20),

            // --- TEXTES AJUSTÉS ---
            Text(
              "Bon retour !", 
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 28, 
                fontWeight: FontWeight.bold, 
                color: const Color(0xFF111827)
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Connectez-vous pour demander un service expert au Mali.", 
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF6B7280)
              ),
            ),
            
            const SizedBox(height: 40),

            // CHAMP TÉLÉPHONE
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Numéro de téléphone",
                prefixIcon: const Icon(Icons.phone_android_outlined, color: maliServicesGreen),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), 
                  borderSide: const BorderSide(color: maliServicesGreen, width: 2)
                ),
              ),
            ),
            const SizedBox(height: 20),

            // CHAMP MOT DE PASSE
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                prefixIcon: const Icon(Icons.lock_outline, color: maliServicesGreen),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey), 
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible)
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), 
                  borderSide: const BorderSide(color: maliServicesGreen, width: 2)
                ),
              ),
            ),
            
            const SizedBox(height: 40),

            // BOUTON DE CONNEXION
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: maliServicesGreen, 
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "SE CONNECTER", 
                      style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
                    ),
              ),
            ),

            const SizedBox(height: 25),
            
            // LIEN VERS L'INSCRIPTION
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: RichText(
                text: TextSpan(
                  text: "Pas encore de compte ? ",
                  style: GoogleFonts.poppins(color: const Color(0xFF6B7280)),
                  children: [
                    TextSpan(
                      text: "S'inscrire",
                      style: GoogleFonts.poppins(color: maliServicesGreen, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}