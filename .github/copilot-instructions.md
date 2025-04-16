# Instructions for GitHub Copilot in this Flutter project

## Code Standards

- Use Dart 3.0+ with modern features like pattern matching and records
- Follow Clean Architecture principles separating presentation, domain, and data layers
- Implement state management with `Riverpod`
- Use the Repository pattern for data operations
- Prefer immutable classes with const constructors when possible

## Code Style

- Class names in PascalCase
- Variable and function names in camelCase
- File names in snake_case
- Widget files should end with "_widget.dart"
- Screen files should end with "_screen.dart"

## UI/UX

### Design Principles
- Follow Material Design 3 principles for visual consistency
- Implement light and dark modes with smooth transitions
- Maintain a contrast ratio of at least 4.5:1 for accessibility
- Use subtle animations that reinforce visual hierarchy (≤300ms)

### Typography
- Use a consistent typographic scale based on Material system
- Limit the application to 2-3 font families maximum
- Define reusable text styles in the theme file:
  ```dart
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    ),
    // Other styles...
  )
  ```

### Colors
- Define a semantic color palette (primary, secondary, error, etc.)
- Implement adaptive colors for light/dark mode
- Use accent colors in moderation for priority action elements
- Define color variables for the entire project in the theme:
  ```dart
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6200EE),
    brightness: Brightness.light,
  )
  ```

### Spacing
- Use a consistent spacing system based on multiples of 8px
- Define spacing constants:
  ```dart
  class Spacing {
    static const double xs = 4.0;
    static const double s = 8.0;
    static const double m = 16.0;
    static const double l = 24.0;
    static const double xl = 32.0;
  }
  ```

### Components
- Create reusable components for common patterns (buttons, cards, etc.)
- Implement skeleton widgets for loading states
- Use adaptive widgets for different screen sizes
- Create a component library with usage examples

### Interaction Patterns
- Provide haptic/visual feedback for all interactions
- Implement consistent page transitions (duration: 300ms)
- Use intuitive and consistent gestures throughout the app
- Implement error, empty, and loading states for all views

### Responsiveness
- Design for mobile first, then adapt to tablets and large screens
- Use `LayoutBuilder` or `MediaQuery` to adapt to different sizes
- Implement standard breakpoints:
  ```dart
  class BreakPoints {
    static const double mobile = 600;
    static const double tablet = 900;
    static const double desktop = 1200;
  }
  ```

### Accessibility
- Ensure all interactive elements have minimum size of 48px
- Include semantic labels for screen readers
- Test keyboard/TalkBack navigation
- Implement dynamic font scaling respecting system settings

### Consistency
- Maintain alignment and vertical rhythm across all screens
- Use the same icons for the same actions throughout the app
- Create a consistent visual language for states (error, success, warning)
- Document design decisions in a specific README file

### Performance
- Optimize rendering of long lists with `ListView.builder`
- Implement lazy loading for images and information
- Measure and optimize first render time for each screen
- Avoid unnecessary rebuilds with `const` and memoized widgets

## Patterns to follow

### Model
```dart
class User {
  final String id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: email as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
  };
}
```

### Repository
```dart
abstract class UserRepository {
  Future<User> getUserById(String id);
  Future<List<User>> getAllUsers();
  Future<void> saveUser(User user);
}

class UserRepositoryImpl implements UserRepository {
  final ApiClient _apiClient;

  UserRepositoryImpl(this._apiClient);

  @override
  Future<User> getUserById(String id) async {
    final response = await _apiClient.get('/users/$id');
    return User.fromJson(response);
  }

  // Implementations of other methods...
}
```

### BLoC (if used)
```dart
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserInitial()) {
    on<FetchUser>(_onFetchUser);
  }

  Future<void> _onFetchUser(FetchUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await _userRepository.getUserById(event.userId);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
```

### Riverpod (if used)
```dart
// Define a simple state provider
final counterProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observe the counter value
    final count = ref.watch(counterProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Riverpod Counter')),
      body: Center(
        child: Text(
          'Counter: $count',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Increment the counter
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}
```
```dart
// Async provider to get an activity
@riverpod
Future<Activity> activity(ActivityRef ref) async {
  final response = await http.get(Uri.parse('https://www.boredapi.com/api/activity'));
  
  if (response.statusCode == 200) {
    return Activity.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error loading activity');
  }
}
```

### Widget
```dart
class UserProfileWidget extends StatelessWidget {
  final User user;
  final VoidCallback onEdit;

  const UserProfileWidget({
    super.key,
    required this.user,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name, style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            Text(user.email),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onEdit,
              child: const Text('Edit profile'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Error Handling

- Use Result<T> or Either<L, R> for predictable errors
- Implement custom domain-specific exceptions
- Centralize API error handling in one place

## Testing

- Create unit tests for all business logic
- Implement widget tests for reusable components
- Use mocktail for mocks in tests

## Documentation

- Document all public classes with /// (Dart documentation)
- Include examples in documentation when useful
- Explain parameters and return values

## Structure folder
lib/
├── app/                      # Configuración global de la app
│   ├── app.dart              # Widget principal de la app
│   ├── routes.dart           # Definición de rutas
│   └── theme.dart            # Configuración de temas
│
├── core/                     # Funcionalidades core y utils
│   ├── constants/            # Constantes de la aplicación
│   ├── exceptions/           # Excepciones personalizadas
│   ├── network/              # Configuración de red/HTTP
│   └── utils/                # Utilidades generales
│
├── data/                     # Capa de datos
│   ├── datasources/          # Fuentes de datos (API, local)
│   ├── models/               # Modelos de datos
│   ├── repositories/         # Implementaciones de repositorios
│   └── providers/            # Proveedores de datos
│
├── domain/                   # Lógica de negocio
│   ├── entities/             # Entidades del dominio
│   ├── repositories/         # Interfaces de repositorios
│   └── usecases/             # Casos de uso
│
├── presentation/             # Capa de UI
│   ├── common/               # Widgets comunes
│   ├── screens/              # Pantallas organizadas por feature
│   │   ├── home/
│   │   ├── auth/
│   │   └── profile/
│   ├── widgets/              # Widgets específicos
│   └── state/                # Gestores de estado (providers, blocs)
│
├── l10n/                     # Internacionalización
│
└── main.dart                 # Punto de entrada