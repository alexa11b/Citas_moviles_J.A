import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/tarjeta_servicio.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/servicios_view_model.dart';

class PaginaServicios extends StatefulWidget {
  final bool esProveedor;

  const PaginaServicios({
    super.key,
    this.esProveedor = false,
  });

  @override
  State<PaginaServicios> createState() => _PaginaServiciosState();
}

class _PaginaServiciosState extends State<PaginaServicios> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<ServiciosViewModel>(context, listen: false);
      final authService = Provider.of<AuthService>(context, listen: false);
      
      if (widget.esProveedor && authService.usuarioActual != null) {
        viewModel.cargarServiciosProveedor(authService.usuarioActual!.id);
      } else {
        viewModel.cargarServicios();
      }
    });
  }

  void _eliminarServicio(BuildContext context, String servicioId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que quieres eliminar este servicio? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                final viewModel = Provider.of<ServiciosViewModel>(context, listen: false);
                final proveedorId = Provider.of<AuthService>(context, listen: false).usuarioActual!.id;
                
                viewModel.eliminarServicio(servicioId).then((_) {
                  // Después de eliminar, recargamos la lista de servicios del proveedor.
                  viewModel.cargarServiciosProveedor(proveedorId);
                });
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.esProveedor ? 'Mis Servicios' : 'Servicios Disponibles'),
      ),
      body: Consumer<ServiciosViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.cargando) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.servicios.isEmpty) {
            return Center(
              child: Text(
                widget.esProveedor 
                    ? 'No tienes servicios registrados'
                    : 'No hay servicios disponibles por ahora',
              ),
            );
          }

          return ListView.builder(
            itemCount: viewModel.servicios.length,
            itemBuilder: (context, index) {
              final servicio = viewModel.servicios[index];
              return TarjetaServicio(
                servicio: servicio,
                esProveedor: widget.esProveedor,
                onEliminar: widget.esProveedor
                    ? () => _eliminarServicio(context, servicio.id)
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}