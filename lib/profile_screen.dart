import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRandomUserData();
  }

  Future<void> fetchRandomUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final httpClient = HttpClient();
      final request =
          await httpClient.getUrl(Uri.parse('https://randomuser.me/api/'));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = jsonDecode(responseBody);
        setState(() {
          userData = data['results'][0];
        });
      } else {
        userData = null;
      }
    } catch (error) {
      print('Error: $error');
      userData = null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String calculateDaysSinceRegistered() {
    if (userData != null) {
      final registeredDate = DateTime.parse(userData!['registered']['date']);
      final currentDate = DateTime.now();
      final days = currentDate.difference(registeredDate).inDays;
      return '$days days';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
                context); // Use Navigator.of(context).pop() to navigate back
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Profile Screen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : userData != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(userData!['picture']['large']),
                        radius: 80,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${userData!['name']['first']} ${userData!['name']['last']}',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Location: ${userData!['location']['city']}, ${userData!['location']['country']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email: ${userData!['email']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Date of Birth: ${userData!['dob']['date']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Number of days passed since registered: ${calculateDaysSinceRegistered()}',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center, // Added for centering
                        ),
                      )
                    ],
                  )
                : Text('Failed to fetch user data'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: fetchRandomUserData,
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }
}
