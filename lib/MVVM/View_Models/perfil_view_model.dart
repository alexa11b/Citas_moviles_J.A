import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/perfil.dart';
import 'package:flutter_application_appdate2/Service/perfil_service.dart';

class PerfilViewModel with ChangeNotifier {
  final PerfilService _perfilService;
  
  bool _cargando = false;
  String? _error;
  bool _actualizacionExitosa = false;

  PerfilViewModel(this._perfilService);

  bool get cargando => _cargando;
  String? get error => _error;
  bool get actualizacionExitosa => _actualizacionExitosa;

  Future<void> actualizarPerfil(Perfil perfil) async {
    _cargando = true;
    _error = null;
    _actualizacionExitosa = false;
    notifyListeners();

    try {
      await _perfilService.actualizarPerfil(perfil);
      _actualizacionExitosa = true;
    } catch (e) {
      _error = e.toString();
      _actualizacionExitosa = false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  void limpiarError() {
    _error = null;
    notifyListeners();
  }

  void limpiarEstado() {
    _actualizacionExitosa = false;
    _error = null;
    notifyListeners();
  }
}