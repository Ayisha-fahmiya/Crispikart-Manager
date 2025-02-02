// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/responsive/responsive.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class TileWidgetStyle extends ConsumerStatefulWidget {
  final String orderNumber;
  final String customerName;
  final DateTime deliveryTime;
  final IconData orderIcon;

  const TileWidgetStyle({
    Key? key,
    required this.orderNumber,
    required this.customerName,
    required this.deliveryTime,
    required this.orderIcon,
  }) : super(key: key);

  @override
  ConsumerState<TileWidgetStyle> createState() => _TileWidgetStyleState();
}

class _TileWidgetStyleState extends ConsumerState<TileWidgetStyle> {
  bool outForDelivery = true;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return Container(
      height: R.sh(100, context),
      width: R.sw(330, context),
      decoration: BoxDecoration(
        border: Border.all(
            width: 2.5,
            color: themeMode == ThemeMode.light
                ? Color.fromARGB(255, 228, 228, 228)
                : Color.fromARGB(255, 29, 29, 29)),
        color: themeMode == ThemeMode.dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ListTile(
          leading: Icon(
            widget.orderIcon,
            color: themeMode == ThemeMode.dark
                ? Colors.white
                : appTheme.colorScheme.primary,
            size: 32,
          ),
          title: Text(
            'Order #${widget.orderNumber}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color:
                  themeMode == ThemeMode.dark ? Colors.white54 : Colors.black87,
            ),
          ),
          subtitle: Text(
            'Customer: ${widget.customerName}',
            style: TextStyle(
              fontSize: 14,
              color:
                  themeMode == ThemeMode.dark ? Colors.white38 : Colors.black87,
            ),
          ),
          // trailing: Column(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(
          //       outForDelivery ? Icons.moped : Icons.access_time_rounded,
          //       color: Colors.grey,
          //       size: 18,
          //     ),
          //     const SizedBox(height: 4),
          //     Text(
          //       DateFormat('hh:mm a').format(widget.deliveryTime),
          //       style: const TextStyle(
          //         fontSize: 12,
          //         color: Colors.grey,
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
