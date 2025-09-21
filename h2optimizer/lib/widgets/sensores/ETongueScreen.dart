import 'package:flutter/material.dart';

class ETongueScreen extends StatelessWidget {
  const ETongueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Datos', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección de la imagen del sensor
              Center(
                child: Column(
                  children: [
                    const Text('Nivel de PH', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              Center(
                child: Column(
                  children: [
                    // Imagen del sensor. Por ahora, un placeholder.
                    // Aquí puedes usar un widget Image.asset o un SVG
                    Image.asset(
                      'assets/Ph.jpg',
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Sección de información del sabor
              const Text(
                'PH detectado',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Amargo',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Divider(height: 32, thickness: 1),
              // Sección de clasificación e intensidad
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Clasificación',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Amargo',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Intensidad',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    '3,2 AU',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}