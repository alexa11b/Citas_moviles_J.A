import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/MVVM/Models/servicio.dart';
import 'package:flutter_application_appdate2/Service/servicios_service.dart';
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
  final List<String> _categorias = [
    'Barbería',
    'Dentista',
    'Spa',
    'Masajes',
    'Estética',
    'Fitness',
    'Otros'
  ];

  @override
  void dispose() {
    _controladorNombre.dispose();
    _controladorDescripcion.dispose();
    _controladorDuracion.dispose();
    _controladorPrecio.dispose();
    super.dispose();
  }

  void _agregarServicio(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final authService = Provider.of<AuthService>(context, listen: false);
      final proveedorId = authService.usuarioActual!.id;
      
      final nuevoServicio = Servicio(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        proveedorId: proveedorId, // ✅ Esto debería funcionar si el modelo Servicio tiene proveedorId
        nombre: _controladorNombre.text.trim(),
        descripcion: _controladorDescripcion.text.trim(),
        duracion: int.tryParse(_controladorDuracion.text) ?? 30,
        precio: double.tryParse(_controladorPrecio.text) ?? 0.0,
        categoria: _categoriaSeleccionada,
        nombreProveedor: authService.usuarioActual!.nombre,
      );

      final viewModel = Provider.of<ServiciosViewModel>(context, listen: false);
      viewModel.agregarServicio(nuevoServicio).then((_) {
        if (viewModel.error == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Servicio agregado correctamente'),
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
      create: (context) => ServiciosViewModel(ServiciosService()),
      child: Scaffold(
        // ... resto del código igual
      ),
    );
  }
}