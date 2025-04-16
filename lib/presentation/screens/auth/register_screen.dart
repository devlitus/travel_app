import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/auth/register_state.dart';
import '../../state/auth/register_provider.dart';
import '../../widgets/auth/register_header_widget.dart';
import '../../widgets/auth/register_form_widget.dart';
import '../../widgets/auth/register_footer_widget.dart';
import '../../../app/theme/styles.dart';

/// Pantalla de registro de usuario.
///
/// Permite a los nuevos usuarios crear una cuenta proporcionando
/// su nombre, correo electrónico y contraseña.
class RegisterScreen extends ConsumerStatefulWidget {
  /// Ruta para navegar a esta pantalla
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  // Esta función manejará los mensajes según el estado
  void _handleRegisterStateChange(BuildContext context, RegisterState state) {
    if (state is RegisterSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Registro completado con éxito!'),
          backgroundColor: Colors.green,
        ),
      );
      // Aquí podrías navegar a la siguiente pantalla
      // Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else if (state is RegisterError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${state.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Establecemos el listener para manejar cambios en el estado de registro
    ref.listen<RegisterState>(
      registerStateProvider,
      (previous, current) => _handleRegisterStateChange(context, current),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: TravelStyles.paddingM,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Encabezado con logo y título
                  const RegisterHeaderWidget(),

                  // Formulario de registro
                  RegisterFormWidget(formKey: _formKey),

                  // Espaciado
                  const SizedBox(height: TravelStyles.spaceM),

                  // Pie de página con términos y enlace a login
                  const RegisterFooterWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
