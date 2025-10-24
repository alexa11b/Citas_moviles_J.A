import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/View/pagina_inicio.dart';
import 'package:flutter_application_appdate2/MVVM/View/pagina_login.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: true);

    return MaterialApp(
      title: 'Citas Multi-Servicios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: authService.usuarioActual != null ? const PaginaInicio() : const PaginaLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}