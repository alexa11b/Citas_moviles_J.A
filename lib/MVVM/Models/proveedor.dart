import 'usuario.dart';

class Proveedor extends Usuario {
  final String? nombreNegocio;
  final String? descripcionNegocio;
  final String? direccion;
  double? calificacion;
  int? totalCalificaciones;
  final List<String>? serviciosOfrecidos;
  final List<String>? horariosAtencion;
  final bool? verificado;
  final String? fotoNegocio;
  final String? telefonoNegocio;
  final String? sitioWeb;
  final Map<String, dynamic>? configuracion;

  Proveedor({
    required String id,
    required String nombre,
    required String correo,
    required String telefono,
    this.nombreNegocio,
    this.descripcionNegocio,
    this.direccion,
    this.calificacion,
    this.totalCalificaciones,
    this.serviciosOfrecidos,
    this.horariosAtencion,
    this.verificado = false,
    this.fotoNegocio,
    this.telefonoNegocio,
    this.sitioWeb,
    this.configuracion,
    required String pasword,
  }) : super(
         id: id,
         nombre: nombre,
         correo: correo,
         telefono: telefono,
         tipoUsuario: 'proveedor',
         pasword: pasword,
       );

  factory Proveedor.desdeMap(Map<String, dynamic> mapa) {
    return Proveedor(
      id: mapa['id'] ?? '',
      nombre: mapa['nombre'] ?? '',
      correo: mapa['correo'] ?? '',
      telefono: mapa['telefono'] ?? '',
      pasword: mapa['pasword'] ?? '',
      nombreNegocio: mapa['nombreNegocio'],
      descripcionNegocio: mapa['descripcionNegocio'],
      direccion: mapa['direccion'],
      calificacion: (mapa['calificacion'] ?? 0.0).toDouble(),
      totalCalificaciones: mapa['totalCalificaciones'] ?? 0,
      serviciosOfrecidos: List<String>.from(mapa['serviciosOfrecidos'] ?? []),
      horariosAtencion: List<String>.from(mapa['horariosAtencion'] ?? []),
      verificado: mapa['verificado'] ?? false,
      fotoNegocio: mapa['fotoNegocio'],
      telefonoNegocio: mapa['telefonoNegocio'],
      sitioWeb: mapa['sitioWeb'],
      configuracion: Map<String, dynamic>.from(mapa['configuracion'] ?? {}),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final mapa = <String, dynamic>{
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'password': password,
      'nombreNegocio': nombreNegocio,
      'descripcionNegocio': descripcionNegocio,
      'direccion': direccion,
      'calificacion': calificacion,
      'totalCalificaciones': totalCalificaciones,
      'serviciosOfrecidos': serviciosOfrecidos,
      'horariosAtencion': horariosAtencion,
      'verificado': verificado,
      'fotoNegocio': fotoNegocio,
      'telefonoNegocio': telefonoNegocio,
      'sitioWeb': sitioWeb,
      'configuracion': configuracion,
    };
    return mapa;
  }

  String get nombreDisplay => nombreNegocio ?? nombre;
  String get telefonoDisplay => telefonoNegocio ?? telefono;

  bool get tieneCalificaciones =>
      totalCalificaciones != null && totalCalificaciones! > 0;

  String get calificacionFormateada {
    if (calificacion == null) return 'Sin calificaciones';
    return '${calificacion!.toStringAsFixed(1)} ⭐ ($totalCalificaciones)';
  }

  get password => null;

  void actualizarCalificacion(double nuevaCalificacion) {
    if (totalCalificaciones == null || totalCalificaciones == 0) {
      calificacion = nuevaCalificacion;
      totalCalificaciones = 1;
    } else {
      final nuevoTotal = totalCalificaciones! + 1;
      final sumaActual = calificacion! * totalCalificaciones!;
      calificacion = (sumaActual + nuevaCalificacion) / nuevoTotal;
      totalCalificaciones = nuevoTotal;
    }
  }

  @override
  String toString() {
    return 'Proveedor: $nombreDisplay ($calificacionFormateada)';
  }
}
