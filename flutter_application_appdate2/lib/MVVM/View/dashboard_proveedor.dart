import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart'; 
import 'package:flutter_application_appdate2/MVVM/View/pagina_servicios.dart';
import 'package:flutter_application_appdate2/MVVM/View/pagina_horario.dart';
import 'package:flutter_application_appdate2/MVVM/View/agregar_servicio.dart';
import 'package:flutter_application_appdate2/MVVM/View/agregar_horario.dart';

class DashboardProveedor extends StatelessWidget {
  final Usuario usuario;

  const DashboardProveedor({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel Proveedor'),
        backgroundColor: Colors.orange,
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
                child: Icon(Icons.business, color: Colors.orange),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.orange),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add_business, color: Colors.green),
              title: const Text('Agregar Servicio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaginaAgregarServicio()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.work, color: Colors.blue),
              title: const Text('Mis Servicios'),
              onTap: () {
                Navigator.pop(context);
                // ✅ QUITAR esProveedor si no existe en PaginaServicios
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaginaServicios()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule, color: Colors.purple),
              title: const Text('Configurar Horarios'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaginaAgregarHorario()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time, color: Colors.red),
              title: const Text('Ver Mis Horarios'),
              onTap: () {
                Navigator.pop(context);
                // ✅ QUITAR esProveedor si no existe en PaginaHorario
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaginaHorario()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.grey),
              title: const Text('Mi Perfil'),
              onTap: () {
                Navigator.pop(context);
                // Navegar a perfil
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                authService.cerrarSesion();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header de bienvenida
            Card(
              color: Colors.orange[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.business, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¡Bienvenido, ${usuario.nombre}!',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Panel de Control - Proveedor de Servicios',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Estadísticas rápidas
            const Text(
              'Resumen Rápido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildTarjetaEstadistica(
                    icon: Icons.work,
                    color: Colors.blue,
                    titulo: 'Servicios',
                    valor: '3',
                    subtitulo: 'Activos',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTarjetaEstadistica(
                    icon: Icons.schedule,
                    color: Colors.green,
                    titulo: 'Horarios',
                    valor: '6',
                    subtitulo: 'Configurados',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Acciones rápidas
            const Text(
              'Acciones Rápidas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildBotonAccion(
                  icon: Icons.add_business,
                  color: Colors.green,
                  texto: 'Agregar Servicio',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaginaAgregarServicio()),
                    );
                  },
                ),
                _buildBotonAccion(
                  icon: Icons.schedule,
                  color: Colors.purple,
                  texto: 'Configurar Horario',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaginaAgregarHorario()),
                    );
                  },
                ),
                _buildBotonAccion(
                  icon: Icons.work,
                  color: Colors.blue,
                  texto: 'Mis Servicios',
                  onTap: () {
                    Navigator.push(
                      context,
                      // ✅ QUITAR esProveedor
                      MaterialPageRoute(builder: (context) => const PaginaServicios()),
                    );
                  },
                ),
                _buildBotonAccion(
                  icon: Icons.access_time,
                  color: Colors.red,
                  texto: 'Ver Horarios',
                  onTap: () {
                    Navigator.push(
                      context,
                      // ✅ QUITAR esProveedor
                      MaterialPageRoute(builder: (context) => const PaginaHorario()),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Próximas acciones
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Próximos Pasos',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildItemLista(
                      icon: Icons.check_circle,
                      color: Colors.green,
                      texto: 'Configura tus servicios básicos',
                    ),
                    _buildItemLista(
                      icon: Icons.check_circle,
                      color: Colors.green,
                      texto: 'Establece tus horarios de atención',
                    ),
                    _buildItemLista(
                      icon: Icons.radio_button_unchecked,
                      color: Colors.grey,
                      texto: 'Completa tu perfil de negocio',
                    ),
                    _buildItemLista(
                      icon: Icons.radio_button_unchecked,
                      color: Colors.grey,
                      texto: 'Agrega fotos de tus trabajos',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTarjetaEstadistica({
    required IconData icon,
    required Color color,
    required String titulo,
    required String valor,
    required String subtitulo,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              valor,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              titulo,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              subtitulo,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBotonAccion({
    required IconData icon,
    required Color color,
    required String texto,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                texto,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemLista({
    required IconData icon,
    required Color color,
    required String texto,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(texto, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}