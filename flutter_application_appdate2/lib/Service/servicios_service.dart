import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';


class ServiciosService {
  List<Servicio> servicios = [];

  ServiciosService() {
    _agregarServiciosPrueba();
  }

  void _agregarServiciosPrueba() {
    servicios.addAll([
      Servicio(
        id: '1',
        proveedorId: '2', // ID del proveedor María López
        nombre: 'Corte de Cabello Clásico',
        descripcion: 'Corte tradicional y bien estructurado para caballero',
        duracion: 30,
        precio: 120.0,
        categoria: 'Barbería',
        nombreProveedor: 'María López - Barbería Style',
      ),
      Servicio(
        id: '2',
        proveedorId: '2', // ID del proveedor María López
        nombre: 'Afeitado con Navaja',
        descripcion: 'Afeitado profesional con navaja straight y productos premium',
        duracion: 25,
        precio: 80.0,
        categoria: 'Barbería',
        nombreProveedor: 'María López - Barbería Style',
      ),
      Servicio(
        id: '3',
        proveedorId: '2', // ID del proveedor María López
        nombre: 'Corte + Barba',
        descripcion: 'Combo completo: corte de cabello y arreglo de barba',
        duracion: 45,
        precio: 180.0,
        categoria: 'Barbería',
        nombreProveedor: 'María López - Barbería Style',
      ),
    ]);
    print('✅ Servicios de prueba agregados para el proveedor María López');
  }

  Future<List<Servicio>> obtenerServicios() async {
    await Future.delayed(const Duration(seconds: 1));
    return servicios.where((s) => s.activo).toList();
  }

  Future<List<Servicio>> obtenerServiciosPorProveedor(String proveedorId) async {
    await Future.delayed(const Duration(seconds: 1));
    return servicios.where((s) => s.proveedorId == proveedorId && s.activo).toList();
  }

  Future<Servicio> agregarServicio(Servicio servicio) async {
    await Future.delayed(const Duration(seconds: 1));
    servicios.add(servicio);
    print('✅ Servicio agregado: ${servicio.nombre}');
    return servicio;
  }

  Future<void> eliminarServicio(String servicioId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    servicios.removeWhere((s) => s.id == servicioId);
    print('✅ Servicio eliminado: $servicioId');
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