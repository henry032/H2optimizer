import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_classic_serial/flutter_bluetooth_classic.dart';
import '../sensores/sensor_data_model.dart';

class BluetoothManager with ChangeNotifier {
  final FlutterBluetoothClassic _bluetooth = FlutterBluetoothClassic();
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;
  StreamSubscription<BluetoothData>? _dataSubscription;
  StreamSubscription<BluetoothState>? _stateSubscription;
  Timer? _reconnectTimer;

  bool _isBluetoothAvailable = false;
  bool get isBluetoothAvailable => _isBluetoothAvailable;

  bool _isBluetoothEnabled = false;
  bool get isBluetoothEnabled => _isBluetoothEnabled;

  BluetoothConnectionState? _connectionState;
  BluetoothConnectionState? get connectionState => _connectionState;

  List<BluetoothDevice> _pairedDevices = [];
  List<BluetoothDevice> get pairedDevices => _pairedDevices;

  List<BluetoothDevice> _discoveredDevices = [];
  List<BluetoothDevice> get discoveredDevices => _discoveredDevices;

  BluetoothDevice? _connectedDevice;
  BluetoothDevice? get connectedDevice => _connectedDevice;

  bool _isDiscovering = false;
  bool get isDiscovering => _isDiscovering;

  bool _autoReconnect = false;
  bool get autoReconnect => _autoReconnect;
  set autoReconnect(bool value) {
    _autoReconnect = value;
    if (!value) {
      _reconnectTimer?.cancel();
    }
    notifyListeners();
  }

  String? _lastConnectedAddress;

  // This holds the latest parsed sensor data using the new model
  SensorData _sensorData = SensorData.initial();
  SensorData get sensorData => _sensorData;

  final StringBuffer _dataBuffer = StringBuffer();

  BluetoothManager() {
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    await checkBluetoothState();
    _setupListeners();
  }

  Future<void> checkBluetoothState() async {
    _isBluetoothAvailable = await _bluetooth.isBluetoothSupported();
    _isBluetoothEnabled = await _bluetooth.isBluetoothEnabled();
    if (_isBluetoothAvailable && _isBluetoothEnabled) {
      await loadPairedDevices();
    }
    notifyListeners();
  }

  void _setupListeners() {
    _stateSubscription = _bluetooth.onStateChanged.listen((state) {
      _isBluetoothEnabled = state.isEnabled;
      if (state.isEnabled) loadPairedDevices();
      notifyListeners();
    });

    _connectionSubscription =
        _bluetooth.onConnectionChanged.listen(_onConnectionStateChanged);

    _dataSubscription = _bluetooth.onDataReceived.listen(_onDataReceived);
  }

  void _onConnectionStateChanged(BluetoothConnectionState state) {
    _connectionState = state;
    if (state.isConnected) {
      _connectedDevice = _pairedDevices.firstWhere(
        (d) => d.address == state.deviceAddress,
        orElse: () => _discoveredDevices.firstWhere(
          (d) => d.address == state.deviceAddress,
          orElse: () => BluetoothDevice(
              name: "Unknown", address: state.deviceAddress, paired: false),
        ),
      );
      _lastConnectedAddress = state.deviceAddress;
      _reconnectTimer?.cancel();
    } else {
      _connectedDevice = null;
      if (_autoReconnect && _lastConnectedAddress != null)
        _startReconnectTimer();
    }
    notifyListeners();
  }

  void _onDataReceived(BluetoothData data) {
    String received = data.asString();
    _dataBuffer.write(received);

    String bufferContent = _dataBuffer.toString();
    if (bufferContent.contains('\n')) {
      List<String> lines = bufferContent.split('\n');
      _dataBuffer.clear();
      if (lines.isNotEmpty && lines.last.isNotEmpty) {
        _dataBuffer.write(lines.last);
      }
      for (int i = 0; i < lines.length - 1; i++) {
        final line = lines[i].trim();
        if (line.isNotEmpty) {
          _processMessage(line);
        }
      }
    }
  }

  void _processMessage(String message) {
    if (message.isNotEmpty) {
      try {
        _sensorData = SensorData.fromJson(message);
        notifyListeners();
        debugPrint("Successfully parsed new data. pH: ${_sensorData.ph}");
      } catch (e) {
        debugPrint("Could not parse official JSON: $e");
      }
    }
  }

  void _startReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (_lastConnectedAddress != null &&
          _connectionState?.isConnected != true &&
          _autoReconnect) {
        await connectToDeviceAddress(_lastConnectedAddress!);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> loadPairedDevices() async {
    try {
      _pairedDevices = await _bluetooth.getPairedDevices();
    } catch (e) {
      debugPrint("Error loading paired devices: $e");
    }
    notifyListeners();
  }

  Future<void> startDiscovery() async {
    if (!_isBluetoothEnabled) return;
    _isDiscovering = true;
    _discoveredDevices.clear();
    notifyListeners();
    try {
      await _bluetooth.startDiscovery();
      Timer(const Duration(seconds: 30), () => stopDiscovery());
    } catch (e) {
      _isDiscovering = false;
      notifyListeners();
    }
  }

  Future<void> stopDiscovery() async {
    await _bluetooth.stopDiscovery();
    _isDiscovering = false;
    notifyListeners();
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await _bluetooth.connect(device.address);
  }

  Future<void> connectToDeviceAddress(String address) async {
    await _bluetooth.connect(address);
  }

  Future<void> disconnect() async {
    autoReconnect = false;
    await _bluetooth.disconnect();
  }

  Future<void> enableBluetooth() async {
    await _bluetooth.enableBluetooth();
    await checkBluetoothState();
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    _dataSubscription?.cancel();
    _stateSubscription?.cancel();
    _reconnectTimer?.cancel();
    super.dispose();
  }
}
