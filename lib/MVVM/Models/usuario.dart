class Usuario {
  final String id;
  final String nombre;
  final String correo;
  final String telefono;
  final String tipoUsuario;

  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.tipoUsuario,
    required String pasword,
  });

  bool get esCliente => tipoUsuario == 'cliente';
  bool get esProveedor => tipoUsuario == 'proveedor';
  bool get esAdmin => tipoUsuario == 'admin';

  factory Usuario.fromMap(Map<String, dynamic> map, String email) {
    return Usuario(
      id: map['id'] ?? '',
      nombre: map['nombre'] as String? ?? 'Sin Nombre',
      correo: email,
      telefono: map['telefono'] as String? ?? 'Sin Teléfono',
      tipoUsuario: map['tipo_usuario'] as String? ?? 'cliente',
      pasword: '',
    );
  }
}
