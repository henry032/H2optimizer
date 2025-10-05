// Archivo: main.dart
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:h2optimizer/pages/HomeScreen.dart';
import 'package:h2optimizer/pages/LoginScreen.dart';
import 'package:h2optimizer/pages/ProfileScreen.dart';
import 'package:h2optimizer/pages/SplashScreen.dart';
import 'package:h2optimizer/pages/_StatisticsContent.dart';
import 'package:h2optimizer/widgets/perfil/AccountSettingsScreen.dart';
import 'package:h2optimizer/widgets/perfil/ConsumptionHistoryScreen.dart';
import 'package:h2optimizer/widgets/perfil/NotificationsScreen.dart';
import 'package:h2optimizer/widgets/sensores/sensor_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const H2OOptimizerApp());
}

class H2OOptimizerApp extends StatelessWidget {
  const H2OOptimizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: SplashScreen(),
        routes: {
          '': (context) => const SplashScreen(),
          'login': (context) => const LoginScreen(),
          'home': (context) => const HomeScreen(),
          'profile': (context) => const ProfileScreen(),
          'statistics': (context) => StatisticsContent(
                data: SensorData(
                    ph: 0.0,
                    flowRate: 0.0,
                    volume: 0.0,
                    tds: 0.0,
                    turbidity: 0.0,
                    orp: 0.0),
              ),
          'account_settings': (context) => const AccountSettingsScreen(),
          'consumption_history': (context) => const ConsumptionHistoryScreen(),
          'notifications': (context) => const NotificationsScreen(),
        },
        debugShowCheckedModeBanner: false);
  }
}
