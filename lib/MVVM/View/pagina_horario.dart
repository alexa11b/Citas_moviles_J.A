import 'package:flutter/material.dart';

class PaginaHorario extends StatelessWidget {
  const PaginaHorario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horario'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Marzo de 2024',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['L', 'M', 'M', 'J', 'V', 'S', 'D']
                  .map((dia) => Expanded(
                    child: Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        dia,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
                  .toList(),
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _ItemHorario(dia: 'Lunes', horario: '9:00 AM - 6:00 PM'),
                _ItemHorario(dia: 'Martes', horario: '9:00 AM - 6:00 PM'),
                _ItemHorario(dia: 'Miércoles', horario: '9:00 AM - 6:00 PM'),
                _ItemHorario(dia: 'Jueves', horario: '9:00 AM - 6:00 PM'),
                _ItemHorario(dia: 'Viernes', horario: '9:00 AM - 6:00 PM'),
                _ItemHorario(dia: 'Sábado', horario: '10:00 AM - 2:00 PM'),
                _ItemHorario(dia: 'Domingo', horario: 'Cerrado'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemHorario extends StatelessWidget {
  final String dia;
  final String horario;

  const _ItemHorario({
    required this.dia,
    required this.horario,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(dia),
        subtitle: Text(horario),
        trailing: Icon(Icons.edit),
        onTap: () {
        },
      ),
    );
  }
}