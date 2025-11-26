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

  String get horarioCompleto => '$horaInicio - $horaFin';

    Map<String, dynamic> toMap() => {
        'id': id,
        'inicio': horaInicio,
        'fin': horaFin,
      };

  factory Horario.fromMap(Map<String, dynamic> map) {
    return Horario(
      id: map['id'] ?? '',
      proveedorId: map['proveedor_id'] ?? '',
      diaSemana: map['dia_semana'] ?? '',
      horaInicio: map['hora_inicio'] ?? '',
      horaFin: map['hora_fin'] ?? '',
      activo: map['activo'] ?? true,
    );
  }
}