import 'package:flutter/material.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/itinerary/itinerary_generator_screen.dart';
import '../presentation/screens/itinerary/itinerary_details_screen.dart';

/// Clase para manejar las rutas de la aplicación
class AppRoutes {
  /// Rutas nombradas
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String destinationDescription = '/destination-description';
  static const String itineraryGenerator = '/itinerary-generator';
  static const String itineraryDetails = '/itinerary-details';

  /// Ruta inicial de la aplicación
  static const String initialRoute = splash;

  /// Mapa de rutas de la aplicación
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
    itineraryGenerator: (context) => const ItineraryGeneratorScreen(),
    itineraryDetails: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      return ItineraryDetailsScreen(
        destination: args['destination']!,
        itinerary: args['itinerary']!,
      );
    },
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
