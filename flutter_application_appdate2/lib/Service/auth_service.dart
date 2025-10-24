import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';

class AuthService with ChangeNotifier {
  List<Usuario> usuarios = [];
  Usuario? usuarioActual;

  Future<Usuario> login(String correo, String contrasena) async {
    await Future.delayed(const Duration(seconds: 2));
    
    final usuario = usuarios.firstWhere(
      (user) => user.correo == correo,
      orElse: () => throw Exception('Usuario no encontrado. Verifica tus credenciales.'),
    );
    
    usuarioActual = usuario;
    notifyListeners(); 
    return usuario;
  }

  Future<Usuario> registrar(Usuario usuario, String contrasena) async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (usuarios.any((user) => user.correo == usuario.correo)) {
      throw Exception('El correo electrónico ya está registrado');
    }
    
    final nuevoUsuario = Usuario(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nombre: usuario.nombre,
      correo: usuario.correo,
      telefono: usuario.telefono,
    );
    
    usuarios.add(nuevoUsuario);
    usuarioActual = nuevoUsuario;
    notifyListeners(); // ✅ Notificar cambios
    return nuevoUsuario;
  }

  void cerrarSesion() {
    usuarioActual = null;
    notifyListeners(); 
  }

  void agregarUsuarioPrueba() {
    final usuarioPrueba = Usuario(
      id: '1',
      nombre: 'José Trejo',
      correo: 'josetrejo@gmail.com',
      telefono: '6863940971',
    );
    usuarios.add(usuarioPrueba);
    print('Usuario de prueba agregado: josetrejo@gmail.com / password123');
  }
}