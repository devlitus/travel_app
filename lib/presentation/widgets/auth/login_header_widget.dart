import 'package:flutter/material.dart';
import '../../common/spacing.dart';

/// Widget que muestra el encabezado de la pantalla de login
class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Center(
          child: Image.asset('assets/images/logo.png', height: 80, width: 80),
        ),
        Spacing.height(Spacing.m),

        // Título de bienvenida
        Text(
          '¡Bienvenido!',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacing.height(Spacing.s),

        // Subtítulo
        Text(
          'Inicia sesión para descubrir destinos increíbles',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}
