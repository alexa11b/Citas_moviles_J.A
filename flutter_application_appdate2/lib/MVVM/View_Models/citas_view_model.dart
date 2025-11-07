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
    
    final nuevaCita = Cita(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      clienteId: cliente.id,
      clienteNombre: cliente.nombre,
      proveedorId: servicio.proveedorId,
      servicioId: servicio.id,
      servicioNombre: servicio.nombre,
      fecha: fecha,
      hora: '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}',
      duracion: servicio.duracion,
      precio: servicio.precio,
    );

    try {
      await _citasService.agendarCita(nuevaCita);
      await cargarCitas(cliente); 
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