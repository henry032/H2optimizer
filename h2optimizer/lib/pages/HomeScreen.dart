import 'package:flutter/material.dart';
import '_StatisticsContent.dart';
import 'ProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/sensores/sensor_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  int _selectedIndex = 0;

  // Ponemos ProfileScreen en su propia variable para poder usarla en el Stack
  static final List<Widget> _widgetOptions = <Widget>[
    _HomeContent(),
    StatisticsContent(
        data: SensorData(
            ph: 0.0,
            flowRate: 0.0,
            volume: 0.0,
            tds: 0.0,
            turbidity: 0.0,
            orp: 0.0)),
    const ProfileScreen(), // Usamos el widget directamente
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- Calculamos el ancho del item para ambos diseños ---
    final screenWidthWithoutPadding =
        MediaQuery.of(context).size.width - (24.0 * 2);
    final double itemWidth = screenWidthWithoutPadding / _widgetOptions.length;

    // --- Usamos una condición para cambiar el diseño ---
    if (_selectedIndex == 2) {
      // --- DISEÑO ESPECIAL PARA LA PANTALLA DE PERFIL (index == 2) ---
      return Scaffold(
        extendBody: true,
        // El AppBar de ProfileScreen ya está dentro de su propio archivo
        // por lo que no necesitamos uno aquí, para evitar duplicados.
        appBar: null,
        body: Stack(
          children: [
            // CAPA 1: La pantalla de Perfil
            _widgetOptions.elementAt(_selectedIndex),

            // CAPA 2: La ola en el fondo
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/olas.png',
                fit: BoxFit.fill,
                height: 250,
              ),
            ),

            // CAPA 3: La barra de navegación flotante
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildFloatingNavBar(
                  context, itemWidth), // Usamos un método reutilizable
            ),
          ],
        ),
        bottomNavigationBar: null,
      );
    } else {
      // --- DISEÑO NORMAL PARA LAS OTRAS PANTALLAS (index == 0 o 1) ---
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/appLogo.png',
                height: 50,
              ),
            ],
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar:
            _buildFloatingNavBar(context, itemWidth), // Usamos el mismo método
      );
    }
  }

  // --- MÉTODO REUTILIZABLE PARA CONSTRUIR LA BARRA DE NAVEGACIÓN ---
  Widget _buildFloatingNavBar(BuildContext context, double itemWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 9, 77, 178),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: _selectedIndex * itemWidth,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  _buildNavItem(0, Icons.home, 'Inicio', itemWidth),
                  _buildNavItem(1, Icons.show_chart, 'Estadísticas', itemWidth),
                  _buildNavItem(2, Icons.person, 'Perfil', itemWidth),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, String label, double itemWidth) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: itemWidth,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: _selectedIndex == index ? Colors.white : Colors.white70,
            ),
            Text(
              label,
              style: TextStyle(
                color: _selectedIndex == index ? Colors.white : Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 8,
              color: const Color.fromARGB(255, 109, 187, 251),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Tu consumo hoy',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: '9.3m³',
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Divider(
                        thickness: 1, color: Color.fromARGB(255, 98, 98, 98)),
                    const SizedBox(height: 2),
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
                        const SizedBox(
                          height: 40,
                          child: VerticalDivider(
                            color: Color.fromARGB(
                                255, 98, 98, 98), // Color del divisor
                            thickness: 1.5, // Grosor del divisor
                            width:
                                32, // Espacio horizontal reservado para el divisor
                          ),
                        ),
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
              color: const Color.fromARGB(255, 109, 187, 251),
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
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Divider(
                              thickness: 1,
                              color: Color.fromARGB(255, 98, 98, 98)),
                          const SizedBox(height: 8),
                          const Text(
                            'Cierra el grifo mientras te cepillas los dientes para ahorrar 12 litros de agua',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
              color: const Color.fromARGB(255, 109, 187, 251),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Resumen de Alertas',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 98, 98, 98),
                    ),
                    _buildAlertItem(
                      'Uso elevado de agua detectado',
                    ),
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
          const Icon(Icons.warning_amber, color: Colors.black),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
