import 'dart:math';
import 'package:chat_app/Screens/CameraView.dart';
import 'package:chat_app/Screens/VideoView.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({super.key, required this.cameras, required this.onImageSend});  
  late Function(String) onImageSend;
  final List<CameraDescription> cameras;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool _isCameraInitialized = false;
  bool isRecording = false;
  String videopath = "";
  bool flash = false;
  bool isCamerafront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  // Initializes the camera
  void initializeCamera() async {
    if (widget.cameras.isNotEmpty) {
      _cameraController = CameraController(widget.cameras[0], ResolutionPreset.high);
      cameraValue = _cameraController.initialize();
      cameraValue.then((_) {
        setState(() {
          _isCameraInitialized = true;
        });
      });
    } else {
      debugPrint("No cameras available.");
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera preview section
          _isCameraInitialized
              ? CameraPreview(_cameraController)
              : const Center(child: CircularProgressIndicator()),

          // Positioned controls at the bottom
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Flash toggle button
                      IconButton(
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          _cameraController.setFlashMode(
                            flash ? FlashMode.torch : FlashMode.off,
                          );
                        },
                        icon: Icon(flash ? Icons.flash_on : Icons.flash_off),
                        color: Colors.white,
                        iconSize: 28,
                      ),
                      
                      // Capture and Video Recording Button
                      GestureDetector(
                        onLongPress: startRecording,
                        onLongPressUp: stopRecording,
                        onTap: () {
                          if (!isRecording) takePhoto(context);
                        },
                        child: isRecording
                            ? const Icon(Icons.radio_button_on, color: Colors.red, size: 80)
                            : const Icon(Icons.panorama_fish_eye, color: Colors.white, size: 70),
                      ),
                      
                      // Camera flip button
                      IconButton(
                        onPressed: switchCamera,
                        icon: Transform.rotate(
                          angle: transform,
                          child: const Icon(Icons.flip_camera_ios),
                        ),
                        color: Colors.white,
                        iconSize: 28,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 4),
                  const Text(
                    "Hold for Video, tap for photo",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to take a photo
  void takePhoto(BuildContext context) async {
    try {
      final XFile file = await _cameraController.takePicture();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraViewPage(path: file.path,
          onImageSend: widget.onImageSend,),
        ),
      );
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
  }

  // Function to start video recording
  void startRecording() async {
    try {
      await _cameraController.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      debugPrint("Error starting video recording: $e");
    }
  }

  // Function to stop video recording
  void stopRecording() async {
    try {
      XFile videoFile = await _cameraController.stopVideoRecording();
      setState(() {
        isRecording = false;
        videopath = videoFile.path;
      });
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoViewPage(path: videopath),
        ),
      );
    } catch (e) {
      debugPrint("Error stopping video recording: $e");
    }
  }

  // Function to switch between front and back cameras
  void switchCamera() async {
  setState(() {
    isCamerafront = !isCamerafront;
    transform += pi;
  });

  int cameraPos = isCamerafront ? 0 : 1;

  // Dispose the current controller before switching
  await _cameraController.dispose();  

  _cameraController = CameraController(widget.cameras[cameraPos], ResolutionPreset.high);

  cameraValue = _cameraController.initialize().then((_) {
    if (mounted) {
      setState(() {}); // Ensures UI updates with new camera preview
    }
  }).catchError((e) {
    debugPrint("Error switching camera: $e");
  });
}

}
