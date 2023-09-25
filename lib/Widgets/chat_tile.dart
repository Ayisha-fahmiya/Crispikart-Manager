import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/Sub-screens/individual_chat_screen.dart';

class ChatTile extends StatelessWidget {
  final String name;
  final String chat;
  final String image;
  final String contactNo;
  const ChatTile({
    super.key,
    required this.name,
    required this.chat,
    required this.image,
    required this.contactNo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualChatScreen(
              name: name,
              profilePic: image,
              contactNo: contactNo,
            ),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundImage: AssetImage(image),
      ),
      title: Text(name),
      subtitle: Text(chat),
    );
  }
}
