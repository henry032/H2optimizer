import 'package:flutter/material.dart';

class ConsumptionHistoryScreen extends StatelessWidget {
  const ConsumptionHistoryScreen({super.key});

  // Datos de historial simulados
  final List<Map<String, dynamic>> _historyData = const [
    {
      'date': '2025-08-20',
      'volume': '10.5 m³',
      'details': 'Consumo diario promedio'
    },
    {
      'date': '2025-08-19',
      'volume': '9.8 m³',
      'details': 'Consumo diario promedio'
    },
    {
      'date': '2025-08-18',
      'volume': '11.2 m³',
      'details': 'Uso elevado detectado'
    },
    {
      'date': '2025-08-17',
      'volume': '9.3 m³',
      'details': 'Consumo diario promedio'
    },
    {
      'date': '2025-08-16',
      'volume': '8.9 m³',
      'details': 'Día con bajo consumo'
    },
    {
      'date': '2025-08-15',
      'volume': '10.1 m³',
      'details': 'Consumo diario promedio'
    },
    {
      'date': '2025-08-14',
      'volume': '9.7 m³',
      'details': 'Consumo diario promedio'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Consumo'),
      ),
      body: ListView.builder(
        itemCount: _historyData.length,
        itemBuilder: (context, index) {
          final entry = _historyData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.water_drop, color: Colors.blue),
              title: Text(entry['volume']),
              subtitle: Text('${entry['date']} - ${entry['details']}'),
              onTap: () {
                // Puedes agregar lógica para ver más detalles aquí
              },
            ),
          );
        },
      ),
    );
  }
}