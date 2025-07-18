import 'package:chat_app/CustomUI/CustomCard.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/Screens/SelectContact.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.chatmodels = const [], // Default empty list
    required this.sourchat, // ✅ Marked as nullable
  });

  final List<ChatModel> chatmodels;
  final ChatModel sourchat; // ✅ Fixed: Nullable

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => const SelectContact()),
          );
        },
        child: const Icon(Icons.chat),
      ),
      body: widget.chatmodels.isEmpty
          ? const Center(
              child: Text("No chats available")) // Handle empty list case
          : ListView.builder(
              itemCount: widget.chatmodels.length,
              itemBuilder: (context, index) => CustomCard(
                chatModel:
                    widget.chatmodels[index],
                    sourchat: widget.sourchat, // Passing as a named parameter
              ),
            ),
    );
  }
}
