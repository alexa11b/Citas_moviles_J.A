import 'package:flutter/material.dart';

class SelectorHorario extends StatefulWidget {
  const SelectorHorario({super.key});

  @override
  State<SelectorHorario> createState() => _SelectorHorarioState();
}

class _SelectorHorarioState extends State<SelectorHorario> {
  TimeOfDay _horaInicio = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _horaFin = TimeOfDay(hour: 18, minute: 0);

  Future<void> _seleccionarHoraInicio() async {
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

  Future<void> _seleccionarHoraFin() async {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Hora de inicio'),
          subtitle: Text(_horaInicio.format(context)),
          trailing: Icon(Icons.access_time),
          onTap: _seleccionarHoraInicio,
        ),
        ListTile(
          title: Text('Hora de fin'),
          subtitle: Text(_horaFin.format(context)),
          trailing: Icon(Icons.access_time),
          onTap: _seleccionarHoraFin,
        ),
      ],
    );
  }
}