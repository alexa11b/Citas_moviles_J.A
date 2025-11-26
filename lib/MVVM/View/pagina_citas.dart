import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/citas_view_model.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/tarjeta_cita.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';

class PaginaCitas extends StatefulWidget {
  const PaginaCitas({super.key});

  @override
  State<PaginaCitas> createState() => _PaginaCitasState();
}

class _PaginaCitasState extends State<PaginaCitas> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final usuario = context.read<AuthService>().usuarioActual;
      if (usuario != null) {
        context.read<CitasViewModel>().cargarCitas(usuario);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CitasViewModel>();
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Citas'),
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'PRÓXIMAS'),
              Tab(text: 'HISTORIAL'),
            ],
          ),
        ),
        body: viewModel.cargando
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildListaCitas(viewModel.citasProximas, 'No tienes citas próximas.'),
                  _buildListaCitas(viewModel.citasPasadas, 'No tienes historial de citas.'),
                ],
              ),
      ),
    );
  }

  Widget _buildListaCitas(List<dynamic> citas, String emptyMessage) {
    if (citas.isEmpty) {
      return Center(child: Text(emptyMessage));
    }
    return RefreshIndicator(
      onRefresh: () async {
        final usuario = context.read<AuthService>().usuarioActual;
        if (usuario != null) {
          await context.read<CitasViewModel>().cargarCitas(usuario);
        }
      },
      child: ListView.builder(
        itemCount: citas.length,
        itemBuilder: (context, index) => TarjetaCita(cita: citas[index]),
      ),
    );
  }
}