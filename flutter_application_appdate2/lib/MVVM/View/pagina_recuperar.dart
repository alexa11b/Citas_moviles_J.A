import 'package:flutter/material.dart';

class PaginaRecuperarContrasena extends StatelessWidget {
  const PaginaRecuperarContrasena({super.key});

  void _regresarALogin(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _regresarALogin(context),
        ),
        title: Text('Recuperar Contraseña'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 20),
              
              // Icono
              Icon(
                Icons.lock_reset,
                size: 80,
                color: Colors.blue,
              ),
              
              SizedBox(height: 16),
              
              // Título
              Text(
                'Recuperar Contraseña',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 32),
              
              // Mensaje informativo
              Text(
                'Ingresa tu correo electrónico y te enviaremos un código de verificación para restablecer tu contraseña.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              
              SizedBox(height: 24),
              
              // Campo de correo
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              
              SizedBox(height: 24),
              
              // Botón de enviar código
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica de recuperación
                  },
                  child: Text('ENVIAR CÓDIGO'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}