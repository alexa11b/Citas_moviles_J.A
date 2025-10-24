import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';
import 'package:flutter_application_appdate2/Service/servicios_service.dart';

class ServiciosViewModel with ChangeNotifier {
  final ServiciosService _serviciosService;
  
  List<Servicio> _servicios = [];
  bool _cargando = false;
  String? _error;

  ServiciosViewModel(this._serviciosService);

  List<Servicio> get servicios => _servicios;
  bool get cargando => _cargando;
  String? get error => _error;

  Future<void> cargarServicios() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _servicios = await _serviciosService.obtenerServicios();
    } catch (e) {
      _error = e.toString();
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<void> agregarServicio(Servicio servicio) async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      await _serviciosService.agregarServicio(servicio);
      await cargarServicios(); // Recargar lista
    } catch (e) {
      _error = e.toString();
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}