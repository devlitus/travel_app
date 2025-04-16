import 'package:flutter/material.dart';
import '../../common/spacing.dart';

/// Widget para el footer de la pantalla de login que incluye
/// la opción para registrarse
class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Contenedor para las opciones sociales (se puede implementar después)
        // const SocialLoginOptions(),
        Spacing.height(Spacing.xl),

        // Opción para crear cuenta nueva
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿No tienes una cuenta?',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                'Regístrate',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
