class Servicio {
  final String id;
  final String proveedorId;
  final String nombre;
  final String descripcion;
  final int duracion;
  final double precio;
  final String categoria;
  final String? nombreProveedor;

  Servicio({
    required this.id,
    required this.proveedorId,
    required this.nombre,
    required this.descripcion,
    required this.duracion,
    required this.precio,
    required this.categoria,
    this.nombreProveedor,
  });

  factory Servicio.fromMap(Map<String, dynamic> map) {
    return Servicio(
      id: map['id'],
      proveedorId: map['proveedor_id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'] ?? '',
      duracion: map['duracion'],
      precio: (map['precio'] as num).toDouble(),
      categoria: map['categoria'] ?? 'Otros',
      nombreProveedor: map['profiles']?['nombre'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'proveedor_id': proveedorId,
      'nombre': nombre,
      'descripcion': descripcion,
      'duracion': duracion,
      'precio': precio,
      'categoria': categoria,
    };
  }
}