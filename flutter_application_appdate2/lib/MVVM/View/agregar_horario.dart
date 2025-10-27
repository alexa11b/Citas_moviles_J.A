import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/MVVM/Models/horario.dart';
import 'package:flutter_application_appdate2/Service/horario_service.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/horario_view_model.dart';

class PaginaAgregarHorario extends StatefulWidget {
  const PaginaAgregarHorario({super.key});

  @override
  State<PaginaAgregarHorario> createState() => _PaginaAgregarHorarioState();
}

class _PaginaAgregarHorarioState extends State<PaginaAgregarHorario> {
  final _formKey = GlobalKey<FormState>();
  
  String _diaSeleccionado = 'Lunes';
  TimeOfDay _horaInicio = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _horaFin = const TimeOfDay(hour: 18, minute: 0);

  final List<String> _diasSemana = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];

  Future<void> _seleccionarHoraInicio(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _horaInicio,
    );
    if (picked != null) {
      setState(() {
        _horaInicio = picked;
      });
    }
  }

  Future<void> _seleccionarHoraFin(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _horaFin,
    );
    if (picked != null) {
      setState(() {
        _horaFin = picked;
      });
    }
  }

  void _agregarHorario(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final authService = Provider.of<AuthService>(context, listen: false);
      final proveedorId = authService.usuarioActual!.id;
      
      final nuevoHorario = Horario(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        proveedorId: proveedorId,
        diaSemana: _diaSeleccionado,
        horaInicio: '${_horaInicio.hour.toString().padLeft(2, '0')}:${_horaInicio.minute.toString().padLeft(2, '0')}',
        horaFin: '${_horaFin.hour.toString().padLeft(2, '0')}:${_horaFin.minute.toString().padLeft(2, '0')}',
        activo: true,
      );

      final viewModel = Provider.of<HorarioViewModel>(context, listen: false);
      viewModel.agregarHorario(nuevoHorario).then((_) {
        if (viewModel.error == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Horario agregado correctamente'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HorarioViewModel(HorarioService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurar Horario'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Consumer<HorarioViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Selector de Día
                    DropdownButtonFormField<String>(
                      initialValue: _diaSeleccionado,
                      decoration: const InputDecoration(
                        labelText: 'Día de la semana',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      items: _diasSemana
                          .map((dia) => DropdownMenuItem(
                                value: dia,
                                child: Text(dia),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _diaSeleccionado = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione un día';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Selector Hora Inicio
                    ListTile(
                      title: const Text('Hora de inicio'),
                      subtitle: Text(_horaInicio.format(context)),
                      leading: const Icon(Icons.access_time, color: Colors.blue),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: () => _seleccionarHoraInicio(context),
                    ),
                    const SizedBox(height: 10),

                    // Selector Hora Fin
                    ListTile(
                      title: const Text('Hora de fin'),
                      subtitle: Text(_horaFin.format(context)),
                      leading: const Icon(Icons.access_time, color: Colors.red),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: () => _seleccionarHoraFin(context),
                    ),
                    const SizedBox(height: 20),

                    // Resumen del horario
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Text(
                              'Resumen del Horario',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Día: $_diaSeleccionado',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              'Horario: ${_horaInicio.format(context)} - ${_horaFin.format(context)}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Mostrar error si existe
                    if (viewModel.error != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text(
                          viewModel.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    if (viewModel.error != null) const SizedBox(height: 16),

                    // Botón Agregar
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: viewModel.cargando
                            ? null
                            : () => _agregarHorario(context),
                        child: viewModel.cargando
                            ? const CircularProgressIndicator()
                            : const Text(
                                'AGREGAR HORARIO',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Botón para ver horarios existentes
                    OutlinedButton(
                      onPressed: () {
                        // Navegar a página de horarios del proveedor
                      },
                      child: const Text('VER MIS HORARIOS CONFIGURADOS'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}