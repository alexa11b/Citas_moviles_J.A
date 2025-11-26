import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/MVVM/Models/cita.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/citas_view_model.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';

class TarjetaCita extends StatelessWidget {
  final Cita cita;
  const TarjetaCita({super.key, required this.cita});

  @override
  Widget build(BuildContext context) {
    final esCliente = context.read<AuthService>().usuarioActual?.esCliente ?? true;
    final estaCancelada = cita.estado == 'Cancelada';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: estaCancelada ? Colors.grey[300] : Colors.white,
      child: ListTile(
        leading: Icon(
          Icons.event_available,
          color: estaCancelada ? Colors.grey : Colors.blue,
        ),
        title: Text(cita.servicioNombre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(esCliente ? 'Con: ${cita.proveedorId}' : 'Cliente: ${cita.clienteNombre}'),
            Text('Fecha: ${cita.fecha.day}/${cita.fecha.month}/${cita.fecha.year} a las ${cita.hora}'),
            Text('Estado: ${cita.estado}', style: TextStyle(fontWeight: FontWeight.bold, color: _getColorEstado(cita.estado))),
          ],
        ),
        trailing: !estaCancelada
            ? IconButton(
                icon: const Icon(Icons.cancel, color: Colors.red),
                tooltip: 'Cancelar Cita',
                onPressed: () => _confirmarCancelacion(context, cita.id),
              )
            : null,
      ),
    );
  }

  Color _getColorEstado(String estado) {
    switch (estado) {
      case 'Confirmada': return Colors.green;
      case 'Cancelada': return Colors.red;
      case 'Completada': return Colors.blue;
      default: return Colors.orange;
    }
  }

  void _confirmarCancelacion(BuildContext context, String citaId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar Cancelación'),
        content: const Text('¿Estás seguro de que quieres cancelar esta cita?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('No')),
          TextButton(
            onPressed: () {
              final viewModel = context.read<CitasViewModel>();
              final usuario = context.read<AuthService>().usuarioActual!;
              viewModel.cancelarCitaExistente(citaId, usuario);
              Navigator.pop(dialogContext);
            },
            child: const Text('Sí, cancelar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}