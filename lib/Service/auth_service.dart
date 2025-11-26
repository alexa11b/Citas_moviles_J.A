import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/data/datasource.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';

class AuthService with ChangeNotifier {
  final SupabaseDataSource _dataSource;
  Usuario? _usuarioActual;
  Usuario? get usuarioActual => _usuarioActual;

  AuthService(this._dataSource) {
    _recuperarSesion();
    _dataSource.onAuthStateChange.listen((data) async {
      final session = data.session;
      if (session != null) {
        debugPrint(
          "Auth State Change: Sesión detectada para ${session.user.email}",
        );
        try {
          final profileData = await _dataSource.getProfile(session.user.id);
          _usuarioActual = Usuario.fromMap(profileData, session.user.email!);
          debugPrint(
            "Auth State Change: Perfil encontrado -> ${_usuarioActual!.nombre}",
          );
        } catch (e) {
          debugPrint("Auth State Change: ERROR al buscar perfil -> $e");
          _usuarioActual = null;
        }
      } else {
        debugPrint("Auth State Change: No hay sesión activa.");
        _usuarioActual = null;
      }
      notifyListeners();
    });
  }

  Future<void> _recuperarSesion() async {
    final session = _dataSource.currentSession;
    if (session != null) {
      try {
        final profileData = await _dataSource.getProfile(session.user.id);
        _usuarioActual = Usuario.fromMap(profileData, session.user.email!);
      } catch (e) {
        _usuarioActual = null;
      }
      notifyListeners();
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String nombre,
    required String telefono,
    String tipoUsuario = 'cliente',
  }) {
    final profileData = {
      'nombre': nombre,
      'telefono': telefono,
      'tipo_usuario': tipoUsuario,
    };
    return _dataSource.signUp(
      email: email,
      password: password,
      profileData: profileData,
    );
  }

  Future<void> signIn({required String email, required String password}) {
    return _dataSource.signIn(email: email, password: password);
  }

  Future<void> signOut() {
    return _dataSource.signOut();
  }
}
