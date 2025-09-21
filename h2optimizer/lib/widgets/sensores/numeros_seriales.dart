import 'dart:async'; // Necesario para el Timer
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const H2OOptimizerApp());
}

// ===== Modelo de Datos (Sin cambios) =====
class DataSensores {
  final double ph;
  final double caudal;
  final double volumen;
  final double tds;
  final double turbidez;
  final double orp;

  const DataSensores({
    required this.ph,
    required this.caudal,
    required this.volumen,
    required this.tds,
    required this.turbidez,
    required this.orp,
  });

  factory DataSensores.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'PH':       num ph,
        'Caudal':   num caudal,
        'Volumen':  num volumen,
        'TDS':      num tds,
        'Turbidez': num turbidez,
        'ORP':      num orp,
      } =>
        DataSensores(
          ph: ph.toDouble(),
          caudal: caudal.toDouble(),
          volumen: volumen.toDouble(),
          tds: tds.toDouble(),
          turbidez: turbidez.toDouble(),
          orp: orp.toDouble(),
        ),
      _ => throw const FormatException('Failed to load sensor data.'),
    };
  }
}

// ===== Widget Principal =====
class H2OOptimizerApp extends StatelessWidget {
  const H2OOptimizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H2Optimizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar( 
          title: Text('Monitor de Sensores H2Optimizer'),
        ), 
        body: Center(
          child: SensorDataWidget(), // Widget que manejará el estado
        ),
      ),
    );
  }
}

// ===== Widget que muestra los datos y se actualiza =====
class SensorDataWidget extends StatefulWidget {
  const SensorDataWidget({super.key});

  @override
  State<SensorDataWidget> createState() => _SensorDataWidgetState();
}

class _SensorDataWidgetState extends State<SensorDataWidget> {
  // En lugar de un Future, manejamos los datos directamente
  DataSensores? _dataSensores;
  String? _error;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Inicia la primera carga de datos
    _fetchData();
    // Configura un Timer para actualizar los datos cada 5 segundos
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) => _fetchData());
  }

  @override
  void dispose() {
    // Es MUY IMPORTANTE cancelar el timer para evitar fugas de memoria
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://949ea4d8ec44.ngrok-free.app/data'),
        headers: {
          "ngrok-skip-browser-warning": "true", // Cabecera para Ngrok
        },
      );

      if (response.statusCode == 200) {
        final newData = DataSensores.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
        // Actualiza el estado y redibuja la pantalla con los nuevos datos
        if (mounted) {
          setState(() {
            _dataSensores = newData;
            _error = null;
          });
        }
      } else {
        throw Exception('Fallo al cargar los datos. Código: ${response.statusCode}');
      }
    } catch (e) {
      // Si hay un error, lo guardamos para mostrarlo en pantalla
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mostramos diferentes widgets según el estado
    if (_dataSensores != null) {
      // Si tenemos datos, los mostramos
      final d = _dataSensores!;
      return Text(
        'PH: ${d.ph}\n'
        'Caudal: ${d.caudal}\n'
        'Volumen: ${d.volumen}\n'
        'TDS: ${d.tds}\n'
        'Turbidez: ${d.turbidez}\n'
        'ORP: ${d.orp}',
        style: const TextStyle(fontSize: 20),
      );
    } else if (_error != null) {
      // Si hay un error, lo mostramos
      return Text(
        'Error al cargar los datos:\n$_error',
        style: const TextStyle(color: Colors.red, fontSize: 16),
        textAlign: TextAlign.center,
      );
    }
    // Mientras no haya datos ni error, mostramos un indicador de carga
    return const CircularProgressIndicator();
  }
}