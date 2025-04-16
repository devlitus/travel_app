import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../common/card_container_widget.dart';
import '../../common/spacing.dart';
import '../../widgets/auth/login_header_widget.dart';
import '../../widgets/auth/login_footer_widget.dart';
import '../../widgets/auth/login_form_widget.dart';

/// Pantalla de login para la aplicación de viajes
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Configurar la barra de estado para una mejor integración visual
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

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
                            onLogin: (email, password) async {
                              // Aquí iría la implementación real de login
                              await Future.delayed(const Duration(seconds: 2));

                              // Simulación de login exitoso
                              if (context.mounted) {
                                // Navegar a la pantalla principal después de login
                                // Navigator.pushReplacementNamed(context, '/home');
                              }
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
