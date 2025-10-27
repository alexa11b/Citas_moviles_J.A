import 'package:flutter_application_appdate2/MVVM/Models/horario.dart';

class HorarioService {
  List<Horario> horarios = [];

  HorarioService() {
    _agregarHorariosPrueba();
  }

  void _agregarHorariosPrueba() {
    horarios.addAll([
      Horario(
        id: '1',
        proveedorId: '2',
        diaSemana: 'Lunes',
        horaInicio: '09:00',
        horaFin: '18:00',
        activo: true,
      ),
      Horario(
        id: '2',
        proveedorId: '2',
        diaSemana: 'Martes', 
        horaInicio: '09:00',
        horaFin: '18:00',
        activo: true,
      ),
      Horario(
        id: '3',
        proveedorId: '2',
        diaSemana: 'Miércoles',
        horaInicio: '09:00',
        horaFin: '18:00',
        activo: true,
      ),
      Horario(
        id: '4',
        proveedorId: '2',
        diaSemana: 'Jueves',
        horaInicio: '09:00',
        horaFin: '18:00',
        activo: true,
      ),
      Horario(
        id: '5',
        proveedorId: '2',
        diaSemana: 'Viernes',
        horaInicio: '09:00',
        horaFin: '18:00',
        activo: true,
      ),
      Horario(
        id: '6',
        proveedorId: '2',
        diaSemana: 'Sábado',
        horaInicio: '10:00',
        horaFin: '14:00',
        activo: true,
      ),
    ]);
  }

  Future<List<Horario>> obtenerHorariosPorProveedor(String proveedorId) async {
    await Future.delayed(const Duration(seconds: 1));
    return horarios.where((h) => h.proveedorId == proveedorId).toList();
  }

  Future<Horario> agregarHorario(Horario horario) async {
    await Future.delayed(const Duration(seconds: 1));
    horarios.add(horario);
    return horario;
  }

  Future<void> actualizarHorario(Horario horario) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = horarios.indexWhere((h) => h.id == horario.id);
    if (index != -1) {
      horarios[index] = horario;
    }
  }
}