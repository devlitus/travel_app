import 'package:flutter/material.dart';
// import 'package:travel/presentation/screens/auth/login_screen.dart';
import 'package:travel/presentation/screens/auth/register_screen.dart';

import 'theme/theme.dart';

/// Widget principal de la aplicación de viajes.
class TravelApp extends StatelessWidget {
  /// Construye la aplicación principal con el tema definido
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      // Aplica el tema según la preferencia
      theme: TravelTheme.light(),
      darkTheme: TravelTheme.dark(),
      themeMode: ThemeMode.light, // Por defecto usamos tema claro
      // Aquí configuraremos las rutas más adelante
      home: RegisterScreen(), // Pantalla de inicio de sesión
    );
  }
}
