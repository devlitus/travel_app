import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider para SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// Provider para el estado de carga global
final loadingProvider = StateProvider<bool>((ref) => false);

// Provider para manejo de errores global
final errorProvider = StateProvider<String?>((ref) => null);

// Provider para el tema
final isDarkModeProvider = StateProvider<bool>((ref) => false);
