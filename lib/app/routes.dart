import 'package:flutter/material.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';

/// Clase para manejar las rutas de la aplicación
class AppRoutes {
  /// Ruta inicial de la aplicación
  static const String initialRoute = LoginScreen.routeName;

  /// Mapa de rutas de la aplicación
  static Map<String, WidgetBuilder> routes = {
    LoginScreen.routeName: (context) => const LoginScreen(),
    RegisterScreen.routeName: (context) => const RegisterScreen(),
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
