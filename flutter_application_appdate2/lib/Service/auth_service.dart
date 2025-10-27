import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';

class AuthService with ChangeNotifier {
  // inicializar la lista para que nunca sea null
  final List<Usuario> usuarios = [];
  Usuario? usuarioActual;
  bool _cargando = false;

  bool get cargando => _cargando;

  AuthService() {
    _agregarUsuariosPrueba();
    debugPrint('AuthService initialized with ${usuarios.length} users');
  }

  void _agregarUsuariosPrueba() {
    // limpiar y agregar con addAll para evitar reasignaciones que puedan causar problemas
    usuarios.clear();
    usuarios.addAll([
      Usuario(
        id: '1',
        nombre: 'Cliente Test',
        correo: 'cliente@test.com',
        telefono: '6863940971',
        tipoUsuario: 'cliente',
        pasword: '123456',
      ),
      Usuario(
        id: '2',
        nombre: 'Proveedor Test',
        correo: 'proveedor@test.com',
        telefono: '6861234567',
        tipoUsuario: 'proveedor',
        pasword: '123456',
      ),
      Usuario(
        id: '3',
        nombre: 'Admin Test',
        correo: 'admin@test.com',
        telefono: '6860000000',
        tipoUsuario: 'admin',
        pasword: '123456',
      ),
    ]);
    debugPrint('Test users added: ${usuarios.map((u) => u.correo).toList()}');
    notifyListeners();
  }

  Future<Usuario> login(String correo, String contrasena) async {
    _cargando = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500)); // menor delay para pruebas

    try {
      debugPrint('Attempting login for: $correo');
      debugPrint('Available users: ${usuarios.map((u) => u.correo).toList()}');

      if (usuarios.isEmpty) {
        throw Exception('No hay usuarios registrados');
      }

      final buscado = correo.trim().toLowerCase();
      final usuario = usuarios.firstWhere(
        (u) => u.correo.trim().toLowerCase() == buscado,
        orElse: () => throw Exception('Usuario no encontrado'),
      );


      if (usuario.pasword != contrasena) {
        throw Exception('Contraseña incorrecta');
      }

      usuarioActual = usuario;
      notifyListeners();
      return usuario;
    } catch (e) {
      final mensaje = e.toString().replaceAll('Exception: ', '');
      throw Exception(mensaje);
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<Usuario> registrar(Usuario usuario, String contrasena) async {
    _cargando = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final correoNuevo = usuario.correo.trim().toLowerCase();
      if (usuarios.any((u) => u.correo.trim().toLowerCase() == correoNuevo)) {
        throw Exception('El correo ya está registrado');
      }

      final nuevoUsuario = Usuario(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nombre: usuario.nombre,
        correo: usuario.correo,
        telefono: usuario.telefono,
        tipoUsuario: 'cliente',
        pasword: contrasena,
      );

      usuarios.add(nuevoUsuario);
      usuarioActual = nuevoUsuario;
      notifyListeners();
      return nuevoUsuario;
    } catch (e) {
      final mensaje = e.toString().replaceAll('Exception: ', '');
      throw Exception(mensaje);
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  void cerrarSesion() {
    usuarioActual = null;
    notifyListeners();
  }
}