import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/styles.dart';
import '../../common/text_form_field_widget.dart';
import '../../common/submit_button_widget.dart';
import '../../common/custom_dropdown_widget.dart';
import '../../state/auth/register_form_state.dart';
import '../../state/auth/register_provider.dart';
import '../../state/auth/register_state.dart';
import 'season_dropdown_item_widget.dart';

/// Formulario de registro de usuario
///
/// Contiene todos los campos necesarios para registrar un nuevo usuario,
/// incluyendo nombre, correo, contraseña y preferencias.
class RegisterFormWidget extends ConsumerWidget {
  /// Clave del formulario para validación
  final GlobalKey<FormState> formKey;

  const RegisterFormWidget({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observamos los estados que necesitamos
    final formState = ref.watch(registerFormProvider);
    final registerState = ref.watch(registerStateProvider);

    // Extraemos las variables del estado del formulario para usarlas en la UI
    final nameController = formState.nameController;
    final emailController = formState.emailController;
    final passwordController = formState.passwordController;
    final isPasswordVisible = formState.isPasswordVisible;
    final selectedSeason = formState.selectedSeason;
    final seasons = ['Primavera', 'Verano', 'Otoño', 'Invierno'];

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Campo de nombre
          TextFormFieldWidget(
            controller: nameController,
            labelText: 'Nombre completo',
            hintText: 'Ingresa tu nombre',
            prefixIcon: Icons.person_outline,
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
          TextFormFieldWidget(
            controller: emailController,
            labelText: 'Correo electrónico',
            hintText: 'ejemplo@correo.com',
            prefixIcon: Icons.email_outlined,
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
          TextFormFieldWidget(
            controller: passwordController,
            labelText: 'Contraseña',
            hintText: 'Mínimo 8 caracteres',
            prefixIcon: Icons.lock_outline,
            obscureText: !isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed:
                  () =>
                      ref
                          .read(registerFormProvider.notifier)
                          .togglePasswordVisibility(),
            ),
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
          CustomDropdownWidget<String>(
            labelText: 'Estación del año favorita para viajar',
            prefixIcon: Icons.wb_sunny_outlined,
            value: selectedSeason,
            items: seasons,
            onChanged: (String? newValue) {
              if (newValue != null) {
                ref
                    .read(registerFormProvider.notifier)
                    .updateSelectedSeason(newValue);
              }
            },
            itemBuilder:
                (String value) => SeasonDropdownItemWidget(season: value),
          ),
          const SizedBox(height: TravelStyles.spaceL),

          // Botón de registro
          SubmitButtonWidget(
            text: 'REGISTRARME',
            isLoading: registerState is RegisterLoading,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // Usamos el proveedor para iniciar el registro
                ref
                    .read(registerStateProvider.notifier)
                    .register(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text,
                      preferredSeason: selectedSeason,
                    );
              }
            },
          ),

          // Mostrar mensaje de error si falla el registro
          if (registerState is RegisterError)
            Padding(
              padding: const EdgeInsets.only(top: TravelStyles.spaceM),
              child: Text(
                registerState.message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // Mostrar mensaje de éxito si el registro es exitoso
          if (registerState is RegisterSuccess)
            Padding(
              padding: const EdgeInsets.only(top: TravelStyles.spaceM),
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
        ],
      ),
    );
  }
}
