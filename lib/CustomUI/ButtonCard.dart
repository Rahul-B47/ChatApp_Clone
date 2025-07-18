import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key, required this.name, required this.icon});

  final String name; // Non-nullable since it's required
  final IconData icon; // Non-nullable since it's required

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        backgroundColor: const Color(0xff25d366), // WhatsApp green background
        child: Icon(
          icon,
          color: Colors.white, // Icon color
          size: 20, // Icon size adjusted to fit
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
