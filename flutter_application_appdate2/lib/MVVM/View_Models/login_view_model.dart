import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';

class LoginViewModel with ChangeNotifier {
  final AuthService _authService;

  Usuario? _usuario;
  bool _cargando = false;
  String? _error;

  LoginViewModel(this._authService);

  Usuario? get usuario => _usuario;
  bool get cargando => _cargando;
  String? get error => _error;

  Future<bool> iniciarSesion(String correo, String contrasena) async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      final usuarioLogueado = await _authService.login(correo, contrasena);
      _usuario = usuarioLogueado;
      
      
      _cargando = false;
      notifyListeners();
      return true;

    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _usuario = null;
      _cargando = false;
      notifyListeners();
      return false; 
    }
  }

  void limpiarError() {
    _error = null;
    notifyListeners();
  }
}