
import 'package:flutter_application_appdate2/MVVM/Models/cita.dart';

class CitasService {
  final List<Cita> _citas = [];

  CitasService() {
    _agregarCitasDePrueba();
  }

  void _agregarCitasDePrueba() {
    _citas.add(
      Cita(
        id: 'cita001',
        clienteId: 'cli01', 
        clienteNombre: 'Jose Trejo',
        proveedorId: 'prov01', 
        servicioId: '1',
        servicioNombre: 'Corte de Cabello Clásico',
        fecha: DateTime.now().add(const Duration(days: 2)),
        hora: '15:30',
        duracion: 30,
        precio: 150.0,
        estado: EstadoCita.Confirmada,
      ),
    );
  }

  Future<List<Cita>> obtenerCitasPorCliente(String clienteId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _citas.where((cita) => cita.clienteId == clienteId).toList();
  }

  Future<List<Cita>> obtenerCitasPorProveedor(String proveedorId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _citas.where((cita) => cita.proveedorId == proveedorId).toList();
  }

  Future<Cita> agendarCita(Cita nuevaCita) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _citas.add(nuevaCita);
    return nuevaCita;
  }

  Future<void> cancelarCita(String citaId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _citas.indexWhere((cita) => cita.id == citaId);
    if (index != -1) {
      _citas[index].estado = EstadoCita.Cancelada;
    }
  }
}