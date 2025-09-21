import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controladores para los campos de texto
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  // Variable para gestionar el estado de carga
  bool _isLoading = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  /// Función para manejar el registro de un nuevo usuario.
  Future<void> signUP() async {
    // Usamos 'mounted' para asegurarnos de que el widget todavía existe
    // antes de intentar actualizar el estado o navegar.
    if (!mounted) return;

    // Validar que las contraseñas coincidan
    if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    // Iniciar el estado de carga para mostrar el indicador
    setState(() {
      _isLoading = true;
    });

    try {
      // Intentar crear el usuario con email y contraseña en Firebase
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(), // .trim() elimina espacios en blanco
        password: password.text,
      );

      // ¡LÍNEA CLAVE! Si el registro es exitoso, cerramos esta pantalla.
      // El widget 'Wrapper' detectará el cambio de autenticación
      // y mostrará automáticamente la 'HomeScreen'.
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // Manejar errores específicos de Firebase de forma amigable
      String message = 'Ocurrió un error inesperado.';
      if (e.code == 'weak-password') {
        message = 'La contraseña proporcionada es muy débil.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Ya existe una cuenta para ese correo electrónico.';
      } else if (e.code == 'invalid-email') {
        message = 'El formato del correo electrónico no es válido.';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      // Capturar cualquier otro error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }

    // Detener el estado de carga, tanto si hubo éxito como si hubo error
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/olas.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/appLogo.png",
                    width: 200,
                    height: 300,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: "Correo electrónico",
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: password,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Contraseña",
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: confirmPassword,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Confirmar contraseña",
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : signUP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 13, 47, 170),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        shape:const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text("Registrarse"),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿Usuario Existente? "),
                      GestureDetector(
                        onTap: () {
                          // Si el usuario ya tiene cuenta, simplemente cerramos esta pantalla
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Iniciar Sesión",
                          style: TextStyle(
                            color: Color.fromARGB(255, 13, 47, 170),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}