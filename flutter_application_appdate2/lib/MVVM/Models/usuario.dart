class Usuario {
  final String id;
  final String nombre;
  final String correo;
  final String telefono;
  
  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.telefono,
  });
  
  factory Usuario.desdeMap(Map<String, dynamic> mapa) {
    return Usuario(
      id: mapa['id'] ?? '',
      nombre: mapa['nombre'] ?? '',
      correo: mapa['correo'] ?? '',
      telefono: mapa['telefono'] ?? '',
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
    };
  }

  @override
  String toString() {
    return 'Usuario: $nombre ($correo)';
  }
}