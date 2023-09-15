// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_app/Screens/Main%20screens/menu_screen2.dart';
import 'package:restaurant_app/models/food_menu_model.dart';
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

    // final themeMode = ref.watch(themeModeProvider);
    // Color colour =
    //     themeMode == ThemeMode.dark ? Colors.white70 : Colors.black54;

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
        // backgroundColor:
        //     themeMode == ThemeMode.dark ? Colors.black : Colors.white,
        title: Text(
          "Add Food Item",
          style: TextStyle(
              // color: colour,
              ),
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
                        // backgroundColor: themeMode == ThemeMode.dark
                        //     ? Colors.black
                        //     : Colors.white,
                        title: Text(
                          'Select Image',
                          // style: TextStyle(color: colour),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              GestureDetector(
                                child: Text(
                                  'Gallery',
                                  // style: TextStyle(color: colour),
                                ),
                                onTap: () async {
                                  final _image = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  setState(() {
                                    selectedImage = _image != null
                                        ? File(_image.path)
                                        : null;
                                  });

                                  if (_image != null) {
                                    CroppedFile? cropped =
                                        await ImageCropper().cropImage(
                                      sourcePath: _image.path,
                                      aspectRatioPresets: [
                                        CropAspectRatioPreset.square,
                                        CropAspectRatioPreset.ratio3x2,
                                        CropAspectRatioPreset.original,
                                        CropAspectRatioPreset.ratio4x3,
                                        CropAspectRatioPreset.ratio16x9
                                      ],
                                      uiSettings: [
                                        AndroidUiSettings(
                                            toolbarTitle: 'Crop',
                                            cropGridColor: Colors.black,
                                            initAspectRatio:
                                                CropAspectRatioPreset.original,
                                            lockAspectRatio: false),
                                        IOSUiSettings(title: 'Crop')
                                      ],
                                    );

                                    if (cropped != null) {
                                      setState(() {
                                        selectedImage = File(cropped.path);
                                      });
                                    }
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(height: 16),
                              GestureDetector(
                                child: Text(
                                  'Camera',
                                  // style: TextStyle(color: colour),
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
                child: Text("Upload Image"),
                style: ElevatedButton.styleFrom(
                    // backgroundColor:
                    //     themeMode == ThemeMode.dark ? Colors.white70 : null,
                    ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                      // color: colour,
                      ),
                ),
                controller: nameController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                      // color: colour,
                      ),
                ),
                controller: descriptionController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(
                      // color: colour,
                      ),
                ),
                keyboardType: TextInputType.number,
                controller: priceController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Quantity available',
                  labelStyle: TextStyle(
                      // color: colour,
                      ),
                ),
                keyboardType: TextInputType.number,
                controller: quantityController,
              ),
              Text(
                "Availability",
                // style: TextStyle(color: colour),
              ),
              CheckboxListTile(
                title: Text(
                  'Everytime',
                  // style: TextStyle(color: colour),
                ),
                value: availablAllTime,
                onChanged: (bool? value) {
                  setState(() {
                    availablAllTime = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Breakfast',
                  // style: TextStyle(color: colour),
                ),
                value: breakfst,
                onChanged: (bool? value) {
                  setState(() {
                    breakfst = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Lunch',
                  // style: TextStyle(color: colour),
                ),
                value: lnch,
                onChanged: (bool? value) {
                  setState(() {
                    lnch = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Evening Tea',
                  // style: TextStyle(color: colour),
                ),
                value: evngT,
                onChanged: (bool? value) {
                  setState(() {
                    evngT = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Dinner',
                  // style: TextStyle(color: colour),
                ),
                value: dnnr,
                onChanged: (bool? value) {
                  setState(() {
                    dnnr = value!;
                  });
                },
              ),
              Text(
                "Categories",
                // style: TextStyle(color: colour),
              ),
              TypeAheadField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: 'Categories',
                    border: OutlineInputBorder(),
                    suffix: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(categoriesProvider.notifier)
                            .addCategory(categoryController!.text);
                        // ref.invalidate(categoriesProvider);

                        categoryController!.clear();

                        print(
                            "Length of categoriesProvider: ${ref.read(categoriesProvider).length}");
                      },
                      child: Text("Add"),
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
                        selectedCategories.removeAt(index);
                        print(
                            "Length of categoriesProvider: ${ref.read(categoriesProvider).length}");
                      },
                    );
                  },
                ),
              ),
              Text(
                "Delivery options",
                // style: TextStyle(color: colour),
              ),
              CheckboxListTile(
                title: Text(
                  'Pick Up',
                  // style: TextStyle(color: colour),
                ),
                value: pickUp,
                onChanged: (bool? value) {
                  setState(() {
                    pickUp = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Home Delivery',
                  // style: TextStyle(color: colour),
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
            child: Text("Cancel"),
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
                    categories: ref.read(categoriesProvider),
                  );
                  if (nameController.text != "" &&
                      descriptionController.text != "" &&
                      priceController.text != "" &&
                      quantityController.text != "") {
                    menuScreenController.menuItems.add(newItem);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Fill everything properly"),
                      ),
                    );
                  }
                });
                print(menuScreenController.menuItems.length);
                clearFormFields(context, ref);
                Navigator.pop(context);
              } catch (e) {
                print(e.toString());
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}
