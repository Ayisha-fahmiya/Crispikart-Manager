import 'package:flutter/material.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class MyCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String contentText;
  final Widget page;

  const MyCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.contentText,
    required this.page,
  }) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 160,
      child: Card(
        color: appTheme.colorScheme.primary,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widget.page,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  size: 42,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.contentText,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
