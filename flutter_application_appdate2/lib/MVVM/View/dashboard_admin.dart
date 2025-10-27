import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';

class DashboardAdmin extends StatelessWidget {
  final Usuario usuario;

  const DashboardAdmin({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Administrador'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authService.cerrarSesion();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(usuario.nombre),
              accountEmail: Text(usuario.correo),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.admin_panel_settings, color: Colors.red),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Gestionar Tiendas'),
              onTap: () {
                // Navegar a gestión de tiendas
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Gestionar Usuarios'),
              onTap: () {
                // Navegar a gestión de usuarios
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración Sistema'),
              onTap: () {
                // Navegar a configuración
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                authService.cerrarSesion();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.admin_panel_settings, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              '¡Bienvenido ${usuario.nombre}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Panel de Administración',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            const Card(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Funciones de Administrador',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Text('• Gestionar todas las tiendas'),
                    Text('• Configurar horarios del sistema'),
                    Text('• Administrar usuarios'),
                    Text('• Configuración general'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}