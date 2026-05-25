import 'package:app_mali_services_client/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'package:app_mali_services_client/screens/splash_screen.dart';
import 'package:app_mali_services_client/widgets/home/main_navigator.dart';

void main() async {
  // Indispensable pour initialiser les SharedPreferences avant le lancement de l'UI
  WidgetsFlutterBinding.ensureInitialized();
  
  // On vérifie si un token est déjà présent dans le téléphone
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('auth_token');

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaliServices',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // On utilise ta couleur verte exacte pour tout le thème
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF10B981)),
        useMaterial3: true,
      ),
      // Si l'utilisateur est déjà connecté, il arrive sur Home, sinon Welcome
      home:  const SplashScreen(), 
      
      // Routes pour naviguer facilement entre tes écrans
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/MainNavigator':(context) =>  MainNavigator(currentIndex: 0, onTap: (index){},),
      },
    ); 
    
  }
}