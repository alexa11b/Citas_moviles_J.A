import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/Service/servicios_service.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/servicios_view_model.dart'; 
import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        
        Provider(create: (_) => ServiciosService()),

        ChangeNotifierProvider(
          create: (context) => ServiciosViewModel(context.read<ServiciosService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}