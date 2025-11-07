import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';

class AuthService with ChangeNotifier {
  final List<Usuario> _usuarios = []; 
  Usuario? _usuarioActual;
  bool _cargando = false;

  bool get cargando => _cargando;
  List<Usuario> get usuarios => _usuarios; 
  Usuario? get usuarioActual => _usuarioActual;

  AuthService() {
    _agregarUsuariosPrueba();
    debugPrint('AuthService initialized with ${_usuarios.length} users');
  }

  void _agregarUsuariosPrueba() {
    _usuarios.clear();
    _usuarios.addAll([
      // Usuario Administrador
      Usuario(
        id: 'admin01',
        nombre: 'Boga',
        correo: 'boga@admin.com',
        telefono: '6861112233',
        tipoUsuario: 'admin',
        pasword: 'AdminBoga123',
      ),
      // Usuario Proveedor
      Usuario(
        id: 'prov01',
        nombre: 'Ale',
        correo: 'ale@proveedor.com',
        telefono: '6864445566',
        tipoUsuario: 'proveedor',
        pasword: 'AleP1234',
      ),
      // Usuario Cliente 1
      Usuario(
        id: 'cli01',
        nombre: 'Jose Trejo',
        correo: 'jose.trejo@cliente.com',
        telefono: '6867778899',
        tipoUsuario: 'cliente',
        pasword: 'ClienteJose789',
      ),
      // Usuario Cliente 2
      Usuario(
        id: 'cli02',
        nombre: 'Hectorin Bajin',
        correo: 'hectorin.bajin@cliente.com',
        telefono: '6861234567',
        tipoUsuario: 'cliente',
        pasword: 'ClienteHector01',
      ),
    ]);
    debugPrint('Usuarios de prueba actualizados: ${_usuarios.length}');
  }


  Future<Usuario> login(String correo, String contrasena) async {
    _cargando = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      if (_usuarios.isEmpty) {
        throw Exception('No hay usuarios registrados');
      }

      final buscado = correo.trim().toLowerCase();
      final usuario = _usuarios.firstWhere(
        (u) => u.correo.trim().toLowerCase() == buscado,
        orElse: () => throw Exception('Usuario no encontrado'),
      );

      if (usuario.pasword != contrasena) {
        throw Exception('Contraseña incorrecta');
      }

      _usuarioActual = usuario;
      return usuario;
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
  
  Future<Usuario> registrar(Usuario usuario, String contrasena) async {
    return usuario; 
  }

  void cerrarSesion() {
    _usuarioActual = null;
    notifyListeners();
  }
}