import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/Widgets/menu_hedding_style.dart';
import 'package:restaurant_app/controllers/menu_screen_controller.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/providers/form_field_controller_provider.dart';
import 'package:restaurant_app/responsive/responsive.dart';
import 'package:restaurant_app/utilities/menu_screen_edit_dialog.dart';
import 'package:restaurant_app/utilities/menu_screen_open_add_dialog.dart';

class MenuScreen2 extends ConsumerStatefulWidget {
  const MenuScreen2({super.key});

  @override
  ConsumerState<MenuScreen2> createState() => _MenuScreen2State();
}

class _MenuScreen2State extends ConsumerState<MenuScreen2> {
  get nameController => ref.watch(nameControllerProvider);
  get descriptionController => ref.watch(descriptionControllerProvider);
  get priceController => ref.watch(priceControllerProvider);
  get quantityController => ref.watch(quantityControllerProvider);

  void deleteMenuItem(int index) {
    setState(() {
      ref.read(menuItemsProvider).removeAt(index);
    });
  }

  // @override
  // void dispose() {
  //   nameController.dispose();
  //   descriptionController.dispose();
  //   priceController.dispose();
  //   quantityController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final menuScreenController = ref.watch(menuItemsProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      body: menuScreenController.isEmpty
          ? const Center(child: Text("No Food Items"))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: ListView.builder(
                itemCount: menuScreenController.length,
                itemBuilder: (context, index) {
                  final item = menuScreenController[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Colors.grey[300]!,
                      ),
                    ),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        child: item.imageUrl != null
                            ? ClipOval(
                                child: Image.file(
                                  File(item.imageUrl!.path),
                                  fit: BoxFit.cover,
                                  width: 54,
                                  height: 54,
                                ),
                              )
                            : const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                      ),
                      title: Text(
                        item.name,
                        style: TextStyle(
                          color: themeMode == ThemeMode.dark
                              ? Colors.white70
                              : Colors.black,
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: themeMode == ThemeMode.dark
                                ? Colors.white54
                                : Colors.black,
                          ),
                          children: [
                            const TextSpan(text: "₹ "),
                            TextSpan(text: item.price),
                          ],
                        ),
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MenuHeaddingStyle(text: "Description"),
                            Text(item.description),
                            const MenuHeaddingStyle(text: "Availability"),
                            item.availableAllTime
                                ? const Text(
                                    '- Everytime',
                                  )
                                : const SizedBox(),
                            item.availableForBreakfast
                                ? const Text(
                                    '- Breakfast',
                                  )
                                : const SizedBox(),
                            item.availableForLunch
                                ? const Text(
                                    '- Lunch',
                                  )
                                : const SizedBox(),
                            item.availableForEveningTea
                                ? const Text(
                                    '- Evening Tea',
                                  )
                                : const SizedBox(),
                            item.availableForDinner
                                ? const Text(
                                    '- Dinner',
                                  )
                                : const SizedBox(),
                            const MenuHeaddingStyle(text: "Category"),
                            SizedBox(
                              height:
                                  item.categories.length * R.sh(20, context),
                              child: ListView.builder(
                                itemCount: item.categories.length,
                                itemBuilder: (context, index) {
                                  return Text("- ${item.categories[index]}");
                                },
                              ),
                            ),
                            const MenuHeaddingStyle(text: "Delivery options"),
                            item.pickupOption
                                ? const Text(
                                    '- Pick-up available',
                                  )
                                : const SizedBox(),
                            item.deliveryOption
                                ? const Text(
                                    '- Home delivery',
                                  )
                                : const SizedBox(),
                            Text(
                                "Quantity Available: ${item.quantityAvailable}"),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => OpenEditDialog()
                                          .openEditDialog(context, ref, index),
                                    );
                                  },
                                  child: const Text("Edit"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Are you sure?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deleteMenuItem(index);
                                              Navigator.pop(context);
                                            },
                                            child: Text("Delete"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (
              context,
            ) =>
                OpenAddDialoq().openAddDialoq(context, ref),
          );
        },
        // icon: Icon(Icons.add),
        label: const Row(
          children: [
            Text("Add"),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}
