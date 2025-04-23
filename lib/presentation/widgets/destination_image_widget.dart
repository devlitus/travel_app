import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:travel/presentation/state/destination_image_provider.dart';

/// Widget que muestra la imagen de un destino turístico
///
/// Puede manejar diferentes estados: carga, éxito, error, etc.
class DestinationImageWidget extends ConsumerWidget {
  /// El nombre del destino para el que mostrar/generar la imagen
  final String destination;

  /// Contexto adicional para el prompt (opcional)
  final String? additionalContext;

  /// Si es true, generará la imagen automáticamente al montar el widget
  final bool autoGenerate;

  /// Alto de la imagen
  final double height;

  /// Ancho de la imagen
  final double width;

  /// Radiante de las esquinas redondeadas
  final double borderRadius;

  /// Constructor del widget
  const DestinationImageWidget({
    super.key,
    required this.destination,
    this.additionalContext,
    this.autoGenerate = false,
    this.height = 200,
    this.width = double.infinity,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(destinationImageProvider);

    // Auto-generar la imagen al montar el widget si está habilitado
    if (autoGenerate && state.state == ImageGenerationState.initial) {
      // Uso de addPostFrameCallback para evitar llamar a un StateNotifier durante el build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(destinationImageProvider.notifier).generateImage(
              destination,
              additionalContext: additionalContext,
            );
      });
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: SizedBox(
        height: height,
        width: width,
        child: _buildContent(context, state),
      ),
    );
  }

  /// Construye el contenido del widget según el estado
  Widget _buildContent(BuildContext context, DestinationImageState state) {
    switch (state.state) {
      case ImageGenerationState.initial:
        return _buildInitialState(context);
      case ImageGenerationState.loading:
        return _buildLoadingState(context);
      case ImageGenerationState.success:
        return _buildSuccessState(context, state);
      case ImageGenerationState.error:
        return _buildErrorState(context, state.errorMessage);
    }
  }

  /// Estado inicial - sin imagen generada
  Widget _buildInitialState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Sin imagen para $destination',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          if (!autoGenerate) _buildGenerateButton(context),
        ],
      ),
    );
  }

  /// Estado de carga - generando la imagen
  Widget _buildLoadingState(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Fondo con efecto shimmer
        Container(
          color: Colors.grey[300],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Generando imagen para\n$destination',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }

  /// Estado de éxito - muestra la imagen generada
  Widget _buildSuccessState(BuildContext context, DestinationImageState state) {
    if (state.image == null || state.image!.localPath.isEmpty) {
      return _buildErrorState(context, 'Imagen no disponible');
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen generada
        Image.file(
          File(state.image!.localPath),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorState(context, 'Error al cargar la imagen');
          },
        ),

        // Gradiente en la parte inferior para mejorar legibilidad del texto
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
            child: Text(
              destination,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  /// Estado de error - muestra el mensaje de error
  Widget _buildErrorState(BuildContext context, String? errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage ?? 'Error al generar la imagen',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            const SizedBox(height: 16),
            _buildGenerateButton(context),
          ],
        ),
      ),
    );
  }

  /// Botón para generar/regenerar la imagen
  Widget _buildGenerateButton(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return ElevatedButton.icon(
          onPressed: () =>
              ref.read(destinationImageProvider.notifier).generateImage(
                    destination,
                    additionalContext: additionalContext,
                  ),
          icon: const Icon(Icons.image),
          label: const Text('Generar imagen'),
        );
      },
    );
  }
}

/// Widget simplificado para mostrar una imagen de un destino desde una ruta local
///
/// Este widget maneja el caso de error si la imagen no existe o no se puede cargar.
/// Si la imagen local no existe, intentará cargar una imagen de respaldo desde assets/images.
class SimpleDestinationImageWidget extends StatelessWidget {
  /// Ruta local de la imagen a mostrar
  final String imagePath;

  /// Altura del widget (opcional)
  final double? height;

  /// Ancho del widget (opcional)
  final double? width;

  /// Cómo debe ajustarse la imagen dentro del espacio disponible
  final BoxFit? fit;

  /// Nombre del asset de respaldo si la imagen local falla (sin la extensión)
  final String? fallbackAssetName;

  /// Constructor
  const SimpleDestinationImageWidget({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.fallbackAssetName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height,
      width: width,
      child: _buildImage(theme),
    );
  }

  Widget _buildImage(ThemeData theme) {
    // Verificar si hay una ruta de imagen
    if (imagePath.isEmpty) {
      // Si no hay ruta, intentar cargar imagen de respaldo
      return _tryLoadFallbackImage(theme) ??
          _buildErrorWidget(theme, 'No hay ruta de imagen');
    }

    // Intentar cargar la imagen desde el almacenamiento local
    try {
      final file = File(imagePath);

      // Verificar si el archivo existe
      if (!file.existsSync()) {
        // Si el archivo no existe, intentar cargar imagen de respaldo
        return _tryLoadFallbackImage(theme) ??
            _buildErrorWidget(theme, 'La imagen no existe');
      }

      return Image.file(
        file,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          // Si hay error al cargar el archivo, intentar con imagen de respaldo
          return _tryLoadFallbackImage(theme) ??
              _buildErrorWidget(theme, 'Error al cargar imagen');
        },
      );
    } catch (e) {
      // Si hay excepción, intentar con imagen de respaldo
      return _tryLoadFallbackImage(theme) ??
          _buildErrorWidget(theme, 'Error: ${e.toString()}');
    }
  }

  /// Intenta cargar una imagen de respaldo desde assets/images
  Widget? _tryLoadFallbackImage(ThemeData theme) {
    final assetName = fallbackAssetName ?? _getDefaultAssetName(imagePath);

    if (assetName.isEmpty) return null;

    try {
      return Image.asset(
        'assets/images/$assetName.png',
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          // Si falla el PNG, intenta con JPG
          return Image.asset(
            'assets/images/$assetName.jpg',
            fit: fit,
            errorBuilder: (_, __, ___) => const SizedBox
                .shrink(), // Retornamos un widget vacío en vez de null
          );
        },
      );
    } catch (_) {
      return null;
    }
  }

  /// Extrae un nombre de asset predeterminado de la ruta de la imagen
  String _getDefaultAssetName(String path) {
    if (path.isEmpty) return '';

    // Intenta extraer el nombre base del archivo sin extensión
    final fileName = path.split('/').last.split('\\').last;
    final baseName = fileName.contains('.')
        ? fileName.substring(0, fileName.lastIndexOf('.'))
        : fileName;

    return baseName;
  }

  Widget _buildErrorWidget(ThemeData theme, String errorMessage) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
