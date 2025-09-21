import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:h2optimizer/pages/SignupScreen.dart';

//import 'package:h2optimizer/main.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); 

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//Aqui está el codigo para el login (Borrable)
class _LoginScreenState extends State<LoginScreen> {
  
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  
  signIn() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de olas en la parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/olas.png", // Cambia la ruta si tu imagen tiene otro nombre o ubicación
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          // Contenido principal centrado
          Center(
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
              children: [
                Image.asset(
                  "assets/appLogo.png",
                  width: 200,
                  height: 300,
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: email,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: "Correo electrónico",
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: password,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: "Contraseña",
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: 230,   // Ancho deseado
                  height: 55,   // Alto deseado
                  child: ElevatedButton(
                    onPressed: signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 13, 47, 170), // Color de fondo azul claro
                      foregroundColor: Colors.white, // Color del texto blanco
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), 
                      ),
                    ),
                    child: Text("Iniciar sesión"),
                  ),
                ),

                SizedBox(height: 16), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿Nuevo usuario? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupScreen()),
                        );
                      },
                      child: Text(
                        "Registrarse",
                        style: TextStyle(
                          color: Color.fromARGB(255, 13, 47, 170),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                  const SizedBox(
                    width: 280, // Ancho consistente con los campos de texto
                    child: Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'O',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}