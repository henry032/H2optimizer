import 'dart:async';
import 'package:flutter/material.dart';
import 'package:h2optimizer/pages/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

//Esto hace que salga el logo al principio
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simula una pantalla de carga por 3 segundos
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Wrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono del logo, puedes reemplazarlo con una imagen
            Image.asset("assets/appLogo.png"),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}