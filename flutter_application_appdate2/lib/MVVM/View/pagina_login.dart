import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/View/pagina_inicio.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/login_view_model.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:provider/provider.dart';
import 'pagina_registro.dart';
import 'pagina_recuperar.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/formulario_login.dart';

class PaginaLogin extends StatelessWidget {
  const PaginaLogin({super.key});

  void _navegarARegistro(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaginaRegistro()),
    );
  }

  void _navegarARecuperar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaginaRecuperarContrasena()),
    );
  }

  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider(
      create: (context) => LoginViewModel(context.read<AuthService>()),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Icon(
                  Icons.calendar_today,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Citas Multi-Servicios',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Gestiona tus citas fácilmente',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                Consumer<LoginViewModel>(
                  builder: (context, viewModel, child) {
                   if (viewModel.usuario != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PaginaInicio()),
                        );
                      });
                    }
                    
                    return FormularioLogin(
                     alIniciarSesion: (correo, pass) async {
                         await viewModel.iniciarSesion(correo, pass);
                         // No necesitamos retornar bool aquí. El estado del ViewModel lo controla todo.
                      },
                      cargando: viewModel.cargando,
                      error: viewModel.error,
                    );
                  },
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => _navegarARecuperar(context),
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿No tienes cuenta?'),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () => _navegarARegistro(context),
                      child: const Text('Regístrate aquí'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}