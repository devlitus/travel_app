import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes.dart';
import 'theme/theme.dart';

/// Widget principal de la aplicación de viajes.
class TravelApp extends StatelessWidget {
  /// Construye la aplicación principal con el tema definido
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Travel App',
        debugShowCheckedModeBanner: false,
        // Aplica el tema según la preferencia
        theme: TravelTheme.light(),
        darkTheme: TravelTheme.dark(),
        themeMode: ThemeMode.light, // Por defecto usamos tema claro
        // Configuración de rutas
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
