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
      create: (context) {
        final authService = AuthService();
        // ✅ authService ya llama _agregarUsuariosPrueba() en su constructor
        return LoginViewModel(authService);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // Logo de la aplicación
                const Icon(
                  Icons.calendar_today,
                  size: 80,
                  color: Colors.blue,
                ),
                
                const SizedBox(height: 16),
                
                // Título de la aplicación
                const Text(
                  'Citas Multi-Servicios',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Subtítulo
                const Text(
                  'Gestiona tus citas fácilmente',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Formulario de login
                Consumer<LoginViewModel>(
                  builder: (context, viewModel, child) {
                    // Si el login fue exitoso, navegar al dashboard
                    if (viewModel.usuario != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Bienvenido ${viewModel.usuario!.nombre}'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PaginaInicio()),
                        );
                      });
                    }
                    
                    return FormularioLogin(
                      alIniciarSesion: viewModel.iniciarSesion,
                      cargando: viewModel.cargando,
                      error: viewModel.error,
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Enlace para recuperar contraseña
                TextButton(
                  onPressed: () => _navegarARecuperar(context),
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
                
                // Enlace para registrarse
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