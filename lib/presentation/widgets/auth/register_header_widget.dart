import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/styles.dart';

/// Encabezado para la pantalla de registro
///
/// Muestra el logo de la aplicación, el título y un mensaje introductorio
/// para la pantalla de registro.
class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Logo
        Center(child: Image.asset('assets/images/logo.png', height: 100)),
        const SizedBox(height: TravelStyles.spaceL),

        // Título
        Text(
          'Crear una cuenta',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: TravelColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: TravelStyles.spaceM),

        // Subtítulo
        Text(
          'Por favor completa tus datos para comenzar tu aventura',
          style: theme.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: TravelStyles.spaceXL),
      ],
    );
  }
}
