import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:restaurant_app/Screens/Main%20screens/menu_screen2.dart';
import 'package:restaurant_app/controllers/categories_controller.dart';
import 'package:restaurant_app/models/food_menu_model.dart';
import 'package:restaurant_app/providers/category_provider.dart';
import 'package:restaurant_app/providers/form_field_controller_provider.dart';
import 'package:restaurant_app/responsive/responsive.dart';
import 'package:restaurant_app/utilities/clear_form.dart';
import 'package:restaurant_app/utilities/menu_screen_open_add_dialog.dart';
import 'package:restaurant_app/utilities/pick_image.dart';

File? image;

class OpenEditDialog {
  StatefulBuilder openEditDialog(
      BuildContext context, WidgetRef ref, int index) {
    final nameController = ref.watch(nameControllerProvider);
    final descriptionController = ref.watch(descriptionControllerProvider);
    final priceController = ref.watch(priceControllerProvider);
    final quantityController = ref.watch(quantityControllerProvider);

    final item = menuScreenController.menuItems[index];
    selectedMenuItemIndex = index;
    nameController.text = item.name;
    descriptionController.text = item.description;
    priceController.text = item.price.toString();
    quantityController.text = item.quantityAvailable.toString();
    availablAllTime = item.availableAllTime;
    breakfst = item.availableForBreakfast;
    lnch = item.availableForLunch;
    evngT = item.availableForEveningTea;
    dnnr = item.availableForDinner;
    pickUp = item.pickupOption;
    homeDelivery = item.deliveryOption;

    // showDialog(
    //   context: context,
    //   builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text("Edit Food Item"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectImages(context, ref, image);
                    // openImagePickerDialog(context, image);
                  },
                  child: const Text("Update Image"),
                ),
                // if (selectedImage != null)
                //   SizedBox(
                //     width: 100,
                //     height: 100,
                //     child: Image.file(selectedImage!),
                //   ),
                TextField(
                  decoration: const InputDecoration(labelText: "Name"),
                  controller: nameController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Description"),
                  controller: descriptionController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Price"),
                  controller: priceController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Quantity"),
                  controller: quantityController,
                ),
                const Text("Availability"),
                CheckboxListTile(
                  title: const Text('Everytime'),
                  value: availablAllTime,
                  onChanged: (bool? value) {
                    setState(() {
                      availablAllTime = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Breakfast'),
                  value: breakfst,
                  onChanged: (bool? value) {
                    setState(() {
                      breakfst = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Lunch'),
                  value: lnch,
                  onChanged: (bool? value) {
                    setState(() {
                      lnch = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Evening Tea'),
                  value: evngT,
                  onChanged: (bool? value) {
                    setState(() {
                      evngT = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Dinner'),
                  value: dnnr,
                  onChanged: (bool? value) {
                    setState(() {
                      dnnr = value!;
                    });
                  },
                ),
                const Text("Categories"),
                TypeAheadField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: categoryController,
                    decoration: InputDecoration(
                      labelText: 'Categories',
                      border: const OutlineInputBorder(),
                      suffix: ElevatedButton(
                        onPressed: () {
                          ref.read(categoriesProvider.notifier).state = ref
                              .read(categoriesProvider.notifier)
                              .addCategory(categoryController!.text);
                          setState(() {
                            item.categories.add(categoryController!.text);
                          });
                          categoryController!.clear();
                          print(
                              "Length of categoriesProvider: ${ref.read(categoriesProvider).length}");
                        },
                        child: const Text("Add"),
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return Categories()
                        .categories
                        .where((tag) =>
                            tag.toLowerCase().contains(pattern.toLowerCase()))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                      onTap: () {
                        categoryController!.text = suggestion;
                      },
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    Categories().selectedCategory.add(suggestion);
                  },
                ),
                SizedBox(
                  height: item.categories.length * R.sh(50, context),
                  width: R.sw(375, context),
                  child: ListView.builder(
                    itemCount: item.categories.length,
                    itemBuilder: (context, index) {
                      final category = item.categories[index];
                      return Chip(
                        label: Text(category),
                        onDeleted: () {
                          item.categories.removeAt(index);
                          print(
                              "Length of categoriesProvider: ${item.categories.length}");
                        },
                      );
                    },
                  ),
                ),

                const Text("Delivery options"),
                CheckboxListTile(
                  title: const Text('Pick-up'),
                  value: pickUp,
                  onChanged: (bool? value) {
                    setState(() {
                      pickUp = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Home delivery'),
                  value: homeDelivery,
                  onChanged: (bool? value) {
                    setState(() {
                      homeDelivery = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                clearFormFields(context, ref);
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                try {
                  final updatedItem = FoodMenuItem(
                    imageUrl: image != null ? image! : null,
                    name: nameController.text,
                    description: descriptionController.text,
                    price: priceController.text,
                    availableAllTime: availablAllTime!,
                    availableForBreakfast: breakfst!,
                    availableForLunch: lnch!,
                    availableForEveningTea: evngT!,
                    availableForDinner: dnnr!,
                    pickupOption: pickUp!,
                    deliveryOption: homeDelivery!,
                    quantityAvailable: quantityController.text,
                    categories: ref.watch(categoriesProvider),
                  );
                  setState(() {
                    menuScreenController.menuItems[selectedMenuItemIndex!] =
                        updatedItem;
                  });
                  clearFormFields(context, ref);
                  Navigator.pop(context);
                } catch (e) {
                  print(e.toString());
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
    //     },
    //   );
  }
}
