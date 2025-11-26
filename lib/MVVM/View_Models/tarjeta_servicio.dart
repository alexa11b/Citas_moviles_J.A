import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';
import 'package:flutter_application_appdate2/MVVM/View/pagina_detalle_servicio.dart';


class TarjetaServicio extends StatelessWidget {
  final Servicio servicio;
  final bool esProveedor;
  final VoidCallback? onEliminar;

  const TarjetaServicio({
    super.key,
    required this.servicio,
    this.esProveedor = false,
    this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: _obtenerIconoCategoria(servicio.categoria),
        title: Text(servicio.nombre),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(servicio.descripcion),
            const SizedBox(height: 4),
            Text(
              'Duración: ${servicio.duracion} min - Precio: \$${servicio.precio}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (!esProveedor && servicio.nombreProveedor != null)
              Text(
                'Proveedor: ${servicio.nombreProveedor!}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            Text(
              'Categoría: ${servicio.categoria}',
              style: const TextStyle(fontSize: 12, color: Colors.blue),
            ),
          ],
        ),
        trailing: esProveedor
            ? IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onEliminar,
              )
            : const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          if (!esProveedor) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaginaDetalleServicio(servicio: servicio),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _obtenerIconoCategoria(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'barbería':
        return const Icon(Icons.cut, color: Colors.blue);
      case 'dentista':
        return const Icon(Icons.medical_services, color: Colors.green);
      case 'spa':
        return const Icon(Icons.spa, color: Colors.purple);
      case 'masajes':
        return const Icon(Icons.self_improvement, color: Colors.orange);
      default:
        return const Icon(Icons.work, color: Colors.grey);
    }
  }
}