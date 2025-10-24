import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';

class TarjetaServicio extends StatelessWidget {
  final Servicio servicio;

  const TarjetaServicio({
    super.key,
    required this.servicio,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(Icons.work, color: Colors.blue),
        title: Text(servicio.nombre),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(servicio.descripcion),
            SizedBox(height: 4),
            Text(
              'Precio: \$${servicio.precio} - Duración: ${servicio.duracion} min',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navegar a detalles del servicio
        },
      ),
    );
  }
}