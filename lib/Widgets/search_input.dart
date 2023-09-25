import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/Widgets/reminder_tile.dart';
import 'package:restaurant_app/controllers/orders.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/providers/search_provider.dart';
import 'package:restaurant_app/responsive/responsive.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class SearchInput extends ConsumerStatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<SearchInput> {
  List<TileWidgetStyle> allOrdrs = allOrders;

  List<TileWidgetStyle> filteredOrders = [];
  @override
  void initState() {
    super.initState();
  }

  void filterOrders(String searchText) {
    setState(() {
      filteredOrders = allOrdrs
          .where((order) => order.customerName
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController =
        ref.watch(searchControllerProvider);
    final themeMode = ref.watch(themeModeProvider);
    var colour = themeMode == ThemeMode.dark ? Colors.white : Colors.black;
    return Column(
      children: [
        TextField(
          controller: searchController,
          style: TextStyle(color: colour),
          cursorColor: colour,
          onChanged: (value) {
            filterOrders(value);
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: colour,
            ),
            filled: true,
            fillColor: Colors.transparent,
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
        ),
        searchController.text.isEmpty
            ? const SizedBox()
            : SizedBox(
                height: R.sh(filteredOrders.length * 76, context),
                child: ListView.builder(
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return ListTile(
                      title: Text(order.customerName),
                      subtitle: Text("Order Number: ${order.orderNumber}"),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
