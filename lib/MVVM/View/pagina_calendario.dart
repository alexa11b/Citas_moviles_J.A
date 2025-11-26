// lib/MVVM/View/pagina_calendario.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_appdate2/MVVM/Models/cita.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/citas_view_model.dart' hide isSameDay;
import 'package:flutter_application_appdate2/MVVM/View_Models/tarjeta_cita.dart';

class PaginaCalendario extends StatefulWidget {
  const PaginaCalendario({super.key});

  @override
  State<PaginaCalendario> createState() => _PaginaCalendarioState();
}

class _PaginaCalendarioState extends State<PaginaCalendario> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Cita> _citasDelDiaSeleccionado = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // Inicializamos la lista de citas para el día actual
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _actualizarCitasSeleccionadas(_selectedDay!);
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _actualizarCitasSeleccionadas(selectedDay);
      });
    }
  }
  
  void _actualizarCitasSeleccionadas(DateTime dia) {
      final todasLasCitas = context.read<CitasViewModel>().citas;
      _citasDelDiaSeleccionado = todasLasCitas.where((cita) => isSameDay(cita.fecha, dia)).toList();
  }

  List<Cita> _getEventsForDay(DateTime day) {
    final viewModel = context.read<CitasViewModel>();
    return viewModel.citas.where((cita) => isSameDay(cita.fecha, day)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda en Calendario'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TableCalendar<Cita>(
            locale: 'es_ES', // Opcional: para formato en español
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
            headerStyle: HeaderStyle(
              // CORRECCIÓN: El parámetro ahora se llama `titleFormatter`
              titleTextFormatter: (date, locale) => DateFormat.yMMMM(locale).format(date),
              formatButtonVisible: false,
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _citasDelDiaSeleccionado.isEmpty
                ? const Center(child: Text('No hay citas para el día seleccionado.'))
                : ListView.builder(
                    itemCount: _citasDelDiaSeleccionado.length,
                    itemBuilder: (context, index) {
                      return TarjetaCita(cita: _citasDelDiaSeleccionado[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}