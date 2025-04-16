/// Entidad de usuario que representa la información básica de un usuario en el dominio
class UserEntity {
  /// Identificador único del usuario
  final String? id;

  /// Nombre completo del usuario
  final String name;

  /// Correo electrónico del usuario, usado como identificador para iniciar sesión
  final String email;

  /// Contraseña del usuario (opcional, solo se usa en registro/login)
  final String? password;

  /// Estación del año preferida por el usuario para viajar
  final String preferredSeason;

  /// Constructor constante para inmutabilidad
  const UserEntity({
    this.id,
    required this.name,
    required this.email,
    this.password,
    required this.preferredSeason,
  });

  /// Método para crear una copia de la entidad con algunos valores modificados
  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? preferredSeason,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      preferredSeason: preferredSeason ?? this.preferredSeason,
    );
  }
}
