import 'package:flutter/material.dart';

class FormularioLogin extends StatefulWidget {
  final Function(String, String) alIniciarSesion;
  final bool cargando;
  final String? error;

  const FormularioLogin({
    super.key,
    required this.alIniciarSesion,
    required this.cargando,
    this.error,
  });

  @override
  State<FormularioLogin> createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final _formKey = GlobalKey<FormState>();
  final _controladorCorreo = TextEditingController();
  final _controladorContrasena = TextEditingController();

  @override
  void dispose() {
    _controladorCorreo.dispose();
    _controladorContrasena.dispose();
    super.dispose();
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      widget.alIniciarSesion(
        _controladorCorreo.text.trim(),
        _controladorContrasena.text,
      );
    }
  }

  String? _validarCorreo(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo es requerido';
    }
    return null;
  }

  String? _validarContrasena(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Campo de correo
          TextFormField(
            controller: _controladorCorreo,
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            validator: _validarCorreo,
          ),
          
          SizedBox(height: 16),
          
          // Campo de contraseña
          TextFormField(
            controller: _controladorContrasena,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: _validarContrasena,
          ),
          
          SizedBox(height: 24),
          
          // Mostrar error
          if (widget.error != null)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: Text(widget.error!),
            ),
          
          if (widget.error != null) SizedBox(height: 16),
          
          // Botón
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.cargando ? null : _enviarFormulario,
              child: widget.cargando
                  ? CircularProgressIndicator()
                  : Text('INICIAR SESIÓN'),
            ),
          ),
        ],
      ),
    );
  }
}