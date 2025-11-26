import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';

class LoginViewModel with ChangeNotifier {
  final AuthService _authService;
  bool _cargando = false;
  String? _error;

  LoginViewModel(this._authService);

  bool get cargando => _cargando;
  String? get error => _error;
  Usuario? get usuario => _authService.usuarioActual;

  Future<bool> iniciarSesion(String correo, String contrasena) async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signIn(email: correo, password: contrasena);
      _cargando = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _cargando = false;
      notifyListeners();
      return false;
    }
  }
}