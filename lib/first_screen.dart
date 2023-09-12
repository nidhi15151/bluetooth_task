import 'package:firstapp/dog_img.dart';
import 'package:firstapp/enable_bluetooth.dart';
import 'package:firstapp/profile_screen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Padding(
          padding: EdgeInsets.all(40), // Adjust the padding as needed
          child: Text(
            'Profile Screen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 160,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RandomDogApp()));
              },
              child: const Text(
                'Random Dog Images',
                style: TextStyle(
                  color: Colors.white, // Set the text color
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () {
                // Get.to(EnableBluetooth());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EnableBluetooth()));
              },
              child: const Text(
                'Enable Bluetooth',
                style: TextStyle(
                  color: Colors.white, // Set the text color
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: const Text(
                'Profile Screen',
                style: TextStyle(
                  color: Colors.white, // Set the text color
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
