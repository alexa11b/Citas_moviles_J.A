import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';

class ServiciosService {
  List<Servicio> servicios = [];

  Future<List<Servicio>> obtenerServicios() async {
    await Future.delayed(Duration(seconds: 1));
    return servicios;
  }

  Future<Servicio> agregarServicio(Servicio servicio) async {
    await Future.delayed(Duration(seconds: 1));
    servicios.add(servicio);
    return servicio;
  }

  void agregarServiciosPrueba() {
    servicios.addAll([
      Servicio(
        id: '1',
        nombre: 'Corte de Cabello',
        descripcion: 'Corte moderno y estilizado',
        duracion: 30,
        precio: 150.0,
        categoria: 'Barbería',
      ),
      Servicio(
        id: '2',
        nombre: 'Limpieza Dental',
        descripcion: 'Limpieza dental profesional',
        duracion: 45,
        precio: 300.0,
        categoria: 'Dentista',
      ),
    ]);
  }
}