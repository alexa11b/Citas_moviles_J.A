import 'package:flutter_application_appdate2/data/datasource.dart';
import 'package:flutter_application_appdate2/MVVM/Models/cita.dart';

class CitasService {
  final SupabaseDataSource _dataSource;
  CitasService(this._dataSource);

  Future<List<Cita>> obtenerCitasPorCliente(String clienteId) async {
    final data = await _dataSource.getCitasPorUsuario(clienteId);
    return data.map((mapa) => Cita.fromMap(mapa)).toList();
  }

  Future<List<Cita>> obtenerCitasPorProveedor(String proveedorId) async {
    final data = await _dataSource.getCitasPorUsuario(proveedorId);
    return data.map((mapa) => Cita.fromMap(mapa)).toList();
  }

  Future<void> agendarCita(Map<String, dynamic> datosCita) {
    return _dataSource.addCita(datosCita);
  }

  Future<void> cancelarCita(String citaId) {
    return _dataSource.cancelCita(citaId);
  }
}