import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_app/controllers/menu_screen_controller.dart';
import 'package:restaurant_app/models/food_menu_model.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/providers/availability_provider.dart';
import 'package:restaurant_app/providers/delivery_options_provider.dart';
import 'package:restaurant_app/providers/form_field_controller_provider.dart';
import 'package:restaurant_app/responsive/responsive.dart';
import 'package:restaurant_app/utilities/clear_form.dart';
import '../controllers/categories_controller.dart';
import '../providers/category_provider.dart';
import '../providers/image_picker_provider.dart';

int? selectedMenuItemIndex;
bool? availablAllTime;
bool? breakfst;
bool? lnch;
bool? evngT;
bool? dnnr;

TextEditingController? categoryController;

bool? pickUp;
bool? homeDelivery;

class OpenAddDialoq {
  StatefulBuilder openAddDialoq(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameControllerProvider);
    final descriptionController = ref.watch(descriptionControllerProvider);
    final priceController = ref.watch(priceControllerProvider);
    final quantityController = ref.watch(quantityControllerProvider);

    var selectedImage = ref.watch(imageProvider);
    final menuScreenController = ref.watch(menuItemsProvider);

    final themeMode = ref.watch(themeModeProvider);
    Color colour =
        themeMode == ThemeMode.dark ? Colors.white70 : Colors.black54;

    selectedMenuItemIndex = null;
    availablAllTime = ref.watch(everyTime);
    breakfst = ref.watch(breakfast);
    lnch = ref.watch(lunch);
    evngT = ref.watch(eveningTea);
    dnnr = ref.watch(dinner);

    categoryController = ref.watch(categoryTextEditingController);

    final selectedCategories = ref.watch(categoriesProvider);

    pickUp = ref.watch(pickUpProvider);
    homeDelivery = ref.watch(homeDeliverProvider);

    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text(
          "Add Food Item",
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              if (selectedImage != null)
                SizedBox(
                  height: R.sh(200, context),
                  width: R.sw(200, context),
                  child: Image.file(selectedImage!),
                ),
              ElevatedButton(
                onPressed: () async {
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

                                  // if (_image != null) {
                                  //   CroppedFile? cropped =
                                  //       await ImageCropper().cropImage(
                                  //     sourcePath: _image.path,
                                  //     aspectRatioPresets: [
                                  //       CropAspectRatioPreset.square,
                                  //       CropAspectRatioPreset.ratio3x2,
                                  //       CropAspectRatioPreset.original,
                                  //       CropAspectRatioPreset.ratio4x3,
                                  //       CropAspectRatioPreset.ratio16x9
                                  //     ],
                                  //     uiSettings: [
                                  //       AndroidUiSettings(
                                  //           toolbarTitle: 'Crop',
                                  //           cropGridColor: Colors.black,
                                  //           initAspectRatio:
                                  //               CropAspectRatioPreset.original,
                                  //           lockAspectRatio: false),
                                  //       IOSUiSettings(title: 'Crop')
                                  //     ],
                                  //   );

                                  //   if (cropped != null) {
                                  //     setState(() {
                                  //       selectedImage = File(cropped.path);
                                  //     });
                                  //   }
                                  // }
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
                child: const Text("Upload Image"),
                style: ElevatedButton.styleFrom(),
              ),
              TextFormField(
                style: TextStyle(color: colour),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: colour,
                  ),
                ),
                controller: nameController,
              ),
              TextFormField(
                style: TextStyle(color: colour),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    color: colour,
                  ),
                ),
                controller: descriptionController,
              ),
              TextFormField(
                style: TextStyle(color: colour),
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(
                    color: colour,
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: priceController,
              ),
              TextFormField(
                style: TextStyle(color: colour),
                decoration: InputDecoration(
                  labelText: 'Quantity available',
                  labelStyle: TextStyle(
                    color: colour,
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: quantityController,
              ),
              const Text(
                "Availability",
              ),
              CheckboxListTile(
                title: const Text(
                  'Everytime',
                ),
                value: availablAllTime,
                onChanged: (bool? value) {
                  setState(() {
                    availablAllTime = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text(
                  'Breakfast',
                ),
                value: breakfst,
                onChanged: (bool? value) {
                  setState(() {
                    breakfst = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text(
                  'Lunch',
                ),
                value: lnch,
                onChanged: (bool? value) {
                  setState(() {
                    lnch = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text(
                  'Evening Tea',
                ),
                value: evngT,
                onChanged: (bool? value) {
                  setState(() {
                    evngT = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text(
                  'Dinner',
                ),
                value: dnnr,
                onChanged: (bool? value) {
                  setState(() {
                    dnnr = value!;
                  });
                },
              ),
              const Text(
                "Categories",
              ),
              TypeAheadField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  style: TextStyle(color: colour),
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: 'Categories',
                    border: const OutlineInputBorder(),
                    suffix: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(categoriesProvider.notifier)
                            .addCategory(categoryController!.text);
                        setState(() {
                          selectedCategories.add(categoryController!.text);
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
                    tileColor:
                        themeMode == ThemeMode.dark ? Colors.black87 : null,
                    title: Text(suggestion),
                    onTap: () {
                      categoryController!.text = suggestion;
                    },
                  );
                },
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    CategoriesNotifier().addCategory(suggestion);
                  });
                },
              ),
              SizedBox(
                height: selectedCategories.length * R.sh(50, context),
                width: R.sw(375, context),
                child: ListView.builder(
                  itemCount: selectedCategories.length,
                  itemBuilder: (context, index) {
                    final category = selectedCategories[index];
                    return Chip(
                      label: Text(category),
                      onDeleted: () {
                        setState(() {
                          selectedCategories.removeAt(index);
                        });
                        print(
                            "Length of categoriesProvider: ${ref.read(categoriesProvider).length}");
                      },
                    );
                  },
                ),
              ),
              const Text(
                "Delivery options",
              ),
              CheckboxListTile(
                title: const Text(
                  'Pick Up',
                ),
                value: pickUp,
                onChanged: (bool? value) {
                  setState(() {
                    pickUp = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text(
                  'Home Delivery',
                ),
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
                setState(() {
                  final newItem = FoodMenuItem(
                    imageUrl: selectedImage,
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
                  if (nameController.text != "" &&
                      descriptionController.text != "" &&
                      priceController.text != "" &&
                      quantityController.text != "") {
                    ref.read(menuItemsProvider.notifier).addFoodItem(newItem);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Fill everything properly"),
                      ),
                    );
                  }
                });
                print(menuScreenController.length);
                clearFormFields(context, ref);
                Navigator.pop(context);
              } catch (e) {
                print(e.toString());
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
