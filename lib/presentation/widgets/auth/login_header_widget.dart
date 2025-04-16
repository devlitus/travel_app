import 'package:flutter/material.dart';

/// Sección superior con logo y mensaje de bienvenida para la pantalla de login
///
/// Muestra el logo de la aplicación con una animación de escala y un mensaje
/// de bienvenida con animación de opacidad.
class LoginHeaderWidget extends StatelessWidget {
  /// Constructor para el widget de cabecera de login
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 24),
        // Logo con sutil animación de escala
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.8, end: 1.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.scale(scale: value, child: child);
          },
          child: Hero(
            tag: 'app_logo',
            child: Image.asset('assets/images/logo.png', height: 100),
          ),
        ),
        const SizedBox(height: 24),
        // Mensaje de bienvenida con animación de opacidad
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(opacity: value, child: child);
          },
          child: Column(
            children: [
              Text(
                '¡Bienvenido!',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Inicia sesión para descubrir tu próxima aventura',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
