import 'package:flutter/material.dart';
import 'package:chat_app/CustomUI/ButtonCard.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/Screens/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat;

  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Dev Stack",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Kishore",
      isGroup: false,
      currentMessage: "Hi Kishore",
      time: "10:00",
      icon: "person.svg",
      id: 2,
    ),
    ChatModel(
      name: "Colins",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "4:00",
      icon: "person.svg",
      id: 3,
    ),
  ];

  void removeChat(ChatModel chat) {
    setState(() {
      chatmodels.removeWhere((item) => item.id == chat.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatmodels.isEmpty
          ? const Center(child: Text("No Chats Available"))
          : ListView.builder(
              itemCount: chatmodels.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    sourceChat = chatmodels[index];
                  });
                  removeChat(sourceChat!); // ✅ Remove selected chat
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => HomeScreen(
                        chatmodels: chatmodels,
                        sourchat: sourceChat!, // ✅ Pass selected chat
                      ),
                    ),
                  );
                },
                child: ButtonCard(
                  name: chatmodels[index].name,
                  icon: Icons.person,
                ),
              ),
            ),
    );
  }
}
