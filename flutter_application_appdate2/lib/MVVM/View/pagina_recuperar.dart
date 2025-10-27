import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/Service/validadores.dart';

class PaginaRecuperarContrasena extends StatefulWidget {
  const PaginaRecuperarContrasena({super.key});

  @override
  State<PaginaRecuperarContrasena> createState() => _PaginaRecuperarContrasenaState();
}

class _PaginaRecuperarContrasenaState extends State<PaginaRecuperarContrasena> {
  final _formKey = GlobalKey<FormState>();
  final _controladorCorreo = TextEditingController();

  @override
  void dispose() {
    _controladorCorreo.dispose();
    super.dispose();
  }

  void _enviarCodigo() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enviando código a ${_controladorCorreo.text}...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Contraseña'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Icon(
                  Icons.lock_reset,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ingresa tu correo electrónico y te enviaremos instrucciones para restablecerla.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _controladorCorreo,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  // Usamos el validador centralizado
                  validator: Validadores.validarCorreo,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _enviarCodigo,
                    child: const Text('ENVIAR INSTRUCCIONES'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}