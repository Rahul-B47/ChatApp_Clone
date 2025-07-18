import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key, required this.message,required this.time});
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: const Color(0xffdcf8c6),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              // ✅ Removed const because message is dynamic
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 60, top: 5, bottom: 20),
                child: Text(
                  message, // ✅ Fixed dynamic variable usage
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      time, // ✅ Changed from "20.58" to "20:58" (proper time format)
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.done_all, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}