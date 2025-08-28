import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

//Main principal
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const H2OOptimizerApp());
}










//Clase que lleva encima todo el codigo
class H2OOptimizerApp extends StatelessWidget {
  const H2OOptimizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H2O Optimizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
    );
  }
}











//Esta es la definicion que hace que salga el logo al principio
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
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono del logo, puedes reemplazarlo con una imagen
            Icon(Icons.waves, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'H2O Optimizer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}











/*Aqui están los datos mi login mal hecho (Lo podes borrar para hacerlo de nuevo)*/
class UserData {
  static final UserData _instance = UserData._internal();
  factory UserData() {
    return _instance;
  }
  UserData._internal();

  String username = 'Leah';
  String password = 'password';
}

/*Aqui se define toda la pantalla del login 
(otra vez lo pode borrar y agregar el tuyo)*/
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

//Aqui está el codigo para el login (Borrable)
class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final userData = UserData();

    if (_usernameController.text == userData.username &&
        _passwordController.text == userData.password) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credenciales incorrectas. Inténtalo de nuevo.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Campo de texto para el usuario
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Campo de texto para la contraseña
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Oculta la contraseña
            ),
            const SizedBox(height: 16),
            // Botón de inicio de sesión
            ElevatedButton(
              onPressed: _login,
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}










//Aqui está el cambiar contraseña(Esta wea la vamos a cambiar despues)
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













//Definicion de la clase del perfil
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

//Aqui se sostiene el perfil de la persona (Le vamos a añadir mas cosas)
class _ProfileScreenState extends State<ProfileScreen> {
  // Lógica para cerrar sesión
  void _logout() {
    // Navega de regreso a la pantalla de inicio de sesión y reemplaza la ruta
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Sección del encabezado del perfil
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              UserData().username, // Lee el nombre de la variable compartida
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            // Secciones de configuración en formato de lista
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historial de Consumo'),
              onTap: () {
                // Navega a la nueva pantalla de historial
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ConsumptionHistoryScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () {
                // Navega a la nueva pantalla de notificaciones
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const NotificationsScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración de la Cuenta'),
              onTap: () async {
                // Espera a que la pantalla de configuración se cierre.
                await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const AccountSettingsScreen()),
                );
                // Vuelve a construir la pantalla para reflejar los cambios.
                setState(() {});
              },
            ),
            const Divider(),
            // Botón de cerrar sesión
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Cerrar Sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}










class ConsumptionHistoryScreen extends StatelessWidget {
  const ConsumptionHistoryScreen({super.key});

  // Datos de historial simulados
  final List<Map<String, dynamic>> _historyData = const [
    {
      'date': '2025-08-20',
      'volume': '10.5 m³',
      'details': 'Consumo diario promedio'
    },
    {
      'date': '2025-08-19',
      'volume': '9.8 m³',
      'details': 'Consumo diario promedio'
    },
    {
      'date': '2025-08-18',
      'volume': '11.2 m³',
      'details': 'Uso elevado detectado'
    },
    {
      'date': '2025-08-17',
      'volume': '9.3 m³',
      'details': 'Consumo diario promedio'
    },
    {
      'date': '2025-08-16',
      'volume': '8.9 m³',
      'details': 'Día con bajo consumo'
    },
    {
      'date': '2025-08-15',
      'volume': '10.1 m³',
      'details': 'Consumo diario promedio'
    },
    {
      'date': '2025-08-14',
      'volume': '9.7 m³',
      'details': 'Consumo diario promedio'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Consumo'),
      ),
      body: ListView.builder(
        itemCount: _historyData.length,
        itemBuilder: (context, index) {
          final entry = _historyData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.water_drop, color: Colors.blue),
              title: Text(entry['volume']),
              subtitle: Text('${entry['date']} - ${entry['details']}'),
              onTap: () {
                // Puedes agregar lógica para ver más detalles aquí
              },
            ),
          );
        },
      ),
    );
  }
}











