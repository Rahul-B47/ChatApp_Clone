import 'package:chat_app/Screens/CameraScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Ensure camera package is imported

class CameraPage extends StatelessWidget {
  final String path; // Required path parameter
  final List<CameraDescription> cameras; // Declare cameras as a class property

  const CameraPage({super.key, required this.path, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return CameraScreen(
      cameras: cameras, 
      onImageSend: (String imagePath) {
        // Handle the image send logic here
        print('Image sent: $imagePath');
      },
    ); // Pass 'cameras' and 'path' correctly
  }
}
