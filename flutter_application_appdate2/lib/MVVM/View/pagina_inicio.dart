import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/View/pagina_perfil.dart';
import 'package:flutter_application_appdate2/MVVM/View/pagina_servicios.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:provider/provider.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final usuario = authService.usuarioActual;

    return Scaffold(
      appBar: AppBar(
        title: Text('Citas Multi-Servicios'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authService.cerrarSesion();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(usuario?.nombre ?? 'Usuario'),
              accountEmail: Text(usuario?.correo ?? ''),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
             leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaPerfil()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('Servicios'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaServicios()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Horario'),
              onTap: () {
                // Navegar a horario
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () {
                authService.cerrarSesion();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              '¡Bienvenido ${usuario?.nombre}!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Gestiona tus citas fácilmente',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaServicios()),
                );
              },
              child: Text('Ver Servicios Disponibles'),
            ),
          ],
        ),
      ),
    );
  }
}