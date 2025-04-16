import 'package:flutter/material.dart';

/// Define los estilos consistentes para toda la aplicación como espaciado, bordes y elevaciones.
class TravelStyles {
  // Sistema de espaciado
  static const double spaceXXS = 2.0;
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;

  // Proporciona EdgeInsets para espaciado interno consistente
  static const EdgeInsets paddingXS = EdgeInsets.all(spaceXS);
  static const EdgeInsets paddingS = EdgeInsets.all(spaceS);
  static const EdgeInsets paddingM = EdgeInsets.all(spaceM);
  static const EdgeInsets paddingL = EdgeInsets.all(spaceL);
  static const EdgeInsets paddingXL = EdgeInsets.all(spaceXL);

  // Espaciado horizontal y vertical específico
  static const EdgeInsets paddingHorizontalS = EdgeInsets.symmetric(
    horizontal: spaceS,
  );
  static const EdgeInsets paddingHorizontalM = EdgeInsets.symmetric(
    horizontal: spaceM,
  );
  static const EdgeInsets paddingHorizontalL = EdgeInsets.symmetric(
    horizontal: spaceL,
  );
  static const EdgeInsets paddingVerticalS = EdgeInsets.symmetric(
    vertical: spaceS,
  );
  static const EdgeInsets paddingVerticalM = EdgeInsets.symmetric(
    vertical: spaceM,
  );
  static const EdgeInsets paddingVerticalL = EdgeInsets.symmetric(
    vertical: spaceL,
  );

  // Bordes redondeados para la UI
  static const double borderRadiusXS = 4.0;
  static const double borderRadiusS = 8.0;
  static const double borderRadiusM = 12.0;
  static const double borderRadiusL = 16.0;
  static const double borderRadiusXL = 24.0;
  static const double borderRadiusCircular = 100.0;

  // Border radius predefinidos
  static final BorderRadius borderRadiusAllXS = BorderRadius.circular(
    borderRadiusXS,
  );
  static final BorderRadius borderRadiusAllS = BorderRadius.circular(
    borderRadiusS,
  );
  static final BorderRadius borderRadiusAllM = BorderRadius.circular(
    borderRadiusM,
  );
  static final BorderRadius borderRadiusAllL = BorderRadius.circular(
    borderRadiusL,
  );
  static final BorderRadius borderRadiusAllXL = BorderRadius.circular(
    borderRadiusXL,
  );
  static final BorderRadius borderRadiusAllCircular = BorderRadius.circular(
    borderRadiusCircular,
  );

  // Elevaciones para efecto de profundidad
  static const double elevationXS = 1.0;
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;

  // Opacidades consistentes
  static const double opacityDisabled = 0.38;
  static const double opacityHint = 0.6;
  static const double opacityOverlay = 0.08;

  // Duración de animaciones
  static const Duration durationXS = Duration(milliseconds: 100);
  static const Duration durationS = Duration(milliseconds: 200);
  static const Duration durationM = Duration(milliseconds: 300);
  static const Duration durationL = Duration(milliseconds: 400);
  static const Duration durationXL = Duration(milliseconds: 500);

  // Curvas para animaciones
  static const Curve curveDefault = Curves.easeInOut;
  static const Curve curveFast = Curves.easeOut;
  static const Curve curveBounce = Curves.elasticOut;

  // Sombras predefinidas para tarjetas y elementos elevados
  static List<BoxShadow> get shadowS => [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get shadowM => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowL => [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
}
