import 'package:flutter/material.dart';
import '../../common/input_field_widget.dart';
import '../../common/gradient_button_widget.dart';

/// Formulario para el inicio de sesión
///
/// Widget que implementa todos los campos y comportamiento necesarios
/// para realizar el proceso de login.
class LoginFormWidget extends StatefulWidget {
  /// Función que se ejecuta cuando el usuario intenta iniciar sesión
  final Future<void> Function(String email, String password)? onLogin;

  /// Constructor para el widget del formulario de login
  const LoginFormWidget({super.key, this.onLogin});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Manejo del proceso de inicio de sesión
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Verificar si se proporcionó una función de login personalizada
        if (widget.onLogin != null) {
          await widget.onLogin!(
            _emailController.text.trim(),
            _passwordController.text,
          );
        } else {
          // Si no se proporcionó, usar un delay simulado
          await Future.delayed(const Duration(seconds: 2));
        }
      } catch (e) {
        // Mostrar error si ocurre alguna excepción
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      } finally {
        // Asegurarse de quitar el indicador de carga
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Iniciar sesión',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Campo de correo electrónico
          InputFieldWidget(
            controller: _emailController,
            label: 'Correo electrónico',
            hint: 'ejemplo@correo.com',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu correo electrónico';
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'Por favor ingresa un correo electrónico válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Campo de contraseña
          InputFieldWidget(
            controller: _passwordController,
            label: 'Contraseña',
            hint: '********',
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: theme.colorScheme.primary.withOpacity(0.7),
                size: 22,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),

          // Opción "Olvidé mi contraseña"
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Navegar a la pantalla de recuperación de contraseña
              },
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Botón de inicio de sesión
          GradientButtonWidget(
            text: 'Iniciar Sesión',
            isLoading: _isLoading,
            onPressed: _handleLogin,
            height: 56,
            borderRadius: 16,
          ),
        ],
      ),
    );
  }
}
