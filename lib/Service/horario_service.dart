import 'package:flutter_application_appdate2/data/datasource.dart';
import 'package:flutter_application_appdate2/MVVM/Models/horario.dart';

class HorarioService {
  final SupabaseDataSource _dataSource;
  HorarioService(this._dataSource);

  Future<List<Horario>> obtenerHorariosPorProveedor(String proveedorId) async {
    final data = await _dataSource.getHorariosPorProveedor(proveedorId);
    return data.map((mapa) => Horario.fromMap(mapa)).toList();
  }

  Future<void> agregarHorario(Horario horario) {
    final data = {
      'proveedor_id': horario.proveedorId,
      'dia_semana': horario.diaSemana,
      'hora_inicio': horario.horaInicio,
      'hora_fin': horario.horaFin,
    };
    return _dataSource.addHorario(data);
  }
}