import 'package:flutter/material.dart';

class FormularioLogin extends StatefulWidget {
  final Future<bool> Function(String, String) alIniciarSesion;
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

  Future<void> _enviarFormulario() async {
    if (_formKey.currentState!.validate()) {
      final correo = _controladorCorreo.text.trim();
      final pass = _controladorContrasena.text;
      final success = await widget.alIniciarSesion(correo, pass);
      if (!success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.error ?? 'Error al iniciar sesión')),
        );
      }
    }
  }

  String? _validarCorreo(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo electrónico es requerido';
    }
    if (!value.contains('@')) {
      return 'Introduce un correo válido';
    }
    return null;
  }

  String? _validarContrasena(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 4) {
      return 'La contraseña es muy corta';
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
            controller: _controladorCorreo,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            validator: _validarCorreo,
            keyboardType: TextInputType.emailAddress,
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
            validator: _validarContrasena,
          ),
          const SizedBox(height: 24),
          if (widget.error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(4),
                color: Colors.red.withOpacity(0.05),
              ),
              child: Text(
                widget.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          if (widget.error != null) const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.cargando ? null : _enviarFormulario,
              child: widget.cargando
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Iniciar sesión'),
            ),
          ),
        ],
      ),
    );
  }
}