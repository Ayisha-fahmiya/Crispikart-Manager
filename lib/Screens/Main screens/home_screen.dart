// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/Screens/Sub-screens/all_orders_screen.dart';
import 'package:restaurant_app/Screens/Sub-screens/earnings_screen.dart';
import 'package:restaurant_app/Screens/Sub-screens/orders_delivered_screen.dart';
import 'package:restaurant_app/Widgets/my_card.dart';
import 'package:restaurant_app/Widgets/order_list.dart';
import 'package:restaurant_app/Widgets/reminder_tile.dart';
import 'package:restaurant_app/Widgets/search_input.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
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
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchInput(),
                  const SizedBox(height: 20),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        MyCard(
                          icon: Icons.bar_chart_rounded,
                          title: 'Earnings',
                          contentText: '₹ 2566',
                          page: EarningsScreen(),
                        ),
                        SizedBox(width: 10),
                        MyCard(
                          icon: Icons.list_alt_outlined,
                          title: 'Orders',
                          contentText: '43',
                          page: AllOrdersScreen(),
                        ),
                        SizedBox(width: 10),
                        MyCard(
                          icon: Icons.task_alt_outlined,
                          title: 'Orders\nDelivered',
                          contentText: '12',
                          page: OrdersDeliveredScreen(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Reminders',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: themeMode == ThemeMode.dark
                          ? Colors.white70
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TileWidgetStyle(
                      orderNumber: '1234',
                      customerName: 'John Doe',
                      deliveryTime: DateTime.now().add(
                        const Duration(hours: 1),
                      ),
                      orderIcon: Icons.shopping_bag_rounded,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Orders',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: themeMode == ThemeMode.dark
                          ? Colors.white70
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: themeMode == ThemeMode.light
                ? appTheme.colorScheme.background
                : Colors.black,
            surfaceTintColor: themeMode == ThemeMode.light
                ? appTheme.colorScheme.background
                : Colors.black,
            pinned: true,
            primary: false,
            title: TabBar(
              indicatorPadding: EdgeInsets.all(6),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              isScrollable: true,
              labelColor:
                  themeMode == ThemeMode.dark ? Colors.white : Colors.black,
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
          ),
        ],
        body: buildTabView(tabController: _tabController),
      ),
    );
  }
}

Widget buildTabView({required TabController tabController}) => TabBarView(
      controller: tabController,
      children: const [
        OrderList(
          status: 'All Orders',
          iconData: Icons.shopping_bag_rounded,
        ),
        OrderList(
          status: 'Confirmed',
          iconData: Icons.done_rounded,
        ),
        OrderList(
          status: 'Preparing',
          iconData: Icons.soup_kitchen_rounded,
        ),
        OrderList(
          status: 'Out for Delivery',
          iconData: Icons.moped_rounded,
        ),
        OrderList(
          status: 'Delivered',
          iconData: Icons.done_all_rounded,
        ),
        OrderList(
          status: 'Cancelled',
          iconData: Icons.cancel_rounded,
        ),
      ],
    );
