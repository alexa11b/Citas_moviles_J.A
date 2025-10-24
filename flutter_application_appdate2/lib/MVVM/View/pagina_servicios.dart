import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/widgets/tarjeta_servicio.dart';
import 'package:flutter_application_appdate2/Service/servicios_service.dart';
import 'package:provider/provider.dart';
import '../view_models/servicios_view_model.dart';

class PaginaServicios extends StatelessWidget {
  const PaginaServicios({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ServiciosViewModel(ServiciosService()..agregarServiciosPrueba()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Servicios'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
              },
            ),
          ],
        ),
        body: Consumer<ServiciosViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.cargando) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                // Barra de búsqueda
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                // Lista de servicios
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.servicios.length,
                    itemBuilder: (context, index) {
                      final servicio = viewModel.servicios[index];
                      return TarjetaServicio(servicio: servicio);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}