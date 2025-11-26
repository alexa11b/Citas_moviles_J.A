import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/MVVM/Models/horario.dart';
import 'package:flutter_application_appdate2/Service/horario_service.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/horario_view_model.dart';

class PaginaAgregarHorario extends StatelessWidget {
  const PaginaAgregarHorario({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HorarioViewModel(context.read<HorarioService>()),
      child: const _ContenidoPagina(),
    );
  }
}

class _ContenidoPagina extends StatefulWidget {
  const _ContenidoPagina();

  @override
  State<_ContenidoPagina> createState() => _ContenidoPaginaState();
}

class _ContenidoPaginaState extends State<_ContenidoPagina> {
  final _formKey = GlobalKey<FormState>();
  String _diaSeleccionado = 'Lunes';
  TimeOfDay _horaInicio = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _horaFin = const TimeOfDay(hour: 18, minute: 0);
  final List<String> _diasSemana = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];

  Future<void> _seleccionarHora(BuildContext context, bool esInicio) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: esInicio ? _horaInicio : _horaFin,
    );
    if (picked != null) {
      setState(() {
        if (esInicio) {
          _horaInicio = picked;
        } else {
          _horaFin = picked;
        }
      });
    }
  }

  void _agregarHorario() {
    if (_formKey.currentState!.validate()) {
      final authService = context.read<AuthService>();
      final proveedorId = authService.usuarioActual!.id;
      
      final nuevoHorario = Horario(
        id: '', // Supabase lo genera
        proveedorId: proveedorId,
        diaSemana: _diaSeleccionado,
        horaInicio: '${_horaInicio.hour.toString().padLeft(2, '0')}:${_horaInicio.minute.toString().padLeft(2, '0')}',
        horaFin: '${_horaFin.hour.toString().padLeft(2, '0')}:${_horaFin.minute.toString().padLeft(2, '0')}',
      );

      final viewModel = context.read<HorarioViewModel>();
      viewModel.agregarHorario(nuevoHorario).then((_) {
        if (mounted && viewModel.error == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Horario agregado a Supabase'), backgroundColor: Colors.green),
          );
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HorarioViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar Horario'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _diaSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Día de la semana',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                items: _diasSemana.map((dia) => DropdownMenuItem(value: dia, child: Text(dia))).toList(),
                onChanged: (value) => setState(() => _diaSeleccionado = value!),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Hora de inicio'),
                subtitle: Text(_horaInicio.format(context)),
                leading: const Icon(Icons.access_time, color: Colors.blue),
                onTap: () => _seleccionarHora(context, true),
              ),
              ListTile(
                title: const Text('Hora de fin'),
                subtitle: Text(_horaFin.format(context)),
                leading: const Icon(Icons.access_time, color: Colors.red),
                onTap: () => _seleccionarHora(context, false),
              ),
              const Spacer(),
              if (viewModel.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(viewModel.error!, style: const TextStyle(color: Colors.red)),
                ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: viewModel.cargando ? null : _agregarHorario,
                  child: viewModel.cargando
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('AGREGAR HORARIO'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}