import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/Models/perfil.dart';
import 'package:flutter_application_appdate2/MVVM/Models/usuario.dart';

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
      //  Crear Perfil a partir del Usuario
      final perfil = Perfil(
        usuarioId: widget.usuario.id,
        nombre: _controladorNombre.text.trim(),
        telefono: _controladorTelefono.text.trim(),
        correo: _controladorCorreo.text.trim(),
        tipoUsuario: 'cliente',
      );
      
      widget.alActualizarPerfil(perfil);
    }
  }

  String? _validarNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre es requerido';
    }
    return null;
  }

  String? _validarCorreo(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo es requerido';
    }
    
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return 'Ingrese un correo electrónico válido';
    }
    
    return null;
  }

  String? _validarTelefono(String? value) {
    if (value == null || value.isEmpty) {
      return 'El teléfono es requerido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Campo de nombre
          TextFormField(
            controller: _controladorNombre,
            decoration: const InputDecoration(
              labelText: 'Nombre completo',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: _validarNombre,
          ),
          
          const SizedBox(height: 16),
          
          // Campo de correo
          TextFormField(
            controller: _controladorCorreo,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: _validarCorreo,
          ),
          
          const SizedBox(height: 16),
          
          // Campo de teléfono
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
          
          // Mostrar error
          if (widget.error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: Text(
                widget.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          
          if (widget.error != null) const SizedBox(height: 16),
          
          // Botón de guardar
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
                  : const Text(
                      'GUARDAR CAMBIOS',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}