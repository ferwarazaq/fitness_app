// lib/main.dart
import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker',
      theme: ThemeData(
        // Use a more vibrant color palette with a mix of blue and purple
        primarySwatch: Colors.deepPurple, // Deep Purple for main color
        hintColor: Colors.cyan, // Accent color for buttons and highlights
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 16, color: Colors.black87), // Clear readable text
          bodyText2: TextStyle(fontSize: 14, color: Colors.black54),
          headline6: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          subtitle1: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white, // Light background for better contrast
      ),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,  // Deep purple background for app bar
        title: Text(
          'Fitness Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.5, // Letter spacing for title
          ),
        ),
        elevation: 10.0, // Slight elevation for depth
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40), // Padding for content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('image/download.jpg', width: 250),  // Logo centered and slightly bigger
              SizedBox(height: 30),
              Text(
                'Welcome to your Fitness Journey!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22, // Slightly larger font size for better readability
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Navigation to the HomePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,  // Matching button color with the theme
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 8.0, // Button elevation for better visibility
                  shadowColor: Colors.deepPurpleAccent, // Slight shadow for emphasis
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Your health, your fitness, your way.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
