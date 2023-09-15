import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/reminder_tile.dart';

List<ReminderTile> allOrders = [
  ReminderTile(
    orderNumber: "1",
    customerName: "vjhscv",
    deliveryTime: DateTime.now().add(const Duration(hours: 1)),
    orderIcon: Icons.star,
  ),
  ReminderTile(
    orderNumber: "2",
    customerName: "cfce",
    deliveryTime: DateTime.now().add(const Duration(hours: 1)),
    orderIcon: Icons.star,
  ),
  ReminderTile(
    orderNumber: "3",
    customerName: "ecqr",
    deliveryTime: DateTime.now().add(const Duration(hours: 1)),
    orderIcon: Icons.star,
  ),
  ReminderTile(
    orderNumber: "4",
    customerName: "qevrqrv",
    deliveryTime: DateTime.now().add(const Duration(hours: 1)),
    orderIcon: Icons.star,
  ),
];
