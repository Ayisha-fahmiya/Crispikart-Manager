import 'package:flutter/material.dart';

class ChatInfo extends StatelessWidget {
  final String profilePic;
  final String name;
  final String contactNo;
  const ChatInfo({
    super.key,
    required this.profilePic,
    required this.name,
    required this.contactNo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info"),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profilePic),
            ),
            Text(name),
            Text(contactNo),
          ],
        ),
      ),
    );
  }
}
