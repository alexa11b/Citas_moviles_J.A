import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/perfil.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';
import 'package:flutter_application_appdate2/Service/validadores.dart';


class FormularioPerfil extends StatefulWidget {
  final Usuario usuario;
  final Function(Perfil) alActualizarPerfil;
  final bool cargando;
  final String? error;

  const FormularioPerfil({
    super.key,
    required this.usuario,
    required this.alActualizarPerfil,
    required this.cargando,
    this.error,
  });

  @override
  State<FormularioPerfil> createState() => _FormularioPerfilState();
}

class _FormularioPerfilState extends State<FormularioPerfil> {
  final _formKey = GlobalKey<FormState>();
  final _controladorNombre = TextEditingController();
  final _controladorTelefono = TextEditingController();
  final _controladorCorreo = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  void _cargarDatosUsuario() {
    _controladorNombre.text = widget.usuario.nombre;
    _controladorCorreo.text = widget.usuario.correo;
    _controladorTelefono.text = widget.usuario.telefono;
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      final perfil = Perfil(
        usuarioId: widget.usuario.id,
        nombre: _controladorNombre.text.trim(),
        telefono: _controladorTelefono.text.trim(),
        correo: _controladorCorreo.text.trim(),
        tipoUsuario: widget.usuario.tipoUsuario,
      );
      
      widget.alActualizarPerfil(perfil);
    }
  }

  String? _validarTelefono(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El teléfono es requerido.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _controladorNombre,
            decoration: const InputDecoration(
              labelText: 'Nombre completo',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: Validadores.validarNombre,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controladorCorreo,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: Validadores.validarCorreo,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controladorTelefono,
            decoration: const InputDecoration(
              labelText: 'Teléfono',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            validator: _validarTelefono,
          ),
          const SizedBox(height: 24),
          if (widget.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                widget.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.cargando ? null : _enviarFormulario,
              child: widget.cargando
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('GUARDAR CAMBIOS'),
            ),
          ),
        ],
      ),
    );
  }
}