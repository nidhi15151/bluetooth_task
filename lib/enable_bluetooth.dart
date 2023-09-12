// import 'package:firstapp/BluetoothPlugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnableBluetooth extends StatefulWidget {
  const EnableBluetooth({super.key});

  @override
  State<EnableBluetooth> createState() => _EnableBluetoothState();
}

class _EnableBluetoothState extends State<EnableBluetooth> {
  static const platform = MethodChannel('bluetooth_handler');

  Future<void> initPlatformState() async {
    try {
      final result = await platform.invokeMethod('initBluetooth');
      print("ddddd" + result);
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
    }
  }

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  initPlatformState();
                },
                child: const Center(
                  child: Text('Enable Bluetooth'),
                ))
          ],
        ),
      ),
    );
  }
}
