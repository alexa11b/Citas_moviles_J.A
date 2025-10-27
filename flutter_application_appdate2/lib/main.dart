import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/login_view_model.dart';
import 'app.dart';

void main() {
  // Create AuthService instance first
  final authService = AuthService();
  
  runApp(
    MultiProvider(
      providers: [
        // Provide the instance, not create a new one
        ChangeNotifierProvider.value(value: authService),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(authService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}