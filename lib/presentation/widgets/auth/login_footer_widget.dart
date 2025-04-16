import 'package:flutter/material.dart';
import '../../common/spacing.dart';

/// Widget para el footer de la pantalla de login que incluye
/// la opción para registrarse con un diseño minimalista
class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.m),
      child: Column(
        children: [
          // Línea divisoria sutil para separación visual
          Divider(
            color: theme.colorScheme.onSurface.withOpacity(0.1),
            thickness: 1,
            indent: 40,
            endIndent: 40,
          ),

          Spacing.height(Spacing.m),

          // Opción para crear cuenta con diseño minimalista
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/register');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Spacing.m,
                horizontal: Spacing.xl,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '¿No tienes una cuenta? Regístrate',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
