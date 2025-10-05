import 'package:flutter/material.dart';
import 'package:h2optimizer/widgets/sensores/ETongueScreen.dart';
import 'package:h2optimizer/widgets/sensores/ElectrochemicalScreen.dart';
import 'package:h2optimizer/widgets/sensores/TemperatureScreen.dart';
import 'package:h2optimizer/widgets/sensores/TurbidityScreen.dart';
import '../widgets/sensores/sensor_data_model.dart';

class StatisticsContent extends StatefulWidget {
  final SensorData data;

  const StatisticsContent({Key? key, required this.data}) : super(key: key);

  @override
  _StatisticsContentState createState() => _StatisticsContentState();
}

class _StatisticsContentState extends State<StatisticsContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            // Widget para fijar el tamaño
            width: 325, // Ancho deseado
            height: 70, // Alto deseado
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Color de fondo azul
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ETongueScreen()),
                );
              },
              child: const Text(
                'PH',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            // Widget para fijar el tamaño
            width: 325,
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Color de fondo azul
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const TemperatureScreen()),
                );
              },
              child: const Text(
                'ORP-Contaminación',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            // Widget para fijar el tamaño
            width: 325,
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Color de fondo azul
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      // ignore: prefer_const_constructors
                      builder: (context) => TurbidityScreen(
                            data: SensorData(
                                ph: 0.0,
                                flowRate: 0.0,
                                volume: 0.0,
                                tds: 0.0,
                                turbidity: 0.0,
                                orp: 0.0),
                          )),
                );
              },
              child: const Text(
                'Turbidez',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            // Widget para fijar el tamaño
            width: 325,
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Color de fondo azul
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ElectrochemicalScreen()),
                );
              },
              child: const Text(
                'Conductividad',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
