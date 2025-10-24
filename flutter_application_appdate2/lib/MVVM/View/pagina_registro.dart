import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/widgets/formulario_registro.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:provider/provider.dart';
import '../view_models/registro_view_model.dart';



class PaginaRegistro extends StatelessWidget {
  const PaginaRegistro({super.key});

  void _regresarALogin(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistroViewModel(AuthService()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _regresarALogin(context),
          ),
          title: Text('Crear Cuenta'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: 20),
                
                // Logo
                Icon(
                  Icons.calendar_today,
                  size: 60,
                  color: Colors.blue,
                ),
                
                SizedBox(height: 16),
                
                // Título
                Text(
                  'Crear Nueva Cuenta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(height: 8),
                
                // Instrucciones
                Text(
                  'Completa tus datos para registrarte',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                
                SizedBox(height: 32),
                
                // Formulario de registro
                Consumer<RegistroViewModel>(
                  builder: (context, viewModel, child) {
                    // Si el registro fue exitoso, regresar al login
                    if (viewModel.usuario != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registro exitoso. Ahora puedes iniciar sesión.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      });
                    }
                    
                    return FormularioRegistro(
                      alRegistrar: viewModel.registrarUsuario,
                      cargando: viewModel.cargando,
                      error: viewModel.error,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}