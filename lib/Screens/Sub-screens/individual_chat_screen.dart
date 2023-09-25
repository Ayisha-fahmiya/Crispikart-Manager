import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/Screens/Sub-screens/chat_info_screen.dart';
import 'package:restaurant_app/controllers/meassages.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/responsive/responsive.dart';

class IndividualChatScreen extends ConsumerStatefulWidget {
  final String profilePic;
  final String name;
  final String contactNo;
  const IndividualChatScreen(
      {super.key,
      required this.name,
      required this.profilePic,
      required this.contactNo});

  @override
  ConsumerState<IndividualChatScreen> createState() =>
      _IndividualChatScreenState();
}

class _IndividualChatScreenState extends ConsumerState<IndividualChatScreen> {
  // late ScrollController scrollController;

  chatMessages() {
    return Container(
      child: ListView.builder(
        // controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return messages[index];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.profilePic),
            ),
            SizedBox(width: 12),
            Text(widget.name),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatInfo(
                    profilePic: widget.profilePic,
                    name: widget.name,
                    contactNo: widget.contactNo,
                  ),
                ),
              );
            },
            icon: Icon(Icons.info),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: chatMessages()),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: R.sh(75, context),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: themeMode == ThemeMode.dark
                        ? Color.fromARGB(255, 32, 32, 32)
                        : Color(0xFFD6D6D6),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
                color:
                    themeMode == ThemeMode.dark ? Colors.black : Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      // controller: messageController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: "Send a message...",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      // sendMaessage();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        // color: primaryClr.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.send,
                          color: themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
