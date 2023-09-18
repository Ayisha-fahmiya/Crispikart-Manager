import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_app/controllers/categories_controller.dart';
import 'package:restaurant_app/controllers/menu_screen_controller.dart';
import 'package:restaurant_app/models/food_menu_model.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/providers/category_provider.dart';
import 'package:restaurant_app/providers/form_field_controller_provider.dart';
import 'package:restaurant_app/providers/image_picker_provider.dart';
import 'package:restaurant_app/responsive/responsive.dart';
import 'package:restaurant_app/utilities/clear_form.dart';
import 'package:restaurant_app/utilities/menu_screen_open_add_dialog.dart';

File? image;

class OpenEditDialog {
  StatefulBuilder openEditDialog(
      BuildContext context, WidgetRef ref, int index) {
    final nameController = ref.watch(nameControllerProvider);
    final descriptionController = ref.watch(descriptionControllerProvider);
    final priceController = ref.watch(priceControllerProvider);
    final quantityController = ref.watch(quantityControllerProvider);
    var selectedImage = ref.watch(imageProvider);
    TextEditingController editctgryController =
        ref.watch(editCategoryController);
    final menuScreenController = ref.watch(menuItemsProvider);
    List selectedCategories = ref.watch(categoriesProvider);

    final item = menuScreenController[index];
    selectedImage = item.imageUrl;
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
    selectedCategories = item.categories;

    final themeMode = ref.watch(themeModeProvider);
    Color colour =
        themeMode == ThemeMode.dark ? Colors.white70 : Colors.black54;

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text("Edit Food Item"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                if (selectedImage != null)
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.file(selectedImage!),
                  ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Select Image',
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                GestureDetector(
                                  child: const Text(
                                    'Gallery',
                                  ),
                                  onTap: () async {
                                    final _image = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      selectedImage = _image != null
                                          ? File(_image.path)
                                          : null;
                                    });

                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  child: const Text(
                                    'Camera',
                                  ),
                                  onTap: () async {
                                    final _image = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);

                                    setState(() {
                                      selectedImage = _image != null
                                          ? File(_image.path)
                                          : null;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("Update Image"),
                ),
                TextField(
                  style: TextStyle(color: colour),
                  decoration: const InputDecoration(labelText: "Name"),
                  controller: nameController,
                ),
                TextField(
                  style: TextStyle(color: colour),
                  decoration: const InputDecoration(labelText: "Description"),
                  controller: descriptionController,
                ),
                TextField(
                  style: TextStyle(color: colour),
                  decoration: const InputDecoration(labelText: "Price"),
                  controller: priceController,
                ),
                TextField(
                  style: TextStyle(color: colour),
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
                    controller: editctgryController,
                    style: TextStyle(color: colour),
                    decoration: InputDecoration(
                      labelText: 'Categories',
                      border: const OutlineInputBorder(),
                      suffix: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedCategories.add(editctgryController.text);
                          });
                          editctgryController.clear();
                          print(
                              "Length of categoriesProvider: ${selectedCategories.length}");
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
                      tileColor:
                          themeMode == ThemeMode.dark ? Colors.black87 : null,
                      title: Text(suggestion),
                      onTap: () {
                        editctgryController.text = suggestion;
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
                          setState(() {
                            item.categories.removeAt(index);
                          });
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
                    imageUrl: selectedImage != null ? selectedImage! : null,
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
                    categories: selectedCategories,
                  );
                  setState(() {
                    menuScreenController[selectedMenuItemIndex!] = updatedItem;
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
