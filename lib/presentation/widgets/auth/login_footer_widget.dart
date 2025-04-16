import 'package:flutter/material.dart';

/// Sección inferior con opción de registro para la pantalla de login
///
/// Muestra un contenedor con gradiente que contiene una pregunta y un botón
/// para navegar a la pantalla de registro.
class LoginFooterWidget extends StatelessWidget {
  /// Ruta de navegación hacia la pantalla de registro
  final String registerRoute;

  /// Constructor para el widget de pie de página de login
  const LoginFooterWidget({super.key, this.registerRoute = '/register'});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.secondary.withOpacity(0.7),
            theme.colorScheme.secondary,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: IntrinsicWidth(
        stepWidth: 280,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                '¿No tienes una cuenta?',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, registerRoute);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: theme.colorScheme.secondary,
                side: const BorderSide(color: Colors.white, width: 1.5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(0, 40),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Regístrate',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: theme.colorScheme.secondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
