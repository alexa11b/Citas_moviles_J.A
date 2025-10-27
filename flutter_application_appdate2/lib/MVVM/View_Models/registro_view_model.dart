import 'package:flutter/material.dart';
import '../Models/usuario.dart';
import '../../Service/auth_service.dart';

class RegistroViewModel with ChangeNotifier {
  final AuthService _authService;
  
  Usuario? _usuario;
  bool _cargando = false;
  String? _error;

  RegistroViewModel(this._authService);

  Usuario? get usuario => _usuario;
  bool get cargando => _cargando;
  String? get error => _error;

  Future<void> registrarUsuario(String nombre, String correo, String telefono, String contrasena) async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      final nuevoUsuario = Usuario(
        id: '',
        nombre: nombre,
        correo: correo,
        telefono: telefono,
        tipoUsuario: 'cliente', 
        pasword: '', 
      );
      
      _usuario = await _authService.registrar(nuevoUsuario, contrasena);
    } catch (e) {
      _error = e.toString();
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  void limpiarError() {
    _error = null;
    notifyListeners();
  }
}