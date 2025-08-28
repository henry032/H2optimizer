import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // Datos de notificaciones simulados
  final List<Map<String, dynamic>> _notificationsData = const [
    {
      'type': 'Alerta',
      'title': 'Uso elevado de agua detectado',
      'message':
          'Tu consumo de hoy ha superado tu promedio. ¡Revisa tu consumo!',
      'icon': Icons.warning_amber,
      'color': Colors.red,
    },
    {
      'type': 'Consejo',
      'title': 'Consejo del día: Ahorra agua',
      'message':
          'Cierra el grifo mientras te cepillas los dientes para ahorrar agua.',
      'icon': Icons.lightbulb_outline,
      'color': Colors.amber,
    },
    {
      'type': 'Alerta',
      'title': 'Posible fuga detectada',
      'message':
          'Se ha detectado un patrón de consumo inusual. Revisa si hay fugas.',
      'icon': Icons.leak_add,
      'color': Colors.red,
    },
    {
      'type': 'Recordatorio',
      'title': 'Recordatorio de registro',
      'message': '¡No olvides registrar tu consumo de hoy!',
      'icon': Icons.calendar_today,
      'color': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
      ),
      body: ListView.builder(
        itemCount: _notificationsData.length,
        itemBuilder: (context, index) {
          final notification = _notificationsData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: Icon(
                notification['icon'],
                color: notification['color'],
              ),
              title: Text(
                notification['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notification['message']),
              trailing: Text(notification['type']),
              onTap: () {
                // Puedes agregar lógica para ver más detalles
              },
            ),
          );
        },
      ),
    );
  }
}