class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // Datos de notificaciones simulados
  final List<Map<String, dynamic>> _notificationsData = const [
    {
      'type': 'Alerta',
      'title': 'Uso elevado de agua detectado',
      'message':
          'Tu consumo de hoy ha superado tu promedio. ¡Revisa tu consumo!',
      'icon': Icons.warning_amber,
      'color': Colors.red,
    },
    {
      'type': 'Consejo',
      'title': 'Consejo del día: Ahorra agua',
      'message':
          'Cierra el grifo mientras te cepillas los dientes para ahorrar agua.',
      'icon': Icons.lightbulb_outline,
      'color': Colors.amber,
    },
    {
      'type': 'Alerta',
      'title': 'Posible fuga detectada',
      'message':
          'Se ha detectado un patrón de consumo inusual. Revisa si hay fugas.',
      'icon': Icons.leak_add,
      'color': Colors.red,
    },
    {
      'type': 'Recordatorio',
      'title': 'Recordatorio de registro',
      'message': '¡No olvides registrar tu consumo de hoy!',
      'icon': Icons.calendar_today,
      'color': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
      ),
      body: ListView.builder(
        itemCount: _notificationsData.length,
        itemBuilder: (context, index) {
          final notification = _notificationsData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: Icon(
                notification['icon'],
                color: notification['color'],
              ),
              title: Text(
                notification['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notification['message']),
              trailing: Text(notification['type']),
              onTap: () {
                // Puedes agregar lógica para ver más detalles
              },
            ),
          );
        },
      ),
    );
  }
}










class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    _HomeContent(),
    _StatisticsContent(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              children: [
                Icon(Icons.water_drop, color: Colors.blue),
                SizedBox(width: 7),
                Text('H2O Optimizer', style: TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Estadísticas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}















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









// Pantallas de Estadísticas
class ETongueScreen extends StatelessWidget {
  const ETongueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor E-tounge'),
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
                    // Imagen del sensor. Por ahora, un placeholder.
                    // Aquí puedes usar un widget Image.asset o un SVG
                    Image.asset(
                      'assets/Etounge_logo.jpg',
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Sección de información del sabor
              const Text(
                'Sabor detectado',
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









class TemperatureScreen extends StatelessWidget {
  const TemperatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Temperatura'),
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
                    // Imagen del sensor de temperatura
                    Image.asset(
                      'assets/temperatura_logo.png',
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Sección de información de la temperatura
              const Text(
                'Temperatura detectada',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Color(0xFF63B9E9), // Color azul claro
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '23,4 °C',
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
                    'Normal',
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
                    '3,4 AU',
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








class TurbidityScreen extends StatelessWidget {
  const TurbidityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Turbidez'),
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
                      color: Color(0xFF63B9E9), // Color azul claro
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









class ElectrochemicalScreen extends StatelessWidget {
  const ElectrochemicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Electroquímicos'),
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
                    // Imagen del sensor electroquímico
                    Image.asset(
                      'assets/electro_logo.png',
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Sección de información del potencial
              const Text(
                'Potencial detectado',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Color(0xFF63B9E9), // Color azul claro
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '1,2 mV',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Divider(height: 32, thickness: 1),
              // Sección de clasificación
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Clasificación',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    'Oxidación',
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







class _StatisticsContent extends StatefulWidget {
  const _StatisticsContent({Key? key}) : super(key: key);

  @override
  _StatisticsContentState createState() => _StatisticsContentState();
}

class _StatisticsContentState extends State<_StatisticsContent> {
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






class _HomeContent extends StatelessWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('¡Hola Leah!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // Card de Consumo
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Tu consumo hoy',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: '9.3m³',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                                fontSize: 48, fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: '143 litros',
                                border: InputBorder.none),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const VerticalDivider(width: 1),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: '5% más', border: InputBorder.none),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Sección de "Consejo del día"
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Consejo del día',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text(
                              'Cierra el grifo mientras te cepillas los dientes para ahorrar 12 litros de agua'),
                        ],
                      ),
                    ),
                    const Icon(Icons.lightbulb_outline,
                        size: 50, color: Colors.amber),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Sección de "Resumen de Alertas"
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resumen de Alertas',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildAlertItem('Uso elevado de agua detectado'),
                    _buildAlertItem('Posible fuga'),
                    _buildAlertItem('Reduce tu consumo'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método auxiliar para construir cada ítem de alerta
  Widget _buildAlertItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.warning_amber, color: Colors.red),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
