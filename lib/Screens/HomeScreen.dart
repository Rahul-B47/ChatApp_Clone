import 'package:chat_app/Pages/StatusPage.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Pages/ChatPage.dart';
import 'package:chat_app/Pages/CameraPage.dart';
import 'package:chat_app/main.dart'; // Import main.dart to access 'cameras'
import 'package:chat_app/Model/ChatModel.dart'; // Ensure ChatModel is imported

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.chatmodels,required this.sourchat});
  
  final List<ChatModel> chatmodels;
  final ChatModel sourchat;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp Clone"),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: "New group", child: Text("New Group")),
                const PopupMenuItem(value: "New Broadcast", child: Text("New Broadcast")),
                const PopupMenuItem(value: "WhatsApp Web", child: Text("WhatsApp Web")),
                const PopupMenuItem(value: "Starred messages", child: Text("Starred messages")),
                const PopupMenuItem(value: "Settings", child: Text("Settings")),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: "CHATS"),
            Tab(text: "STATUS"),
            Tab(text: "CALLS"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(cameras: cameras, path: ''), // Ensure cameras is properly passed
          ChatPage(chatmodels: widget.chatmodels,
          sourchat: widget.sourchat,), // Pass chat models to ChatPage
          StatusPage(),
          const Center(child: Text("Calls")),
        ],
      ),
    );
  }
}
