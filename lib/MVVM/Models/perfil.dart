class Perfil {
  final String usuarioId;
  final String nombre;
  final String telefono;
  final String correo;
  final String tipoUsuario;

  Perfil({
    required this.usuarioId,
    required this.nombre,
    required this.telefono,
    required this.correo,
    required this.tipoUsuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'usuarioId': usuarioId,
      'nombre': nombre,
      'telefono': telefono,
      'correo': correo,
      'tipoUsuario': tipoUsuario,
    };
  }
}