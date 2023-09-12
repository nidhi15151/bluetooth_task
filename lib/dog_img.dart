import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(RandomDogApp());
}

class RandomDogApp extends StatefulWidget {
  @override
  _RandomDogAppState createState() => _RandomDogAppState();
}

class _RandomDogAppState extends State<RandomDogApp> {
  String imageUrl = '';
  bool isLoading = false;

  // Function to fetch a random dog image from the API
  Future<void> fetchRandomDogImage() async {
    setState(() {
      isLoading = true;
    });

    try {
      final httpClient = HttpClient();
      final request = await httpClient
          .getUrl(Uri.parse('https://dog.ceo/api/breeds/image/random'));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = jsonDecode(responseBody);
        setState(() {
          imageUrl = data['message'];
        });
      } else {
        throw Exception('Failed to load dog image');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomDogImage(); // Load an initial random dog image when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text(
            'Random Dog Images',
            style: TextStyle(
              color: Colors.white, // Set the text color
              fontSize: 24,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: isLoading
                    ? Container(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : imageUrl.isNotEmpty
                        ? Image.network(imageUrl)
                        : Text('No image available'),
              ),
              ElevatedButton(
                onPressed: fetchRandomDogImage,
                child: Text(
                  'Refresh',
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
