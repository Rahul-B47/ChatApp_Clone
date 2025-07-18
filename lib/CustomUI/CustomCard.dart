import 'package:chat_app/Model/ChatModel.dart';
import 'package:chat_app/Screens/IndividualPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.chatModel, required this.sourchat}); // ✅ Marked sourchat as nullable

  final ChatModel chatModel;
  final ChatModel sourchat; // ✅ Fixed: Made nullable

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Individualpage(
        chatModel: chatModel,
        sourchat: sourchat , // ✅ Fallback to chatModel if null
      ),
    ),
  );
},

      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey,
              child: SvgPicture.asset(
                chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg", 
                height: 37,
                width: 37,
                color: Colors.white,
              ),
            ),
            title: Text(
              chatModel.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all),
                const SizedBox(width: 3),
                Text(
                  chatModel.currentMessage,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(thickness: 1.5),
          ),
        ],
      ),
    );
  }
}
