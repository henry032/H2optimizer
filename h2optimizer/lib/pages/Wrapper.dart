import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:h2optimizer/pages/HomeScreen.dart';
import 'package:h2optimizer/pages/LoginScreen.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print('Auth state changed: ${snapshot.connectionState}');
          if (snapshot.hasData){
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}