// Archivo: main.dart

import 'package:flutter/material.dart';
import 'package:h2optimizer/pages/HomeScreen.dart';
import 'package:h2optimizer/pages/LoginScreen.dart';
import 'package:h2optimizer/pages/ProfileScreen.dart';
import 'package:h2optimizer/pages/SplashScreen.dart';
import 'package:h2optimizer/pages/_StatisticsContent.dart';
import 'package:h2optimizer/widgets/perfil/AccountSettingsScreen.dart';
import 'package:h2optimizer/widgets/perfil/ConsumptionHistoryScreen.dart';
import 'package:h2optimizer/widgets/perfil/NotificationsScreen.dart';


void main() {
  runApp(const H2OOptimizerApp());
  
}

class H2OOptimizerApp extends StatelessWidget {
  const H2OOptimizerApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // La ruta inicial de la aplicación.
      initialRoute: '/',
      // Un mapa que define las rutas con nombre para cada pantalla.
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/statistics': (context) => const StatisticsContent(),
        '/account_settings': (context) => const AccountSettingsScreen(),
        '/consumption_history': (context) => const ConsumptionHistoryScreen(),
        '/notifications': (context) => const NotificationsScreen(),
      },
      debugShowCheckedModeBanner: false
    );
  }
}