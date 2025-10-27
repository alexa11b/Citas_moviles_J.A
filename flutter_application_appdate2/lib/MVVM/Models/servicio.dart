class Servicio {
  final String id;
  final String proveedorId;
  final String nombre;
  final String descripcion;
  final int duracion;
  final double precio;
  final String categoria;
  final bool activo;
  final String? nombreProveedor;

  Servicio({
    required this.id,
    required this.proveedorId,
    required this.nombre,
    required this.descripcion,
    required this.duracion,
    required this.precio,
    required this.categoria,
    this.activo = true,
    this.nombreProveedor, 
  });

  factory Servicio.desdeMap(Map<String, dynamic> mapa) {
    return Servicio(
      id: mapa['id'] ?? '',
      proveedorId: mapa['proveedorId'] ?? '',
      nombre: mapa['nombre'] ?? '',
      descripcion: mapa['descripcion'] ?? '',
      duracion: mapa['duracion'] ?? 0,
      precio: (mapa['precio'] ?? 0.0).toDouble(),
      categoria: mapa['categoria'] ?? '',
      activo: mapa['activo'] ?? true,
      nombreProveedor: mapa['nombreProveedor'], 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'proveedorId': proveedorId,
      'nombre': nombre,
      'descripcion': descripcion,
      'duracion': duracion,
      'precio': precio,
      'categoria': categoria,
      'activo': activo,
      'nombreProveedor': nombreProveedor,
    };
  }
}