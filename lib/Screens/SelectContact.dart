import 'package:chat_app/CustomUI/ButtonCard.dart';
import 'package:chat_app/CustomUI/ContactCard.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/Screens/CreateGroup.dart'; // Import CreateGroup
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(
        name: "Dev stack",
        status: "A full stack developer",
      ),
      ChatModel(
        name: "Balaram",
        status: "A full stack developer",
      ),
      ChatModel(
        name: "Rahul",
        status: "App developer",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "256 Contacts",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 26,
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "Invite a friend",
                  child: Text("Invite a friend"),
                ),
                const PopupMenuItem(
                  value: "Contacts",
                  child: Text("Contacts"),
                ),
                const PopupMenuItem(
                  value: "Refresh",
                  child: Text("Refresh"),
                ),
                const PopupMenuItem(
                  value: "Help",
                  child: Text("Help"),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2, // Extra items for ButtonCards
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateGroup()),
                );
              },
              child: const ButtonCard(
                icon: Icons.group,
                name: "New Group",
              ),
            );
          } else if (index == 1) {
            return InkWell(
              onTap: () {
                // Define what happens when "New Contact" is clicked
              },
              child: const ButtonCard(
                icon: Icons.person_add,
                name: "New Contact",
              ),
            );
          }
          return ContactCard(
            contact: contacts[index - 2], // Adjust index for contacts list
          );
        },
      ),
    );
  }
}
