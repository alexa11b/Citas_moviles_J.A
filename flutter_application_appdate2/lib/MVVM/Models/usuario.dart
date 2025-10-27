class Usuario {
  final String id;
  final String nombre;
  final String correo;
  final String telefono;
  final String tipoUsuario;
  final String pasword;
  
  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.tipoUsuario,
    required this.pasword,
  });
  
  factory Usuario.desdeMap(Map<String, dynamic> mapa) {
    return Usuario(
      id: mapa['id'] ?? '',
      nombre: mapa['nombre'] ?? '',
      correo: mapa['correo'] ?? '',
      telefono: mapa['telefono'] ?? '',
      tipoUsuario: mapa['tipoUsuario'] ?? 'cliente',
      pasword: mapa['pasword'] ?? '',
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'tipoUsuario': tipoUsuario,
    };
  }

  bool get esCliente => tipoUsuario == 'cliente';
  bool get esProveedor => tipoUsuario == 'proveedor';
  bool get esAdmin => tipoUsuario == 'admin';


  @override
  String toString() {
    return 'Usuario: $nombre ($tipoUsuario)';
  }
}