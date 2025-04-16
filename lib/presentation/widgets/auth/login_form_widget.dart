import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/spacing.dart';
import '../../../presentation/state/auth/auth_provider.dart';

/// Widget que contiene el formulario de inicio de sesión
class LoginFormWidget extends ConsumerStatefulWidget {
  /// Callback que se ejecuta cuando el usuario intenta iniciar sesión
  final void Function(String email, String password) onLogin;

  const LoginFormWidget({super.key, required this.onLogin});

  @override
  ConsumerState<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends ConsumerState<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Método para alternar la visibilidad de la contraseña
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  // Método para validar el formulario y llamar al callback de login
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onLogin(_emailController.text.trim(), _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título del formulario
          Text(
            'Iniciar Sesión',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Spacing.height(Spacing.l),

          // Campo de email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Correo Electrónico',
              hintText: 'ejemplo@correo.com',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu correo electrónico';
              }
              if (!value.contains('@')) {
                return 'Correo electrónico inválido';
              }
              return null;
            },
          ),
          Spacing.height(Spacing.m),

          // Campo de contraseña
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              hintText: '********',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _togglePasswordVisibility,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
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
          Spacing.height(Spacing.s),

          // Enlace de recuperar contraseña
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Implementar navegación a recuperar contraseña
              },
              child: const Text('¿Olvidaste tu contraseña?'),
            ),
          ),
          Spacing.height(Spacing.s),

          // Mensaje de error en caso de fallo de autenticación
          if (authState.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: Spacing.s),
              child: Text(
                authState.error!,
                style: TextStyle(color: theme.colorScheme.error, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),

          // Botón de inicio de sesión
          ElevatedButton(
            onPressed: authState.isLoading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: Spacing.m),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child:
                authState.isLoading
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Text(
                      'INICIAR SESIÓN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
          ),
        ],
      ),
    );
  }
}
