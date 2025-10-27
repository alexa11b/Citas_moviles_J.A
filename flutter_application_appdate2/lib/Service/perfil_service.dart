import 'package:flutter_application_appdate2/MVVM/Models/perfil.dart';


class PerfilService {
  Future<Perfil> actualizarPerfil(Perfil perfil) async {
    await Future.delayed(const Duration(seconds: 2));
    
    print('Perfil actualizado: ${perfil.nombre}');
    
    return perfil;
  }
}