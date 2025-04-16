import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'styles.dart';
import 'typography.dart';

/// Define el tema completo de la aplicación de viajes.
///
/// Combina colores, tipografía y estilos para crear una experiencia visual coherente.
class TravelTheme {
  /// Crea el tema claro para la aplicación.
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: TravelColors.primary,
        onPrimary: Colors.white,
        primaryContainer: TravelColors.primaryLight,
        onPrimaryContainer: Colors.white,
        secondary: TravelColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFFFE082),
        onSecondaryContainer: Color(0xFF3E2D00),
        tertiary: TravelColors.tertiary,
        onTertiary: Colors.white,
        tertiaryContainer: Color(0xFFA7F3D0),
        onTertiaryContainer: Color(0xFF002115),
        error: TravelColors.error,
        onError: Colors.white,
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
        surface: TravelColors.surface,
        onSurface: TravelColors.onSurface,
        outline: Color(0xFFA7A7A7),
        surfaceContainerHighest: Color(0xFFE7E0EC),
        onSurfaceVariant: Color(0xFF49454F),
        shadow: TravelColors.cardShadow,
      ),

      // Aplica la tipografía personalizada
      textTheme: TravelTypography.textTheme,

      // Estilos de AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: TravelColors.surface,
        elevation: TravelStyles.elevationS,
        centerTitle: true,
        iconTheme: const IconThemeData(color: TravelColors.primary),
        titleTextStyle: TravelTypography.textTheme.headlineSmall,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // Estilos de botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TravelColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(88, 48),
          padding: TravelStyles.paddingHorizontalM,
          elevation: TravelStyles.elevationS,
          shape: RoundedRectangleBorder(
            borderRadius: TravelStyles.borderRadiusAllM,
          ),
          textStyle: TravelTypography.textTheme.labelLarge,
        ),
      ),

      // Estilos de botones de texto
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: TravelColors.primary,
          minimumSize: const Size(88, 48),
          padding: TravelStyles.paddingHorizontalM,
          shape: RoundedRectangleBorder(
            borderRadius: TravelStyles.borderRadiusAllM,
          ),
          textStyle: TravelTypography.textTheme.labelLarge,
        ),
      ),

      // Estilos de botones outlined
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: TravelColors.primary,
          minimumSize: const Size(88, 48),
          padding: TravelStyles.paddingHorizontalM,
          side: const BorderSide(color: TravelColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: TravelStyles.borderRadiusAllM,
          ),
          textStyle: TravelTypography.textTheme.labelLarge,
        ),
      ),

      // Estilos de tarjetas
      cardTheme: CardTheme(
        color: TravelColors.surface,
        elevation: TravelStyles.elevationS,
        shape: RoundedRectangleBorder(
          borderRadius: TravelStyles.borderRadiusAllM,
        ),
        margin: TravelStyles.paddingS,
      ),

      // Estilos de inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: TravelStyles.paddingM,
        border: OutlineInputBorder(
          borderRadius: TravelStyles.borderRadiusAllS,
          borderSide: const BorderSide(color: Color(0xFFDDDDDD), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: TravelStyles.borderRadiusAllS,
          borderSide: const BorderSide(color: Color(0xFFDDDDDD), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: TravelStyles.borderRadiusAllS,
          borderSide: const BorderSide(color: TravelColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: TravelStyles.borderRadiusAllS,
          borderSide: const BorderSide(color: TravelColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: TravelStyles.borderRadiusAllS,
          borderSide: const BorderSide(color: TravelColors.error, width: 2),
        ),
        labelStyle: TravelTypography.textTheme.bodyMedium,
        hintStyle: TravelTypography.textTheme.bodyMedium?.copyWith(
          color: TravelColors.onSurface.withOpacity(TravelStyles.opacityHint),
        ),
        errorStyle: TravelTypography.textTheme.bodySmall?.copyWith(
          color: TravelColors.error,
        ),
      ),

      // Estilos de chips
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        disabledColor: Colors.grey[200],
        selectedColor: TravelColors.primary.withOpacity(0.15),
        secondarySelectedColor: TravelColors.primary,
        padding: TravelStyles.paddingHorizontalS,
        labelStyle: TravelTypography.textTheme.bodySmall,
        secondaryLabelStyle: TravelTypography.textTheme.bodySmall?.copyWith(
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: TravelStyles.borderRadiusAllCircular,
          side: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
      ),

      // Estilos del bottom navigation bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: TravelColors.primary,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 24),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Estilo de divider
      dividerTheme: const DividerThemeData(
        color: TravelColors.divider,
        space: 1,
        thickness: 1,
      ),

      // Configuraciones de animaciones
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// Crea el tema oscuro para la aplicación.
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: TravelColors.primaryLight,
        onPrimary: Colors.black,
        primaryContainer: TravelColors.primary.withOpacity(0.7),
        onPrimaryContainer: Colors.white,
        secondary: TravelColors.secondary.withOpacity(0.8),
        onSecondary: Colors.black,
        secondaryContainer: TravelColors.secondary.withOpacity(0.3),
        onSecondaryContainer: Colors.white,
        tertiary: TravelColors.tertiary.withOpacity(0.8),
        onTertiary: Colors.black,
        tertiaryContainer: TravelColors.tertiary.withOpacity(0.3),
        onTertiaryContainer: Colors.white,
        error: TravelColors.error.withOpacity(0.8),
        onError: Colors.black,
        errorContainer: TravelColors.error.withOpacity(0.3),
        onErrorContainer: Colors.white,
        surface: TravelColors.darkSurface,
        onSurface: TravelColors.onDarkSurface,
        surfaceContainerHighest: const Color(0xFF303030),
        onSurfaceVariant: Colors.white70,
        outline: Colors.white30,
        shadow: Colors.black,
      ),

      // Aplica la tipografía personalizada ajustada para modo oscuro
      textTheme: TravelTypography.textTheme.apply(
        bodyColor: TravelColors.onDarkSurface,
        displayColor: TravelColors.onDarkSurface,
      ),

      // Estilos de AppBar para modo oscuro
      appBarTheme: AppBarTheme(
        backgroundColor: TravelColors.darkSurface,
        elevation: TravelStyles.elevationM,
        centerTitle: true,
        iconTheme: const IconThemeData(color: TravelColors.primaryLight),
        titleTextStyle: TravelTypography.textTheme.headlineSmall?.copyWith(
          color: TravelColors.onDarkSurface,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Resto de los estilos modificados para modo oscuro
      // (Similar al tema claro pero con los colores adaptados)

      // Estilos de tarjeta para modo oscuro
      cardTheme: CardTheme(
        color: const Color(0xFF2C2C2C),
        elevation: TravelStyles.elevationM,
        shape: RoundedRectangleBorder(
          borderRadius: TravelStyles.borderRadiusAllM,
        ),
        margin: TravelStyles.paddingS,
      ),

      // Estilos de inputs para modo oscuro
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        contentPadding: TravelStyles.paddingM,
        border: OutlineInputBorder(
          borderRadius: TravelStyles.borderRadiusAllS,
          borderSide: const BorderSide(color: Color(0xFF444444), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: TravelStyles.borderRadiusAllS,
          borderSide: const BorderSide(color: Color(0xFF444444), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: TravelStyles.borderRadiusAllS,
          borderSide: const BorderSide(
            color: TravelColors.primaryLight,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: TravelStyles.borderRadiusAllS,
          borderSide: const BorderSide(color: TravelColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: TravelStyles.borderRadiusAllS,
          borderSide: const BorderSide(color: TravelColors.error, width: 2),
        ),
        labelStyle: TravelTypography.textTheme.bodyMedium?.copyWith(
          color: Colors.white70,
        ),
        hintStyle: TravelTypography.textTheme.bodyMedium?.copyWith(
          color: Colors.white30,
        ),
        errorStyle: TravelTypography.textTheme.bodySmall?.copyWith(
          color: TravelColors.error,
        ),
      ),
    );
  }
}
