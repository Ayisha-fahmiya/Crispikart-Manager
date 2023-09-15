import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class ReminderTile extends ConsumerStatefulWidget {
  final String orderNumber;
  final String customerName;
  final DateTime deliveryTime;
  final IconData orderIcon;

  const ReminderTile({
    Key? key,
    required this.orderNumber,
    required this.customerName,
    required this.deliveryTime,
    required this.orderIcon,
  }) : super(key: key);

  @override
  ConsumerState<ReminderTile> createState() => _ReminderTileState();
}

class _ReminderTileState extends ConsumerState<ReminderTile> {
  bool outForDelivery = true;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: const Color(0xFF4F5252)),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
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
    );
  }
}
