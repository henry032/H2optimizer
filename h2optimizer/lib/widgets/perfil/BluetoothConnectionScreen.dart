import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bluetooth_manager.dart';
import '../sensores/sensor_data_card.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BluetoothManager(),
      child: const Bluetoothconnectionscreen(),
    ),
  );
}

class Bluetoothconnectionscreen extends StatelessWidget {
  const Bluetoothconnectionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Official Sensor App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontWeight: FontWeight.bold),
          )),
      home: const BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetoothManager = Provider.of<BluetoothManager>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lector de Sensores Bluetooth'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              onPressed: bluetoothManager.checkBluetoothState,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: !bluetoothManager.isBluetoothAvailable
            ? const _BluetoothUnavailableView()
            : !bluetoothManager.isBluetoothEnabled
                ? const _BluetoothDisabledView()
                : const _MainView(),
      ),
    );
  }
}

// --- Widgets de estado (sin cambios) ---
class _BluetoothUnavailableView extends StatelessWidget {
  const _BluetoothUnavailableView();
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Bluetooth no disponible en este dispositivo."));
}

class _BluetoothDisabledView extends StatelessWidget {
  const _BluetoothDisabledView();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Bluetooth está desactivado."),
          ElevatedButton(
            onPressed: () =>
                Provider.of<BluetoothManager>(context, listen: false)
                    .enableBluetooth(),
            child: const Text('Activar Bluetooth'),
          ),
        ],
      ),
    );
  }
}

// --- Vista Principal ---
class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    final bluetoothManager = Provider.of<BluetoothManager>(context);
    final isConnected = bluetoothManager.connectionState?.isConnected == true;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const _ConnectionStatusCard(),
            const SizedBox(height: 8),
            const _DeviceListCard(),
            if (isConnected) const SizedBox(height: 8),
            if (isConnected) SensorDataCard(data: bluetoothManager.sensorData),
          ],
        ),
      ),
    );
  }
}

// --- Widgets de UI (divididos en tarjetas para mayor claridad) ---
class _ConnectionStatusCard extends StatelessWidget {
  const _ConnectionStatusCard();
  @override
  Widget build(BuildContext context) {
    final bluetoothManager = Provider.of<BluetoothManager>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estado de la Conexión',
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            ListTile(
              leading: Icon(
                bluetoothManager.connectionState?.isConnected == true
                    ? Icons.link
                    : Icons.link_off,
                color: bluetoothManager.connectionState?.isConnected == true
                    ? Colors.green
                    : Colors.red,
              ),
              title: Text(
                  bluetoothManager.connectedDevice?.name ?? "No conectado"),
              subtitle: Text(
                  bluetoothManager.connectionState?.status ?? "desconectado"),
              trailing: Switch(
                value: bluetoothManager.autoReconnect,
                onChanged: (value) => bluetoothManager.autoReconnect = value,
              ),
            ),
            if (bluetoothManager.connectedDevice != null)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                    'Dirección: ${bluetoothManager.connectedDevice!.address}'),
              ),
          ],
        ),
      ),
    );
  }
}

class _DeviceListCard extends StatelessWidget {
  const _DeviceListCard();
  @override
  Widget build(BuildContext context) {
    final bluetoothManager = Provider.of<BluetoothManager>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dispositivos',
                    style: Theme.of(context).textTheme.titleLarge),
                Row(
                  children: [
                    IconButton(
                      onPressed: bluetoothManager.isDiscovering
                          ? null
                          : bluetoothManager.startDiscovery,
                      icon: bluetoothManager.isDiscovering
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: bluetoothManager.loadPairedDevices,
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if (bluetoothManager.pairedDevices.isNotEmpty)
                  ...bluetoothManager.pairedDevices
                      .map((d) => _DeviceTile(device: d)),
                if (bluetoothManager.discoveredDevices.isNotEmpty)
                  ...bluetoothManager.discoveredDevices
                      .map((d) => _DeviceTile(device: d)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  final BluetoothDevice device;
  const _DeviceTile({required this.device});
  @override
  Widget build(BuildContext context) {
    final bluetoothManager =
        Provider.of<BluetoothManager>(context, listen: false);
    final connectionState =
        Provider.of<BluetoothManager>(context).connectionState;
    final isConnected =
        bluetoothManager.connectedDevice?.address == device.address;
    final isConnecting = connectionState?.deviceAddress == device.address &&
        !(connectionState?.isConnected ?? false);

    return ListTile(
      leading:
          Icon(device.paired ? Icons.bluetooth : Icons.bluetooth_searching),
      title: Text(device.name ?? "Dispositivo desconocido"),
      subtitle: Text(device.address),
      trailing: ElevatedButton(
        onPressed: isConnecting
            ? null
            : () {
                isConnected
                    ? bluetoothManager.disconnect()
                    : bluetoothManager.connectToDevice(device);
              },
        child: Text(isConnected
            ? 'Desconectar'
            : (isConnecting ? 'Conectando...' : 'Conectar')),
      ),
      selected: isConnected,
    );
  }
}
