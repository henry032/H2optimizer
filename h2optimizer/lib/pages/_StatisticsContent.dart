import 'package:flutter/material.dart';
import 'package:h2optimizer/widgets/sensores/ETongueScreen.dart';
import 'package:h2optimizer/widgets/sensores/ElectrochemicalScreen.dart';
import 'package:h2optimizer/widgets/sensores/TemperatureScreen.dart';
import 'package:h2optimizer/widgets/sensores/TurbidityScreen.dart';

class StatisticsContent extends StatefulWidget {
  const StatisticsContent({Key? key}) : super(key: key);

  @override
  _StatisticsContentState createState() => _StatisticsContentState();
}

class _StatisticsContentState extends State<StatisticsContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            // Widget para fijar el tamaño
            width: 300, // Ancho deseado
            height: 150, // Alto deseado
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ETongueScreen()),
                );
              },
              child: const Text('E-tounge'),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            // Widget para fijar el tamaño
            width: 300,
            height: 150,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const TemperatureScreen()),
                );
              },
              child: const Text('Temperatura'),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            // Widget para fijar el tamaño
            width: 300,
            height: 150,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const TurbidityScreen()),
                );
              },
              child: const Text('Turbidez'),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            // Widget para fijar el tamaño
            width: 300,
            height: 150,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ElectrochemicalScreen()),
                );
              },
              child: const Text('Electroquímicos'),
            ),
          ),
        ],
      ),
    );
  }
}