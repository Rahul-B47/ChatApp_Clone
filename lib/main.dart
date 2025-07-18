import 'package:chat_app/NewScreen/LandingScreen.dart';
import 'package:chat_app/Screens/LoginScreen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Screens/CameraScreen.dart';

List<CameraDescription> cameras = []; // Declare cameras globally

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widget binding is initialized
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize the cameras asynchronously before running the app
  cameras = await availableCameras();

  print("🚀 App Started with Firebase and Camera!");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      theme: ThemeData(
        fontFamily: "OpenSans",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF075E54),
          primary: const Color(0xFF075E54),
          secondary: const Color(0xFF128C7E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF075E54),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: LoginScreen(), // Home screen as the entry point
    );
  }
}
