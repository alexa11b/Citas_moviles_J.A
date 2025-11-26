import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/servicios_view_model.dart';

class PaginaAgregarServicio extends StatefulWidget {
  const PaginaAgregarServicio({super.key});

  @override
  State<PaginaAgregarServicio> createState() => _PaginaAgregarServicioState();
}

class _PaginaAgregarServicioState extends State<PaginaAgregarServicio> {
  final _formKey = GlobalKey<FormState>();
  final _controladorNombre = TextEditingController();
  final _controladorDescripcion = TextEditingController();
  final _controladorDuracion = TextEditingController();
  final _controladorPrecio = TextEditingController();
  String _categoriaSeleccionada = 'Barbería';
  final List<String> _categorias = ['Barbería', 'Dentista', 'Spa', 'Masajes', 'Estética', 'Fitness', 'Otros'];

  @override
  void dispose() {
    _controladorNombre.dispose();
    _controladorDescripcion.dispose();
    _controladorDuracion.dispose();
    _controladorPrecio.dispose();
    super.dispose();
  }

  void _agregarServicio() {
    if (_formKey.currentState!.validate()) {
      final authService = context.read<AuthService>();
      
      final nuevoServicio = Servicio(
        id: '', // El ID se genera en el servicio
        proveedorId: authService.usuarioActual!.id,
        nombre: _controladorNombre.text.trim(),
        descripcion: _controladorDescripcion.text.trim(),
        duracion: int.tryParse(_controladorDuracion.text) ?? 30,
        precio: double.tryParse(_controladorPrecio.text) ?? 0.0,
        categoria: _categoriaSeleccionada,
        nombreProveedor: authService.usuarioActual!.nombre,
      );

      final viewModel = context.read<ServiciosViewModel>();
      viewModel.agregarServicio(nuevoServicio).then((_) {
        if (mounted && viewModel.error == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Servicio agregado con éxito'), backgroundColor: Colors.green),
          );
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Usamos context.watch para que la UI se reconstruya si el estado (ej. 'cargando') cambia.
    final viewModel = context.watch<ServiciosViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Nuevo Servicio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _controladorNombre,
                decoration: const InputDecoration(labelText: 'Nombre del Servicio', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'El nombre es requerido' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _categoriaSeleccionada,
                decoration: const InputDecoration(labelText: 'Categoría', border: OutlineInputBorder()),
                items: _categorias.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                onChanged: (value) => setState(() => _categoriaSeleccionada = value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controladorDescripcion,
                decoration: const InputDecoration(labelText: 'Descripción', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'La descripción es requerida' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controladorDuracion,
                      decoration: const InputDecoration(labelText: 'Duración (min)', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Requerido' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _controladorPrecio,
                      decoration: const InputDecoration(labelText: 'Precio (\$)', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Requerido' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (viewModel.error != null)
                Text(viewModel.error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: viewModel.cargando ? null : _agregarServicio,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: viewModel.cargando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('GUARDAR SERVICIO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}