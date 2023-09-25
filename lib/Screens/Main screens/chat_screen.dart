import 'package:flutter/material.dart';
import 'package:restaurant_app/controllers/delivery_boys.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: deliverBoys.length,
        itemBuilder: (context, index) => deliverBoys[index],
      ),
    );
  }
}
