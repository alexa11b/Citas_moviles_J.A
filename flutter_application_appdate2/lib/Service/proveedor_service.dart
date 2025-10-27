import 'package:flutter_application_appdate2/MVVM/Models/proveedor.dart';


class ProveedorService {
  List<Proveedor> proveedores = [];

  ProveedorService() {
    _agregarProveedoresPrueba();
  }

  void _agregarProveedoresPrueba() {
    proveedores.addAll([
      Proveedor(
        id: '2',
        nombre: 'María López',
        correo: 'proveedor@test.com',
        telefono: '6861234567',
        pasword: '123456',
        nombreNegocio: 'Barbería Style',
        descripcionNegocio: 'Barbería profesional con los mejores cortes y afeitados tradicionales. Más de 10 años de experiencia.',
        direccion: 'Av. Principal #123, Centro',
        calificacion: 4.8,
        totalCalificaciones: 47,
        serviciosOfrecidos: ['Corte de Cabello', 'Afeitado con Navaja', 'Arreglo de Barba', 'Tinte para Cabello'],
        horariosAtencion: [
          'Lunes: 9:00 - 18:00',
          'Martes: 9:00 - 18:00',
          'Miércoles: 9:00 - 18:00',
          'Jueves: 9:00 - 18:00',
          'Viernes: 9:00 - 18:00',
          'Sábado: 10:00 - 14:00'
        ],
        verificado: true,
        telefonoNegocio: '6861234567',
        sitioWeb: 'https://barberiastyle.com',
        configuracion: {
          'tiempoEntreCitas': 30,
          'anticipacionMinima': 2,
          'cancelacionGratuita': true,
          'horasCancelacionGratuita': 24,
        },
      ),
      Proveedor(
        id: '4',
        nombre: 'Carlos Rodríguez',
        correo: 'dentista@test.com',
        telefono: '6867654321',
        pasword: '123456',
        nombreNegocio: 'Clínica Dental Sonrisa Perfecta',
        descripcionNegocio: 'Odontología general y especialidades. Tecnología de punta y atención personalizada.',
        direccion: 'Calle Dental #456, Zona Médica',
        calificacion: 4.9,
        totalCalificaciones: 89,
        serviciosOfrecidos: ['Limpieza Dental', 'Blanqueamiento', 'Ortodoncia', 'Implantes Dentales'],
        horariosAtencion: [
          'Lunes: 8:00 - 20:00',
          'Martes: 8:00 - 20:00',
          'Miércoles: 8:00 - 20:00',
          'Jueves: 8:00 - 20:00',
          'Viernes: 8:00 - 18:00'
        ],
        verificado: true,
        telefonoNegocio: '6867654321',
        configuracion: {
          'tiempoEntreCitas': 60,
          'anticipacionMinima': 24,
          'cancelacionGratuita': false,
          'horasCancelacionGratuita': 48,
        },
      ),
      Proveedor(
        id: '5',
        nombre: 'Ana Martínez',
        correo: 'spa@test.com',
        telefono: '6865554444',
        pasword: '123456',
        nombreNegocio: 'Spa Relajación Total',
        descripcionNegocio: 'Experiencias de relajación y bienestar. Masajes terapéuticos y tratamientos estéticos.',
        direccion: 'Blvd. del Relax #789, Zona Spa',
        calificacion: 4.7,
        totalCalificaciones: 34,
        serviciosOfrecidos: ['Masaje Relajante', 'Masaje Terapéutico', 'Faciales', 'Tratamientos Corporales'],
        horariosAtencion: [
          'Lunes: 10:00 - 20:00',
          'Martes: 10:00 - 20:00',
          'Miércoles: 10:00 - 20:00',
          'Jueves: 10:00 - 20:00',
          'Viernes: 10:00 - 20:00',
          'Sábado: 9:00 - 16:00'
        ],
        verificado: false,
        telefonoNegocio: '6865554444',
        configuracion: {
          'tiempoEntreCitas': 90,
          'anticipacionMinima': 6,
          'cancelacionGratuita': true,
          'horasCancelacionGratuita': 12,
        },
      ),
    ]);
    
    print('✅ Proveedores de prueba agregados: ${proveedores.length} proveedores');
  }

  // Obtener todos los proveedores
  Future<List<Proveedor>> obtenerProveedores() async {
    await Future.delayed(const Duration(seconds: 1));
    return proveedores;
  }

  // Obtener proveedor por ID
  Future<Proveedor?> obtenerProveedorPorId(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return proveedores.firstWhere((proveedor) => proveedor.id == id);
    } catch (e) {
      return null;
    }
  }

  // Obtener proveedores por categoría
  Future<List<Proveedor>> obtenerProveedoresPorCategoria(String categoria) async {
    await Future.delayed(const Duration(seconds: 1));
    return proveedores.where((proveedor) {
      return proveedor.serviciosOfrecidos?.any((servicio) => 
        servicio.toLowerCase().contains(categoria.toLowerCase())
      ) ?? false;
    }).toList();
  }

  // Obtener proveedores verificados
  Future<List<Proveedor>> obtenerProveedoresVerificados() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return proveedores.where((proveedor) => proveedor.verificado == true).toList();
  }

  // Actualizar información del proveedor
  Future<Proveedor> actualizarProveedor(Proveedor proveedor) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final index = proveedores.indexWhere((p) => p.id == proveedor.id);
    if (index != -1) {
      proveedores[index] = proveedor;
      print('Proveedor actualizado: ${proveedor.nombreDisplay}');
    } else {
      proveedores.add(proveedor);
      print('Nuevo proveedor agregado: ${proveedor.nombreDisplay}');
    }
    
    return proveedor;
  }

  // Calificar proveedor
  Future<void> calificarProveedor(String proveedorId, double calificacion) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final proveedor = await obtenerProveedorPorId(proveedorId);
    if (proveedor != null) {
      
      proveedor.actualizarCalificacion(calificacion);
      proveedor.actualizarCalificacion(calificacion);
      print('⭐ Calificación agregada a ${proveedor.nombreDisplay}: $calificacion');
      
      // Actualizar en la lista
      final index = proveedores.indexWhere((p) => p.id == proveedorId);
      if (index != -1) {
        proveedores[index] = proveedor;
      }
    }
  }

  // Buscar proveedores
  Future<List<Proveedor>> buscarProveedores(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (query.isEmpty) return proveedores;
    
    final queryLower = query.toLowerCase();
    return proveedores.where((proveedor) {
      return proveedor.nombreDisplay.toLowerCase().contains(queryLower) ||
             proveedor.descripcionNegocio?.toLowerCase().contains(queryLower) == true ||
             proveedor.serviciosOfrecidos?.any((servicio) => 
               servicio.toLowerCase().contains(queryLower)
             ) == true;
    }).toList();
  }
}