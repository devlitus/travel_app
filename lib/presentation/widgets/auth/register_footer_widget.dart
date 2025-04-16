import 'package:flutter/material.dart';
import '../../../app/theme/styles.dart';

/// Pie de página para la pantalla de registro
///
/// Contiene los términos y condiciones y el enlace para navegar
/// a la pantalla de inicio de sesión.
class RegisterFooterWidget extends StatelessWidget {
  /// Ruta de navegación a la pantalla de login
  final String loginRoute;

  const RegisterFooterWidget({super.key, this.loginRoute = '/login'});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Términos y condiciones
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: theme.textTheme.bodySmall,
            children: [
              const TextSpan(text: 'Al registrarte, aceptas nuestros '),
              TextSpan(
                text: 'Términos y Condiciones',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                // Aquí agregaríamos la navegación a los términos (futuro GestureDetector)
              ),
            ],
          ),
        ),
        const SizedBox(height: TravelStyles.spaceXL),

        // Enlace a inicio de sesión
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿Ya tienes una cuenta?', style: theme.textTheme.bodyMedium),
            TextButton(
              onPressed: () {
                // Navegar a la pantalla de login
                Navigator.pushReplacementNamed(context, loginRoute);
              },
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ],
    );
  }
}
