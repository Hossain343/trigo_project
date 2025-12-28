import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class SensorService {
  final flutterBle = FlutterReactiveBle();

  late DiscoveredDevice device;
  StreamSubscription<ConnectionStateUpdate>? _connection;
  final Map<String, StreamController<int>> _dataControllers = {};

  Stream<int> getData(String type) {
    _dataControllers[type] ??= StreamController<int>.broadcast();
    return _dataControllers[type]!.stream;
  }

  Future<void> scanAndConnect() async {
    flutterBle.scanForDevices(withServices: []).listen((d) {
      if (d.name.toLowerCase().contains('wahoo') ||
          d.name.toLowerCase().contains('garmin') ||
          d.name.toLowerCase().contains('igpsport')) {
        device = d;
        _connect();
      }
    });
  }

  void _connect() {
    _connection = flutterBle.connectToDevice(
      id: device.id,
      connectionTimeout: const Duration(seconds: 5),
    ).listen((state) {
      if (state.connectionState == DeviceConnectionState.connected) {
        _subscribeCharacteristics();
      }
    });
  }

  void _subscribeCharacteristics() async {
    // فرضی UUID ها (باید جایگزین شود با UUID واقعی سنسور)
    final cadenceChar = QualifiedCharacteristic(
        serviceId: Uuid.parse("00001816-0000-1000-8000-00805f9b34fb"),
        characteristicId: Uuid.parse("00002a5b-0000-1000-8000-00805f9b34fb"),
        deviceId: device.id);
    final speedChar = QualifiedCharacteristic(
        serviceId: Uuid.parse("00001816-0000-1000-8000-00805f9b34fb"),
        characteristicId: Uuid.parse("00002a5a-0000-1000-8000-00805f9b34fb"),
        deviceId: device.id);
    final powerChar = QualifiedCharacteristic(
        serviceId: Uuid.parse("00001818-0000-1000-8000-00805f9b34fb"),
        characteristicId: Uuid.parse("00002a63-0000-1000-8000-00805f9b34fb"),
        deviceId: device.id);

    flutterBle.subscribeToCharacteristic(cadenceChar).listen((data) {
      final value = data.isNotEmpty ? data[0] : 0;
      _dataControllers['cadence']?.add(value);
    });

    flutterBle.subscribeToCharacteristic(speedChar).listen((data) {
      final value = data.isNotEmpty ? data[0] : 0;
      _dataControllers['speed']?.add(value);
    });

    flutterBle.subscribeToCharacteristic(powerChar).listen((data) {
      final value = data.isNotEmpty ? data[0] : 0;
      _dataControllers['power']?.add(value);
    });
  }

  void dispose() {
    _connection?.cancel();
    for (var c in _dataControllers.values) {
      c.close();
    }
  }
}
