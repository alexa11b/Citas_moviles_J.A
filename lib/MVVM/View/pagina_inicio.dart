import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'dashboard_cliente.dart';
import 'dashboard_proveedor.dart';
import 'dashboard_admin.dart';


class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final usuario = authService.usuarioActual;

    if (usuario == null) {
      return _buildSinUsuario();
    }

    if (usuario.esCliente) {
      return DashboardCliente(usuario: usuario);
    } else if (usuario.esProveedor) {
      return DashboardProveedor(usuario: usuario);
    } else if (usuario.esAdmin) {
      return DashboardAdmin(usuario: usuario);
    } else {
      // Fallback por si algo sale mal
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Tipo de usuario desconocido.'),
        ),
      );
    }
  }

  Widget _buildSinUsuario() {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(
        child: Text('No hay usuario logueado'),
      ),
    );
  }
}