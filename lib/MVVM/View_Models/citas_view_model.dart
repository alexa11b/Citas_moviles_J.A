import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/cita.dart';
import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';
import 'package:flutter_application_appdate2/Service/citas_service.dart';

class CitasViewModel with ChangeNotifier {
  final CitasService _citasService;


  List<Cita> _citas = [];
  bool _cargando = false;
  String? _error;

  CitasViewModel(this._citasService);

  List<Cita> get citas => _citas;
  bool get cargando => _cargando;
  String? get error => _error;

  List<Cita> get citasProximas {
    final ahora = DateTime.now();
    return _citas.where((cita) => cita.fecha.isAfter(ahora) || isSameDay(cita.fecha, ahora)).toList()
      ..sort((a, b) => a.fecha.compareTo(b.fecha));
  }
  
  List<Cita> get citasPasadas {
    final ahora = DateTime.now();
    return _citas.where((cita) => cita.fecha.isBefore(ahora) && !isSameDay(cita.fecha, ahora)).toList()
      ..sort((a, b) => b.fecha.compareTo(a.fecha));
  }

  Future<void> cargarCitas(Usuario usuario) async {
    _cargando = true;
    notifyListeners();
    try {
      if (usuario.esCliente) {
        _citas = await _citasService.obtenerCitasPorCliente(usuario.id);
      } else if (usuario.esProveedor) {
        _citas = await _citasService.obtenerCitasPorProveedor(usuario.id);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
  
  
  Future<bool> agendarNuevaCita({
    required Servicio servicio,
    required Usuario cliente,
    required DateTime fecha,
    required TimeOfDay hora,
  }) async {
    _cargando = true;
    notifyListeners();
    final datosCita = {
      'cliente_id': cliente.id,
      'proveedor_id': servicio.proveedorId,
      'servicio_id': servicio.id,
      'fecha': fecha.toIso8601String(),
      'hora': '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}',
    };
    try {
      await _citasService.agendarCita(datosCita);
      await cargarCitas(cliente);
      final reminderTime = DateTime(fecha.year, fecha.month, fecha.day, hora.hour, hora.minute).subtract(const Duration(days: 1));
      if (reminderTime.isAfter(DateTime.now())) {
       
      }
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
  
  Future<void> cancelarCitaExistente(String citaId, Usuario usuario) async {
    _cargando = true;
    notifyListeners();
    try {
      await _citasService.cancelarCita(citaId);
      await cargarCitas(usuario); 
    } catch (e) {
      _error = e.toString();
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}