import 'dart:io';
import 'package:flutter/material.dart';

class CameraViewPage extends StatelessWidget {
  final String path; // Declare the path variable
  final Function(String)? onImageSend; // Optional function for tap event

  const CameraViewPage({super.key, required this.path, this.onImageSend}); // Require the path parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.crop_rotate, size: 27),
          ),
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.emoji_emotions_outlined, size: 27),
          ),
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.title, size: 27),
          ),
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.edit, size: 27),
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Display the selected image
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path), // Use the passed image file path
                fit: BoxFit.cover,
              ),
            ),
            // Caption Input Field
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add caption....",
                    prefixIcon: const Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 27,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    suffixIcon: InkWell(
                      onTap:(){
                        if (onImageSend != null) {
                          onImageSend!(path);
                        }
                      } ,
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.tealAccent[700],
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
