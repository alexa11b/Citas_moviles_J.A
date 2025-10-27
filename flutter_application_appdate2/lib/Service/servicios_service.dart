import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';

class ServiciosService {
  List<Servicio> servicios = [];

  ServiciosService() {
    _agregarServiciosPrueba();
  }

  void _agregarServiciosPrueba() {
    servicios.clear();
    servicios.addAll([
      Servicio(
        id: '1',
        proveedorId: 'prov01',
        nombre: 'Corte de Cabello Clásico',
        descripcion: 'Corte tradicional y bien estructurado.',
        duracion: 30,
        precio: 150.0,
        categoria: 'Barbería',
        nombreProveedor: 'Ale',
      ),
      Servicio(
        id: '2',
        proveedorId: 'prov01',
        nombre: 'Afeitado con Navaja',
        descripcion: 'Afeitado profesional con navaja y productos premium.',
        duracion: 25,
        precio: 100.0,
        categoria: 'Barbería',
        nombreProveedor: 'Ale',
      ),
    ]);
    debugPrint('ServiciosService inicializado y listo.');
  }

  Future<List<Servicio>> obtenerServicios() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return servicios.where((s) => s.activo).toList();
  }

  Future<List<Servicio>> obtenerServiciosPorProveedor(String proveedorId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return servicios.where((s) => s.proveedorId == proveedorId && s.activo).toList();
  }

  Future<Servicio> agregarServicio(Servicio servicio) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final nuevoServicio = Servicio(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      proveedorId: servicio.proveedorId,
      nombre: servicio.nombre,
      descripcion: servicio.descripcion,
      duracion: servicio.duracion,
      precio: servicio.precio,
      categoria: servicio.categoria,
      nombreProveedor: servicio.nombreProveedor,
    );
    servicios.add(nuevoServicio);
    return nuevoServicio;
  }

  // --- FUNCIÓN PARA ELIMINAR UN SERVICIO ---
  Future<void> eliminarServicio(String servicioId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    servicios.removeWhere((servicio) => servicio.id == servicioId);
    debugPrint('Servicio con ID $servicioId eliminado.');
  }

  Future<Servicio> actualizarServicio(Servicio servicio) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = servicios.indexWhere((s) => s.id == servicio.id);
    if (index != -1) {
      servicios[index] = servicio;
    }
    return servicio;
  }
}