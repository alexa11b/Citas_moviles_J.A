import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/Service/horario_service.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/citas_view_model.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/horario_view_model.dart';

class PaginaDetalleServicio extends StatelessWidget {
  final Servicio servicio;

  const PaginaDetalleServicio({super.key, required this.servicio});

  @override
  Widget build(BuildContext context) {
    // Proveemos el ViewModel para esta pantalla, usando el servicio global.
    return ChangeNotifierProvider(
      create: (context) => HorarioViewModel(context.read<HorarioService>())
        ..cargarHorariosProveedor(servicio.proveedorId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(servicio.nombre),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(servicio.nombre, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Ofrecido por: ${servicio.nombreProveedor ?? 'N/A'}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                      const SizedBox(height: 16),
                      Text(servicio.descripcion, style: const TextStyle(fontSize: 16)),
                      const Divider(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Duración: ${servicio.duracion} min', style: const TextStyle(fontSize: 16)),
                          Text('Precio: \$${servicio.precio.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Horarios Disponibles del Proveedor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildListaHorarios(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final authService = context.read<AuthService>();
                    final cliente = authService.usuarioActual;

                    if (cliente == null) return;

                    final DateTime? fechaSeleccionada = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 90)),
                    );

                    if (fechaSeleccionada == null || !context.mounted) return;

                    final TimeOfDay? horaSeleccionada = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (horaSeleccionada == null || !context.mounted) return;

                    final citasViewModel = context.read<CitasViewModel>();
                    final exito = await citasViewModel.agendarNuevaCita(
                      servicio: servicio,
                      cliente: cliente,
                      fecha: fechaSeleccionada,
                      hora: horaSeleccionada,
                    );

                    if (exito && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('¡Cita agendada con éxito!'), backgroundColor: Colors.green),
                      );
                      Navigator.pop(context);
                    } else if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al agendar: ${citasViewModel.error}'), backgroundColor: Colors.red),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14)
                  ),
                  child: const Text('AGENDAR CITA', style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListaHorarios() {
    return Consumer<HorarioViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.cargando) {
          return const Center(child: CircularProgressIndicator());
        }
        if (viewModel.error != null) {
          return Center(child: Text('Error al cargar horarios: ${viewModel.error}', style: const TextStyle(color: Colors.red)));
        }
        if (viewModel.horarios.isEmpty) {
          return const Center(child: Text('El proveedor no tiene horarios configurados.'));
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: viewModel.horarios.map((horario) => ListTile(
                leading: const Icon(Icons.access_time, color: Colors.blue),
                title: Text(horario.diaSemana, style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(horario.horarioCompleto, style: const TextStyle(fontSize: 15)),
              )).toList(),
            ),
          ),
        );
      },
    );
  }
}