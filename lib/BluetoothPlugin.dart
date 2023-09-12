import 'package:flutter/services.dart';

class BluetoothPlugin {
  static const MethodChannel _channel = const MethodChannel('bluetooth_plugin');

  static Future<void> startDiscovery() async {
    try {
      await _channel.invokeMethod('startDiscovery');
    } catch (e) {
      print('Error starting Bluetooth discovery: $e');
    }
  }
}
