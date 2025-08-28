import 'package:flutter/material.dart';
import 'UserData.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de la Cuenta'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Opción para cambiar la contraseña
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Cambiar Contraseña'),
              onTap: () {
                // Navega a la nueva pantalla de cambio de contraseña
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen()),
                );
              },
            ),
            const Divider(),
            // Opción para cambiar el correo electrónico
            ListTile(
              leading: const Icon(
                  Icons.person), // Icono de persona en lugar de email
              title: const Text('Cambiar Nombre de Usuario'),
              onTap: () {
                // Navega a la nueva pantalla de cambio de nombre de usuario
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ChangeUsernameScreen()),
                );
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class ChangeUsernameScreen extends StatefulWidget {
  const ChangeUsernameScreen({super.key});

  @override
  _ChangeUsernameScreenState createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _saveNewUsername() {
    final userData = UserData();

    if (_usernameController.text.isNotEmpty) {
      // Actualiza el nombre de usuario en la clase UserData
      userData.username = _usernameController.text;

      // Actualiza la pantalla del perfil para reflejar el cambio
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('¡Nombre de usuario cambiado exitosamente!')),
      );

      // Regresa a la pantalla de configuración
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('El nombre de usuario no puede estar vacío.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Nombre de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Nuevo Nombre de Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveNewUsername,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

//Esto tambien forma parte del cambiar contraseña
class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _saveNewPassword() {
    // Lógica simple para simular el cambio de contraseña
    if (_currentPasswordController.text == 'password') {
      // La contraseña actual es 'password'
      // Lógica de validación de la nueva contraseña (por ejemplo, longitud)
      if (_newPasswordController.text.length >= 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Contraseña cambiada exitosamente!')),
        );
        Navigator.of(context).pop(); // Vuelve a la pantalla anterior
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'La nueva contraseña debe tener al menos 6 caracteres.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La contraseña actual es incorrecta.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _currentPasswordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña Actual',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(
                labelText: 'Nueva Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveNewPassword,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}