import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel/presentation/widgets/destination_image_widget.dart';

/// Widget de demostración para el generador de imágenes de destinos
class DestinationImageDemoWidget extends ConsumerStatefulWidget {
  /// Constructor del widget
  const DestinationImageDemoWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<DestinationImageDemoWidget> createState() =>
      _DestinationImageDemoWidgetState();
}

class _DestinationImageDemoWidgetState
    extends ConsumerState<DestinationImageDemoWidget> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _contextController = TextEditingController();
  String _currentDestination = '';

  @override
  void dispose() {
    _destinationController.dispose();
    _contextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título
          Text(
            'Generador de Imágenes de Destinos',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Campo de entrada para el destino
          TextField(
            controller: _destinationController,
            decoration: const InputDecoration(
              labelText: 'Destino',
              hintText: 'Ej. París, Venecia, Tokio',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
            textCapitalization: TextCapitalization.words,
          ),

          const SizedBox(height: 16),

          // Campo de entrada para contexto adicional
          TextField(
            controller: _contextController,
            decoration: const InputDecoration(
              labelText: 'Contexto adicional (opcional)',
              hintText: 'Ej. durante invierno, arquitectura medieval',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 2,
          ),

          const SizedBox(height: 24),

          // Botón para generar imagen
          ElevatedButton.icon(
            onPressed: () {
              // Validar que haya un destino
              if (_destinationController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor ingresa un destino'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // Actualizar el destino actual
              setState(() {
                _currentDestination = _destinationController.text.trim();
              });
            },
            icon: const Icon(Icons.image),
            label: const Text('Generar Imagen'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),

          const SizedBox(height: 32),

          // Mostrar imagen del destino (si se ha ingresado uno)
          if (_currentDestination.isNotEmpty) ...[
            Text(
              'Imagen generada para $_currentDestination:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            DestinationImageWidget(
              destination: _currentDestination,
              additionalContext: _contextController.text.trim().isNotEmpty
                  ? _contextController.text.trim()
                  : null,
              height: 300,
              autoGenerate: true,
            ),
          ],
        ],
      ),
    );
  }
}
