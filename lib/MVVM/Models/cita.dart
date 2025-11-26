enum EstadoCita { Confirmada, Cancelada, Completada, Pendiente }

class Cita {
  final String id;
  final String clienteId;
  final String clienteNombre;
  final String proveedorId;
  final String servicioId;
  final String servicioNombre;
  final DateTime fecha;
  final String hora;
  final int duracion; 
  final double precio; 
  final String estado;

  Cita({
    required this.id,
    required this.clienteId,
    required this.clienteNombre,
    required this.proveedorId,
    required this.servicioId,
    required this.servicioNombre,
    required this.fecha,
    required this.hora,
    required this.duracion,
    required this.precio,
    required this.estado,
  });

  factory Cita.fromMap(Map<String, dynamic> map) {
    return Cita(
      id: map['id'] ?? '',
      clienteId: map['cliente_id'] ?? '',
      clienteNombre: map['profiles']?['nombre'] ?? 'N/A',
      proveedorId: map['proveedor_id'] ?? '',
      servicioId: map['servicio_id'] ?? '',
      servicioNombre: map['servicios']?['nombre'] ?? 'Servicio Desconocido',
      fecha: DateTime.parse(map['fecha']),
      hora: map['hora'] ?? '',
      duracion: map['servicios']?['duracion'] ?? 0,
      precio: (map['servicios']?['precio'] as num?)?.toDouble() ?? 0.0,
      estado: map['estado'] ?? 'Pendiente',
    );
  }
}