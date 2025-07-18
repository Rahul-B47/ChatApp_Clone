import 'package:chat_app/CustomUI/AvatarCard.dart';
import 'package:chat_app/CustomUI/ButtonCard.dart';
import 'package:chat_app/CustomUI/ContactCard.dart';
import 'package:chat_app/Model/ChatModel.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Dev Stack", status: "A full stack developer", select: false),
    ChatModel(name: "Balaram", status: "A full stack developer", select: false),
    ChatModel(name: "Rahul", status: "App developer", select: false),
  ];

  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "Add Participants",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 26),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => print(value),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: "Invite a friend", child: Text("Invite a friend")),
                const PopupMenuItem(value: "Contacts", child: Text("Contacts")),
                const PopupMenuItem(value: "Refresh", child: Text("Refresh")),
                const PopupMenuItem(value: "Help", child: Text("Help")),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1, // ✅ Fixed extra row
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groups.isNotEmpty ? 90 : 10, // ✅ Adjust height dynamically
                );
              }
              return InkWell(
                onTap: () {
                  setState(() {
                    if (!contacts[index - 1].select) {
                      contacts[index - 1].select = true;
                      groups.add(contacts[index - 1]); // ✅ Correct selection logic
                    } else {
                      contacts[index - 1].select = false;
                      groups.remove(contacts[index - 1]); // ✅ Remove correctly
                    }
                  });
                },
                child: ContactCard(contact: contacts[index - 1]),
              );
            },
          ),
          groups.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: groups.length, // ✅ Show only selected contacts
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                groups[index].select = false; // ✅ Unselect when removed
                                groups.removeAt(index);
                              });
                            },
                            child: AvatarCard(contact: groups[index]),
                          );
                        },
                      ),
                    ),
                    const Divider(thickness: 1),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
