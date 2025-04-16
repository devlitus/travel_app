import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../app/theme/styles.dart';
// import '../../../core/utils/validators.dart';

/// Pantalla de registro de usuario.
///
/// Permite a los nuevos usuarios crear una cuenta proporcionando
/// su nombre, correo electrónico y contraseña.
class RegisterScreen extends StatefulWidget {
  /// Ruta para navegar a esta pantalla
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Lista de estaciones y la estación seleccionada
  final List<String> _seasons = ['Primavera', 'Verano', 'Otoño', 'Invierno'];
  String _selectedSeason = 'Primavera'; // Valor por defecto

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

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
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.8,
                                  ),
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
                                    vertical:
                                        TravelStyles
                                            .spaceS, // Ajustado para centrar mejor
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
                                  setState(() {
                                    _selectedSeason = newValue!;
                                  });
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
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Aquí iría la lógica de registro
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Procesando datos...'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('REGISTRARME'),
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
