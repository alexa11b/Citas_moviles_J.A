import 'package:flutter_application_appdate2/data/datasource.dart';
import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';

class ServiciosService {
  final SupabaseDataSource _dataSource;
  ServiciosService(this._dataSource);

  Future<List<Servicio>> obtenerServicios() async {
    final data = await _dataSource.getServicios();
    return data.map((mapa) => Servicio.fromMap(mapa)).toList();
  }

  Future<List<Servicio>> obtenerServiciosPorProveedor(String proveedorId) async {
    final data = await _dataSource.getServiciosPorProveedor(proveedorId);
    return data.map((mapa) => Servicio.fromMap(mapa)).toList();
  }

  Future<void> agregarServicio(Servicio servicio) {
    return _dataSource.addServicio(servicio.toMap());
  }

  Future<void> eliminarServicio(String servicioId) {
    return _dataSource.deleteServicio(servicioId);
  }
}