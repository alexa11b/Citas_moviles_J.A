import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/horario.dart';
import 'package:flutter_application_appdate2/Service/horario_service.dart';

class HorarioViewModel with ChangeNotifier {
  final HorarioService _horarioService;
  List<Horario> _horarios = [];
  bool _cargando = false;
  String? _error;

  HorarioViewModel(this._horarioService);

  List<Horario> get horarios => _horarios;
  bool get cargando => _cargando;
  String? get error => _error;

  Future<void> cargarHorariosProveedor(String proveedorId) async {
    _cargando = true;
    _error = null;
    notifyListeners();
    try {
      _horarios = await _horarioService.obtenerHorariosPorProveedor(proveedorId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<void> agregarHorario(Horario horario) async {
    _cargando = true;
    _error = null;
    notifyListeners();
    try {
      await _horarioService.agregarHorario(horario);
      await cargarHorariosProveedor(horario.proveedorId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}