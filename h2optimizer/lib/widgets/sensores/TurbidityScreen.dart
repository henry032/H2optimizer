import 'package:flutter/material.dart';

class TurbidityScreen extends StatelessWidget {
  const TurbidityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Datos',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Center(
                child: Column(
                  children: [
                    const Text('Turbidez',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              Center(
                child: Column(
                  children: [
                    // Imagen del sensor de turbidez
                    Image.asset(
                      'assets/turbidez_logo.png',
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Sección de información de la turbidez
              const Text(
                'Turbidez detectada',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.orange, // Color azul claro
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '5,8 NTU',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Divider(height: 32, thickness: 1),
              // Sección de intensidad
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Clasificación',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Aceptable',
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