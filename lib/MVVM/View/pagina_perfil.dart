import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/formulario_perfil.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/Service/perfil_service.dart';
import 'package:provider/provider.dart';
import '../view_models/perfil_view_model.dart';

class PaginaPerfil extends StatelessWidget {
  const PaginaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final usuarioActual = authService.usuarioActual;

    return ChangeNotifierProvider(
      create: (context) => PerfilViewModel(PerfilService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi Perfil'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: usuarioActual == null 
            ? _buildSinUsuario()
            : _buildConUsuario(context, usuarioActual),
      ),
    );
  }

  Widget _buildSinUsuario() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No hay usuario logueado',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }


Widget _buildConUsuario(BuildContext context, Usuario usuario) {
  return Consumer<PerfilViewModel>(
    builder: (context, viewModel, child) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Editar Información',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    FormularioPerfil(
                      usuario: usuario, 
                      alActualizarPerfil: viewModel.actualizarPerfil,
                      cargando: viewModel.cargando,
                      error: viewModel.error,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
}