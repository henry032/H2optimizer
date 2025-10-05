import 'dart:convert';

// Representa la estructura de datos de las 6 señales enviadas por el script de Arduino.
class SensorData {
  final double ph;
  final double flowRate;
  final double volume;
  final double tds;
  final double turbidity;
  final double orp;

  SensorData({
    required this.ph,
    required this.flowRate,
    required this.volume,
    required this.tds,
    required this.turbidity,
    required this.orp,
  });

  /// Factory constructor to create an instance from a JSON string.
  /// It handles parsing the string values sent by the Arduino into doubles.
  factory SensorData.fromJson(String jsonString) {
    try {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Helper function to safely parse a string to a double
      double safeParse(dynamic value) =>
          double.tryParse(value.toString()) ?? 0.0;

      return SensorData(
        ph: safeParse(jsonMap['signal1']),
        flowRate: safeParse(jsonMap['signal2']),
        volume: safeParse(jsonMap['signal3']),
        tds: safeParse(jsonMap['signal4']),
        turbidity: safeParse(jsonMap['signal5']),
        orp: safeParse(jsonMap['signal6']),
      );
    } catch (e) {
      // Return a default instance if JSON parsing fails
      return SensorData.initial();
    }
  }

  // Constructor Factory para la inicialización default antes de que se hayan recibido
  //datos.
  factory SensorData.initial() {
    return SensorData(
      ph: 0.0,
      flowRate: 0.0,
      volume: 0.0,
      tds: 0.0,
      turbidity: 0.0,
      orp: 0.0,
    );
  }
}
