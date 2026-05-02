import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/auth_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Les contrôleurs pour récupérer ce que l'utilisateur tape
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  void _handleRegister() async {
    // Validation rapide
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    setState(() => _isLoading = true);

    // APPEL API : On envoie 'client' comme rôle par défaut
    final result = await AuthService.register(
      name: _nameController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      role: 'client', 
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result != null) {
      // Si l'inscription marche, on va à l'accueil
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de l'inscription. Vérifiez vos infos.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0, 
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text("Créer un compte", 
              style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF111827))
            ),
            const SizedBox(height: 10),
            Text("Rejoignez MaliServices pour trouver les meilleurs artisans.", 
              style: GoogleFonts.poppins(color: Colors.grey)
            ),
            const SizedBox(height: 40),

            // NOM
            _buildTextField(
              controller: _nameController,
              label: "Nom complet",
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 20),

            // TÉLÉPHONE
            _buildTextField(
              controller: _phoneController,
              label: "Numéro de téléphone",
              icon: Icons.phone_android_outlined,
              isPhone: true,
            ),
            const SizedBox(height: 20),

            // MOT DE PASSE
            _buildTextField(
              controller: _passwordController,
              label: "Mot de passe",
              icon: Icons.lock_outline,
              isPassword: true,
            ),

            const SizedBox(height: 40),

            // BOUTON S'INSCRIRE
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white,
                    strokeWidth: 2,)
                  : Text("S'INSCRIRE", 
                      style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
                    ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget réutilisable pour les champs de texte
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool isPhone = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF10B981)),
        suffixIcon: isPassword 
          ? IconButton(
              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            )
          : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF10B981), width: 2),
        ),
      ),
    );
  }
}