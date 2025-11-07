import 'package:flutter/material.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/citas_view_model.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/servicios_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/Service/servicios_service.dart';
import 'package:flutter_application_appdate2/Service/citas_service.dart';
import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => ServiciosService()),
        Provider(create: (_) => CitasService()),
        
        ChangeNotifierProvider(
          create: (context) => ServiciosViewModel(context.read<ServiciosService>()),
        ),

        ChangeNotifierProvider(
          create: (context) => CitasViewModel(context.read<CitasService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}