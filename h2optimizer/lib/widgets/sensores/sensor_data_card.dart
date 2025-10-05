import 'package:flutter/material.dart';
import 'sensor_data_model.dart';

class SensorDataCard extends StatelessWidget {
  final SensorData data;

  const SensorDataCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lectura de Sensores',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),
            _buildSensorRow('pH', data.ph.toStringAsFixed(2), ''),
            _buildSensorRow('Caudal', data.flowRate.toStringAsFixed(2), 'L/m'),
            _buildSensorRow('Volumen', data.volume.toStringAsFixed(2), 'L'),
            _buildSensorRow('TDS', data.tds.toStringAsFixed(2), 'ppm'),
            _buildSensorRow(
                'Turbidez', data.turbidity.toStringAsFixed(2), 'NTU'),
            _buildSensorRow('ORP', data.orp.toStringAsFixed(2), 'mV'),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorRow(String label, String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(
            '$value $unit',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
