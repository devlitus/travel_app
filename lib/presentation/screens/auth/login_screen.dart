import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../common/card_container_widget.dart';
import '../../common/spacing.dart';
import '../../widgets/auth/login_header_widget.dart';
import '../../widgets/auth/login_footer_widget.dart';
import '../../widgets/auth/login_form_widget.dart';
import '../../../presentation/state/auth/auth_provider.dart'; // Asumiendo que este es tu provider

/// Pantalla de login para la aplicación de viajes
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Observar el estado de autenticación
    final authState = ref.watch(authNotifierProvider);

    // Configurar la barra de estado para una mejor integración visual
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Reaccionar a cambios en el estado
    if (authState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (authState.isAuthenticated) {
      // Navegar a la pantalla principal después de autenticar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primaryContainer,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.l,
                      vertical: Spacing.l,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Header Section
                        const LoginHeaderWidget(),

                        // Login Form Section
                        CardContainerWidget(
                          padding: const EdgeInsets.all(Spacing.l),
                          child: LoginFormWidget(
                            onLogin: (email, password) {
                              // Obtener el controlador de autenticación
                              final authNotifier = ref.read(
                                authNotifierProvider.notifier,
                              );
                              // Iniciar el proceso de login
                              authNotifier.login(email, password);
                            },
                          ),
                        ),

                        // Footer Section with Register Option
                        const LoginFooterWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
