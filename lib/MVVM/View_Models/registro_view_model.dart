import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';

class RegistroViewModel with ChangeNotifier {
  final AuthService _authService;
  bool _cargando = false;
  String? _error;
  bool _registroExitoso = false;

  RegistroViewModel(this._authService);

  bool get cargando => _cargando;
  String? get error => _error;
  bool get registroExitoso => _registroExitoso;

  Future<void> registrarUsuario(String nombre, String correo, String telefono, String contrasena) async {
    _cargando = true;
    _error = null;
    _registroExitoso = false;
    notifyListeners();

     try {
      await _authService.signUp(
        email: correo,
        password: contrasena,
        nombre: nombre,
        telefono: telefono,
      );
      _registroExitoso = true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}