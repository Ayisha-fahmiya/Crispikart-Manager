import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/reminder_tile.dart';

class OrderList extends StatelessWidget {
  final String status;
  final IconData iconData;

  const OrderList({Key? key, required this.status, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ReminderTile(
          orderNumber: "1",
          customerName: "asdf",
          deliveryTime: DateTime.now().add(const Duration(hours: 1)),
          orderIcon: iconData,
        );
      },
    );
  }
}
