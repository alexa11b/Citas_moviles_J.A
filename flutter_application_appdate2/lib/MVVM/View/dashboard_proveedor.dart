import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';
import 'package:flutter_application_appdate2/MVVM/View/pagina_servicios.dart';
import 'package:flutter_application_appdate2/MVVM/View/agregar_servicio.dart';
import 'package:flutter_application_appdate2/MVVM/View/pagina_perfil.dart';
import 'package:flutter_application_appdate2/MVVM/View/agregar_horario.dart';
import 'package:flutter_application_appdate2/MVVM/View/pagina_horario.dart';

class DashboardProveedor extends StatelessWidget {
  final Usuario usuario;

  const DashboardProveedor({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Proveedor'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthService>().cerrarSesion();
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.business_center, size: 80, color: Colors.blue[700]),
            const SizedBox(height: 20),
            Text(
              '¡Bienvenido, ${usuario.nombre}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Panel de Control - Proveedor',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildActionButton(
              context: context,
              icon: Icons.add_business,
              label: 'Agregar Nuevo Servicio',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PaginaAgregarServicio()));
              },
            ),
            const SizedBox(height: 12),
            _buildActionButton(
              context: context,
              icon: Icons.work,
              label: 'Ver Mis Servicios',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PaginaServicios(esProveedor: true)));
              },
            ),
            const SizedBox(height: 12),
            // -- BOTONES DE HORARIOS RESTAURADOS --
            _buildActionButton(
              context: context,
              icon: Icons.schedule,
              label: 'Configurar Horarios',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PaginaAgregarHorario()));
              },
            ),
            const SizedBox(height: 12),
            _buildActionButton(
              context: context,
              icon: Icons.access_time,
              label: 'Ver Mis Horarios',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PaginaHorario()));
              },
              isSecondary: true,
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(usuario.nombre),
            accountEmail: Text(usuario.correo),
            decoration: const BoxDecoration(color: Colors.blue),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.business, color: Colors.blue, size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.blue),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          // -- OPCIONES DE HORARIOS RESTAURADAS EN EL MENÚ --
          ListTile(
            leading: const Icon(Icons.add_business, color: Colors.green),
            title: const Text('Agregar Servicio'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PaginaAgregarServicio()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.schedule, color: Colors.purple),
            title: const Text('Configurar Horario'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PaginaAgregarHorario()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mi Perfil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PaginaPerfil()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Cerrar Sesión'),
            onTap: () => context.read<AuthService>().cerrarSesion(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isSecondary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.grey[200] : Colors.blue,
          foregroundColor: isSecondary ? Colors.blue : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}