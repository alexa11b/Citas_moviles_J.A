class Horario {
  final String id;
  final String proveedorId;
  final String diaSemana;
  final String horaInicio;
  final String horaFin;
  final bool activo;

  Horario({
    required this.id,
    required this.proveedorId,
    required this.diaSemana,
    required this.horaInicio,
    required this.horaFin,
    this.activo = true,
  });

  factory Horario.desdeMap(Map<String, dynamic> mapa) {
    return Horario(
      id: mapa['id'] ?? '',
      proveedorId: mapa['proveedorId'] ?? '',
      diaSemana: mapa['diaSemana'] ?? '',
      horaInicio: mapa['horaInicio'] ?? '',
      horaFin: mapa['horaFin'] ?? '',
      activo: mapa['activo'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'proveedorId': proveedorId,
      'diaSemana': diaSemana,
      'horaInicio': horaInicio,
      'horaFin': horaFin,
      'activo': activo,
    };
  }

  String get horarioCompleto => '$horaInicio - $horaFin';
}