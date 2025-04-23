import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/spacing.dart';
import '../../../presentation/state/destination_image_provider.dart';
import '../../../presentation/widgets/destination_image_widget.dart';

class ItineraryDetailsScreen extends ConsumerWidget {
  final String destination;
  final String itinerary;

  const ItineraryDetailsScreen({
    super.key,
    required this.destination,
    required this.itinerary,
  });

  static const String routeName = '/itinerary-details';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Observar el estado de la imagen del destino
    final imageState = ref.watch(destinationImageProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            onPressed: () {
              // TODO: Implementar compartir itinerario
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.bookmark_border_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: Implementar guardar itinerario
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.8),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Mostrar la imagen generada si está disponible
                if (imageState.image != null)
                  Positioned.fill(
                    child: SimpleDestinationImageWidget(
                      imagePath: imageState.image!.localPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                // Capa de gradiente sobre la imagen para mejor legibilidad
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(height: Spacing.m),
                      Text(
                        destination,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                Spacing.l,
                0,
                Spacing.l,
                Spacing.l,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: theme.colorScheme.outline.withOpacity(0.1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Spacing.l),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detalles del itinerario',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: Spacing.m),
                          Text(
                            itinerary,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.l),

                  // Sección de imagen del destino
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: theme.colorScheme.outline.withOpacity(0.1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Spacing.l),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Imagen del destino',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: Spacing.m),

                          // Widget que muestra la imagen según el estado
                          DestinationImageStateWidget(destination: destination),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget que maneja el estado de la imagen del destino
class DestinationImageStateWidget extends ConsumerWidget {
  final String destination;

  const DestinationImageStateWidget({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final imageState = ref.watch(destinationImageProvider);

    // Intentar cargar la imagen existente al iniciar
    ref.listen<DestinationImageState>(
      destinationImageProvider,
      (_, __) {},
      onError: (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${error.toString()}'),
            backgroundColor: theme.colorScheme.error,
          ),
        );
      },
    );

    // Mostrar según el estado de carga
    switch (imageState.state) {
      case ImageGenerationState.loading:
        return const _LoadingImageWidget();

      case ImageGenerationState.success:
        if (imageState.image != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SimpleDestinationImageWidget(
                  imagePath: imageState.image!.localPath,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: Spacing.s),
              Text(
                'Imagen generada con IA',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: Spacing.m),
              Text(
                'Prompt: ${imageState.image!.prompt}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          );
        }
        // Si no hay imagen pero el estado es success, mostrar el botón
        return _GenerateImageButton(destination: destination);

      case ImageGenerationState.error:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Error al generar la imagen',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: Spacing.m),
            _GenerateImageButton(destination: destination),
          ],
        );

      case ImageGenerationState.initial:
      default:
        return _GenerateImageButton(destination: destination);
    }
  }
}

/// Widget para el botón de generación de imagen
class _GenerateImageButton extends ConsumerWidget {
  final String destination;

  const _GenerateImageButton({
    required this.destination,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        children: [
          const Text(
            'Genera una imagen única para este destino usando IA',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacing.m),
          ElevatedButton.icon(
            onPressed: () => _generateImage(ref, context),
            icon: const Icon(Icons.image),
            label: const Text('Generar imagen'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primaryContainer,
              foregroundColor: theme.colorScheme.onPrimaryContainer,
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.l,
                vertical: Spacing.m,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateImage(WidgetRef ref, BuildContext context) async {
    final notifier = ref.read(destinationImageProvider.notifier);
    try {
      await notifier.generateImage(
        destination,
        additionalContext: 'hermoso paisaje, luz natural',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

/// Widget para el estado de carga de la imagen
class _LoadingImageWidget extends StatelessWidget {
  const _LoadingImageWidget();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: Spacing.m),
                Text('Generando imagen con IA...'),
                SizedBox(height: Spacing.s),
                Text(
                  'Esto puede tardar unos segundos',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
