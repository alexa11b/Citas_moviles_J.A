import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/formulario_registro.dart';
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
      create: (context) => RegistroViewModel(context.read<AuthService>()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _regresarALogin(context),
          ),
          title: const Text('Crear Cuenta'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Icon(
                  Icons.calendar_today,
                  size: 60,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                const Text('Crear Nueva Cuenta', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Completa tus datos para registrarte', style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 32),
                Consumer<RegistroViewModel>(
                  builder: (context, viewModel, child) {
                    // Verificamos si el registro fue exitoso
                    if (viewModel.registroExitoso) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Registro exitoso. Revisa tu correo para confirmar.'),
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