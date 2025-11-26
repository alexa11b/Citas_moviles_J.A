import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/Service/validadores.dart';

typedef RegistrarCallback = Future<void> Function(
    String nombre, String correo, String telefono, String contrasena);

class FormularioRegistro extends StatefulWidget {
  final RegistrarCallback alRegistrar;
  final bool cargando;
  final String? error;

  const FormularioRegistro({
    super.key,
    required this.alRegistrar,
    required this.cargando,
    this.error,
  });

  @override
  State<FormularioRegistro> createState() => _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  final _formKey = GlobalKey<FormState>();
  final _controladorNombre = TextEditingController();
  final _controladorCorreo = TextEditingController();
  final _controladorTelefono = TextEditingController();
  final _controladorContrasena = TextEditingController();
  final _controladorConfirmarContrasena = TextEditingController();

  @override
  void dispose() {
    _controladorNombre.dispose();
    _controladorCorreo.dispose();
    _controladorTelefono.dispose();
    _controladorContrasena.dispose();
    _controladorConfirmarContrasena.dispose();
    super.dispose();
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      widget.alRegistrar(
        _controladorNombre.text.trim(),
        _controladorCorreo.text.trim(),
        _controladorTelefono.text.trim(),
        _controladorContrasena.text,
      );
    }
  }

  String? _validarConfirmarContrasena(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirma tu contraseña.';
    }
    if (value != _controladorContrasena.text) {
      return 'Las contraseñas no coinciden.';
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
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'El teléfono es requerido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controladorContrasena,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: Validadores.validarContrasena,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controladorConfirmarContrasena,
            decoration: const InputDecoration(
              labelText: 'Confirmar contraseña',
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: _validarConfirmarContrasena,
          ),
          const SizedBox(height: 24),
          if (widget.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(widget.error!, style: const TextStyle(color: Colors.red)),
            ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.cargando ? null : _enviarFormulario,
              child: widget.cargando
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('REGISTRARSE'),
            ),
          ),
        ],
      ),
    );
  }
}