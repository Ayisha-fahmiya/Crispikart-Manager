import 'package:flutter/material.dart';

class MenuHeaddingStyle extends StatelessWidget {
  final String text;
  const MenuHeaddingStyle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[600]),
    );
  }
}
