import 'package:flutter/material.dart';

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
      colorScheme: ColorScheme.fromSeed(
        seedColor: TravelColors.primary,
        brightness: Brightness.light,
      ),

      // Aplica la tipografía personalizada
      textTheme: TravelTypography.textTheme,

      // Estilos de AppBar
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),

      // Estilos de botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TravelColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TravelColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TravelColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TravelColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TravelColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
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

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: TravelColors.primary,
      ),
    );
  }

  /// Crea el tema oscuro para la aplicación.
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: TravelColors.primary,
        brightness: Brightness.dark,
      ),

      // Aplica la tipografía personalizada ajustada para modo oscuro
      textTheme: TravelTypography.textTheme.apply(
        bodyColor: TravelColors.onDarkSurface,
        displayColor: TravelColors.onDarkSurface,
      ),

      // Estilos de AppBar para modo oscuro
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),

      // Resto de los estilos modificados para modo oscuro
      // (Similar al tema claro pero con los colores adaptados)

      // Estilos de botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 2),
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
