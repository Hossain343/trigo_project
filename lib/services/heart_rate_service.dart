import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class HeartRateService {
  BluetoothDevice? device;
  int heartRate = 0;

  final StreamController<int> _hrController =
  StreamController<int>.broadcast();

  Stream<int> get onHeartRateChanged => _hrController.stream;

  Future<void> startScanAndConnect() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) async {
      for (final r in results) {
        if (r.device.name.toLowerCase().contains('hr') ||
            r.device.name.toLowerCase().contains('heart')) {
          device = r.device;
          await FlutterBluePlus.stopScan();
          await device!.connect(autoConnect: false);
          _discover();
          break;
        }
      }
    });
  }

  Future<void> _discover() async {
    final services = await device!.discoverServices();
    for (final s in services) {
      for (final c in s.characteristics) {
        if (c.uuid.toString().toLowerCase().contains('2a37')) {
          await c.setNotifyValue(true);
          c.value.listen((data) {
            if (data.isNotEmpty) {
              heartRate = data.last;
              _hrController.add(heartRate);
            }
          });
        }
      }
    }
  }

  void dispose() {
    device?.disconnect();
    _hrController.close();
  }
}
