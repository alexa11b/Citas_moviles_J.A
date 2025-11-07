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
  EstadoCita estado;

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
    this.estado = EstadoCita.Confirmada,
  });
}