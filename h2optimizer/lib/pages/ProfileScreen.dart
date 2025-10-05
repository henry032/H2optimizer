import 'package:flutter/material.dart';
import 'package:h2optimizer/widgets/perfil/AccountSettingsScreen.dart';
import 'package:h2optimizer/widgets/perfil/NotificationsScreen.dart';
import 'package:h2optimizer/widgets/perfil/ConsumptionHistoryScreen.dart';
import 'package:h2optimizer/widgets/perfil/UserData.dart';
import 'package:h2optimizer/widgets/perfil/BluetoothConnectionScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Sección del encabezado del perfil
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              UserData().username, // Lee el nombre de la variable compartida
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            // Secciones de configuración en formato de lista
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historial de Consumo'),
              onTap: () {
                // Navega a la nueva pantalla de historial
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ConsumptionHistoryScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () {
                // Navega a la nueva pantalla de notificaciones
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const NotificationsScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración de la Cuenta'),
              onTap: () async {
                // Espera a que la pantalla de configuración se cierre.
                await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const AccountSettingsScreen()),
                );
                // Vuelve a construir la pantalla para reflejar los cambios.
                setState(() {});
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.bluetooth),
              title: const Text('Conexion Bluetooth'),
              onTap: () async {
                // Espera a que la pantalla de configuración se cierre.
                await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const Bluetoothconnectionscreen()),
                );
                // Vuelve a construir la pantalla para reflejar los cambios.
                setState(() {});
              },
            ),
            const Divider(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cerrar Sesión',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
