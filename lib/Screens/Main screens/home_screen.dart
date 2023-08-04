// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchInput(),
                const SizedBox(height: 20),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MyCard(
                        icon: Icons.bar_chart_rounded,
                        title: 'Earnings',
                        contentText: '₹ 2566',
                      ),
                      SizedBox(width: 10),
                      MyCard(
                        icon: Icons.list_alt_outlined,
                        title: 'Orders',
                        contentText: '43',
                      ),
                      SizedBox(width: 10),
                      MyCard(
                        icon: Icons.task_alt_outlined,
                        title: 'Orders\nDelivered',
                        contentText: '12',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Reminders',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ReminderTile(
                  orderNumber: '1234',
                  customerName: 'John Doe',
                  deliveryTime: DateTime.now().add(
                    const Duration(hours: 1),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: isDarkMode ? Colors.white : Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: appTheme.colorScheme.primary,
                  tabs: const [
                    Tab(text: 'All Orders'),
                    Tab(text: 'Confirmed'),
                    Tab(text: 'Preparing'),
                    Tab(text: 'Out for Delivery'),
                    Tab(text: 'Delivered'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      OrderList(status: 'All Orders'),
                      OrderList(status: 'Confirmed'),
                      OrderList(status: 'Preparing'),
                      OrderList(status: 'Out for Delivery'),
                      OrderList(status: 'Delivered'),
                      OrderList(status: 'Cancelled'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String contentText;

  const MyCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.contentText,
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
        child: InkWell(
          onTap: () {},
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

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      cursorColor: isDarkMode ? Colors.white : Colors.black,
      onChanged: (value) {},
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.transparent : Colors.white,
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.all(20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: appTheme.colorScheme.primary, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}

class ReminderTile extends StatefulWidget {
  final String orderNumber;
  final String customerName;
  final DateTime deliveryTime;

  const ReminderTile({
    Key? key,
    required this.orderNumber,
    required this.customerName,
    required this.deliveryTime,
  }) : super(key: key);

  @override
  State<ReminderTile> createState() => _ReminderTileState();
}

class _ReminderTileState extends State<ReminderTile> {
  bool outForDelivery = true;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: const Color(0xFF4F5252)),
        color: Colors.transparent, // Replace with your desired color
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          Icons.shopping_bag_rounded,
          color: isDarkMode
              ? Colors.white
              : appTheme.colorScheme.primary, // Replace with your desired color
          size: 32,
        ),
        title: Text(
          'Order #${widget.orderNumber}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'Customer: ${widget.customerName}',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              outForDelivery ? Icons.moped : Icons.access_time_rounded,
              color: Colors.grey,
              size: 18,
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('hh:mm a').format(widget.deliveryTime),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final String status;

  const OrderList({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: 10, // Replace with the actual number of orders
      itemBuilder: (context, index) {
        // Replace with the logic to retrieve order data
        final orderNumber = '1234';
        final customerName = 'John Doe';
        final deliveryTime = DateTime.now().add(const Duration(hours: 1));

        return ReminderTile(
          orderNumber: orderNumber,
          customerName: customerName,
          deliveryTime: deliveryTime,
        );
      },
    );
  }
}
