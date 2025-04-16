import 'package:flutter/material.dart';
import 'package:travel/presentation/screens/home/home_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/splash/splash_screen.dart';

/// Clase para manejar las rutas de la aplicación
class AppRoutes {
  /// Rutas nombradas
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';

  /// Ruta inicial de la aplicación
  static const String initialRoute = splash;

  /// Mapa de rutas de la aplicación
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
    // Agregar más rutas aquí a medida que se desarrollen más pantallas
  };

  /// Manejador para rutas no definidas
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder:
          (context) => Scaffold(
            body: Center(
              child: Text('No se encontró la ruta: ${settings.name}'),
            ),
          ),
    );
  }
}
