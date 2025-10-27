import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/tarjeta_servicio.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/Service/servicios_service.dart';
import 'package:flutter_application_appdate2/MVVM/view_models/servicios_view_model.dart';

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
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Servicio'),
          content: const Text('¿Estás seguro de que quieres eliminar este servicio?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                final viewModel = Provider.of<ServiciosViewModel>(context, listen: false);
                viewModel.eliminarServicio(servicioId);
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
    final authService = Provider.of<AuthService>(context, listen: false);

    return ChangeNotifierProvider(
      create: (context) => ServiciosViewModel(ServiciosService()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.esProveedor ? 'Mis Servicios' : 'Servicios Disponibles'),
          actions: widget.esProveedor
              ? [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // Navegar a agregar servicio
                    },
                  ),
                ]
              : null,
        ),
        body: Consumer<ServiciosViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.cargando) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.servicios.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.esProveedor ? Icons.work_off : Icons.work_outline,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.esProveedor 
                          ? 'No tienes servicios registrados'
                          : 'No hay servicios disponibles',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    if (widget.esProveedor) ...[
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Navegar a agregar servicio
                        },
                        child: const Text('Agregar Primer Servicio'),
                      ),
                    ],
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Barra de búsqueda
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: widget.esProveedor ? 'Buscar mis servicios...' : 'Buscar servicios...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      // Implementar búsqueda
                    },
                  ),
                ),

                // Lista de servicios
                Expanded(
                  child: ListView.builder(
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
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: widget.esProveedor
            ? FloatingActionButton(
                onPressed: () {
                  // Navegar a agregar servicio
                },
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}