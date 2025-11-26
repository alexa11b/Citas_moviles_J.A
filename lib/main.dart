import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_appdate2/data/datasource.dart';
import 'package:flutter_application_appdate2/Service/auth_service.dart';
import 'package:flutter_application_appdate2/Service/citas_service.dart';
import 'package:flutter_application_appdate2/Service/servicios_service.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/servicios_view_model.dart';
import 'package:flutter_application_appdate2/MVVM/View_Models/citas_view_model.dart';
import 'package:flutter_application_appdate2/Service/horario_service.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es_ES', null);

  await Supabase.initialize(
    url: 'https://mmulmtxcjovgfeigoozn.supabase.co',
    anonKey: 'sb_publishable_5gVByEyddq83Qss3qlyUCg_EZzi7_Pb',
  );
  runApp(const MyAppWithProviders());
}

class MyAppWithProviders extends StatelessWidget {
  const MyAppWithProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => SupabaseDataSource()),

        ChangeNotifierProvider(
          create: (context) => AuthService(context.read<SupabaseDataSource>()),
        ),
        Provider(
          create: (context) =>
              ServiciosService(context.read<SupabaseDataSource>()),
        ),
        Provider(
          create: (context) => CitasService(context.read<SupabaseDataSource>()),
        ),
        Provider(
          create: (context) =>
              HorarioService(context.read<SupabaseDataSource>()),
        ),

        ChangeNotifierProvider(
          create: (context) =>
              ServiciosViewModel(context.read<ServiciosService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => CitasViewModel(context.read<CitasService>()),
        ),
      ],
      child: const MyApp(),
    );
  }
}

final supabase = Supabase.instance.client;
