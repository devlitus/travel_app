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