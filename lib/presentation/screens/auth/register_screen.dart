import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/styles.dart';
import '../../state/auth/register_form_state.dart';
import '../../state/auth/register_provider.dart';
import '../../state/auth/register_state.dart';

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
    // No necesitamos inicializar controladores - Riverpod los maneja
  }

  @override
  void dispose() {
    // No necesitamos disponer controladores - Riverpod los maneja
    super.dispose();
  }

  void _togglePasswordVisibility() {
    ref.read(registerFormProvider.notifier).togglePasswordVisibility();
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
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    // Observamos los estados que necesitamos
    final formState = ref.watch(registerFormProvider);
    final registerState = ref.watch(registerStateProvider);

    // Establecemos el listener dentro del build (correcto según Riverpod)
    ref.listen<RegisterState>(
      registerStateProvider,
      (previous, current) => _handleRegisterStateChange(context, current),
    );

    // Extraemos las variables del estado del formulario para usarlas en la UI
    final _nameController = formState.nameController;
    final _emailController = formState.emailController;
    final _passwordController = formState.passwordController;
    final _isPasswordVisible = formState.isPasswordVisible;
    final _selectedSeason = formState.selectedSeason;
    final _seasons = ['Primavera', 'Verano', 'Otoño', 'Invierno'];

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
                  // Logo y título
                  Center(
                    child: Image.asset('assets/images/logo.png', height: 100),
                  ),
                  const SizedBox(height: TravelStyles.spaceL),
                  Text(
                    'Crear una cuenta',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: TravelColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TravelStyles.spaceM),
                  Text(
                    'Por favor completa tus datos para comenzar tu aventura',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TravelStyles.spaceXL),

                  // Formulario
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Campo de nombre
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre completo',
                            hintText: 'Ingresa tu nombre',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'El nombre es requerido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: TravelStyles.spaceM),

                        // Campo de email
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Correo electrónico',
                            hintText: 'ejemplo@correo.com',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'El correo electrónico es requerido';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Ingresa un correo electrónico válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: TravelStyles.spaceM),

                        // Campo de contraseña
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            hintText: 'Mínimo 8 caracteres',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          obscureText: !_isPasswordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'La contraseña es requerida';
                            }
                            if (value.length < 8) {
                              return 'La contraseña debe tener al menos 8 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: TravelStyles.spaceM),

                        // Selector de estaciones del año
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4.0,
                                bottom: 8.0,
                              ),
                              child: Text(
                                'Estación del año favorita para viajar',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.8),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFDDDDDD),
                                  width: 1,
                                ),
                                borderRadius: TravelStyles.borderRadiusAllS,
                                color: Colors.white,
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: TravelStyles.spaceM,
                                    vertical: TravelStyles.spaceS,
                                  ),
                                  prefixIcon: Icon(Icons.wb_sunny_outlined),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                value: _selectedSeason,
                                isExpanded: true,
                                icon: const Padding(
                                  padding: EdgeInsets.only(
                                    right: TravelStyles.spaceXS,
                                  ),
                                  child: Icon(Icons.arrow_drop_down, size: 24),
                                ),
                                iconSize: 24,
                                elevation: 16,
                                alignment: Alignment.center,
                                style: theme.textTheme.bodyMedium,
                                dropdownColor: Colors.white,
                                borderRadius: TravelStyles.borderRadiusAllS,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    ref
                                        .read(registerFormProvider.notifier)
                                        .updateSelectedSeason(newValue);
                                  }
                                },
                                items:
                                    _seasons.map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      final IconData icon;
                                      switch (value) {
                                        case 'Primavera':
                                          icon = Icons.local_florist;
                                          break;
                                        case 'Verano':
                                          icon = Icons.wb_sunny;
                                          break;
                                        case 'Otoño':
                                          icon = Icons.eco;
                                          break;
                                        case 'Invierno':
                                          icon = Icons.ac_unit;
                                          break;
                                        default:
                                          icon = Icons.calendar_today;
                                      }

                                      return DropdownMenuItem<String>(
                                        value: value,
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              icon,
                                              size: 18,
                                              color: _getSeasonColor(value),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                value,
                                                style:
                                                    theme.textTheme.bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: TravelStyles.spaceL),

                        // Botón de registro
                        if (registerState is RegisterLoading)
                          // Mostrar indicador de carga durante el registro
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(TravelStyles.spaceM),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Usamos el proveedor para iniciar el registro
                                ref
                                    .read(registerStateProvider.notifier)
                                    .register(
                                      name: _nameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text,
                                      preferredSeason: _selectedSeason,
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text('REGISTRARME'),
                          ),

                        // Mostrar mensaje de error si falla el registro
                        if (registerState is RegisterError)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: TravelStyles.spaceM,
                            ),
                            child: Text(
                              registerState.message,
                              style: TextStyle(
                                color: theme.colorScheme.error,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        // Mostrar mensaje de éxito si el registro es exitoso
                        if (registerState is RegisterSuccess)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: TravelStyles.spaceM,
                            ),
                            child: Text(
                              '¡Registro exitoso! Bienvenido, ${registerState.user.name}',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        const SizedBox(height: TravelStyles.spaceM),

                        // Términos y condiciones
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: theme.textTheme.bodySmall,
                            children: [
                              const TextSpan(
                                text: 'Al registrarte, aceptas nuestros ',
                              ),
                              TextSpan(
                                text: 'Términos y Condiciones',
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                // Aquí agregaríamos la navegación a los términos
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: TravelStyles.spaceXL),

                        // Enlace a inicio de sesión
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '¿Ya tienes una cuenta?',
                              style: theme.textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Navegar a login si no estamos ahí
                              },
                              child: const Text('Iniciar sesión'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Método para obtener el color según la estación
  Color _getSeasonColor(String season) {
    switch (season) {
      case 'Primavera':
        return Colors.pink.shade300; // Rosa floreciente para primavera
      case 'Verano':
        return Colors.amber.shade600; // Amarillo cálido para verano
      case 'Otoño':
        return Colors.orange.shade700; // Naranja para otoño
      case 'Invierno':
        return Colors.lightBlue.shade300; // Azul claro para invierno
      default:
        return TravelColors.primary;
    }
  }
}
