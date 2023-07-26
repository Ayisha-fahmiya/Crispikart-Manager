import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_app/controllers/menu_screen_controller.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class FoodMenuItem {
  final String? imageUrl;
  final String name;
  final String description;
  final double price;
  final bool availableAllTime;
  final bool availableForBreakfast;
  final bool availableForLunch;
  final bool availableForDinner;
  final bool pickupOption;
  final bool deliveryOption;
  final int quantityAvailable;

  bool isDetailsVisible = false;

  FoodMenuItem({
    this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.availableAllTime,
    required this.availableForBreakfast,
    required this.availableForLunch,
    required this.availableForDinner,
    required this.pickupOption,
    required this.deliveryOption,
    required this.quantityAvailable,
  });
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

  final ButtonStyle secondaryStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      backgroundColor: const Color(0xFF4F5252),
      foregroundColor: appTheme.colorScheme.onPrimary);

  final MenuScreenController _menuScreenController = MenuScreenController();

  File? _image;
  int? selectedMenuItemIndex;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  bool availableAllTime = false;
  bool availableForBreakfast = false;
  bool availableForLunch = false;
  bool availableForDinner = false;
  bool pickupOption = false;
  bool deliveryOption = false;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  Future<void> _selectImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    setState(() {
                      _image = image != null ? File(image.path) : null;
                    });
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    setState(() {
                      _image = image != null ? File(image.path) : null;
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
  }

  void _openEditDialog(int index) {
    final item = _menuScreenController.menuItems[index];

    selectedMenuItemIndex = index;
    nameController.text = item.name;
    descriptionController.text = item.description;
    priceController.text = item.price.toString();
    availableAllTime = item.availableAllTime;
    availableForBreakfast = item.availableForBreakfast;
    availableForLunch = item.availableForLunch;
    availableForDinner = item.availableForDinner;
    pickupOption = item.pickupOption;
    deliveryOption = item.deliveryOption;
    quantityController.text = item.quantityAvailable.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                'Edit Food Item',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton(
                      style: secondaryStyle,
                      onPressed: _selectImage,
                      child: const Text('Update Image'),
                    ),
                    const SizedBox(height: 16),
                    if (_image != null)
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.file(_image!),
                      ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      controller: nameController,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      controller: descriptionController,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Price',
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      controller: priceController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Quantity Available',
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Availability',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text('Everytime'),
                      value: availableAllTime,
                      onChanged: (bool? value) {
                        setState(() {
                          availableAllTime = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Breakfast'),
                      value: availableForBreakfast,
                      onChanged: (bool? value) {
                        setState(() {
                          availableForBreakfast = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Lunch'),
                      value: availableForLunch,
                      onChanged: (bool? value) {
                        setState(() {
                          availableForLunch = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Dinner'),
                      value: availableForDinner,
                      onChanged: (bool? value) {
                        setState(() {
                          availableForDinner = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Delivery options',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text('Pick-up'),
                      value: pickupOption,
                      onChanged: (bool? value) {
                        setState(() {
                          pickupOption = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Home delivery'),
                      value: deliveryOption,
                      onChanged: (bool? value) {
                        setState(() {
                          deliveryOption = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    _clearFormFields();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Update'),
                  onPressed: () {
                    try {
                      final price = double.parse(priceController.text);
                      final quantity = int.parse(quantityController.text);

                      final updatedItem = FoodMenuItem(
                        imageUrl: _image != null ? _image!.path : item.imageUrl,
                        name: nameController.text,
                        description: descriptionController.text,
                        price: price,
                        availableAllTime: availableAllTime,
                        availableForBreakfast: availableForBreakfast,
                        availableForLunch: availableForLunch,
                        availableForDinner: availableForDinner,
                        pickupOption: pickupOption,
                        deliveryOption: deliveryOption,
                        quantityAvailable: quantity,
                      );

                      setState(() {
                        _menuScreenController
                            .menuItems[selectedMenuItemIndex!] = updatedItem;
                      });

                      _clearFormFields();
                      Navigator.of(context).pop();
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteMenuItem(int index) {
    setState(() {
      _menuScreenController.menuItems.removeAt(index);
    });
  }

  void _clearFormFields() {
    selectedMenuItemIndex = null;
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    quantityController.clear();
    _image = null;
    availableAllTime = false;
    availableForBreakfast = false;
    availableForLunch = false;
    availableForDinner = false;
    pickupOption = false;
    deliveryOption = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Food Menu',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        itemCount: _menuScreenController.menuItems.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _menuScreenController.menuItems[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.grey[300]!)),
              child: ExpansionTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      item.imageUrl != null ? Colors.transparent : Colors.grey,
                  child: item.imageUrl != null
                      ? ClipOval(
                          child: Image.file(
                            File(item.imageUrl!),
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black),
                          children: [
                            const TextSpan(
                                text: '₹ ',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                )),
                            TextSpan(
                                text: '${item.price}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                )),
                          ]),
                    ),
                    const SizedBox(height: 4),
                    // Text('Quantity Available: ${item.quantityAvailable}'),
                  ],
                ),
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Description',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item.description,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Availability',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 5),
                          item.availableAllTime
                              ? Text(
                                  '- Everytime',
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 5),
                          item.availableForBreakfast
                              ? Text(
                                  '- Breakfast',
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 5),
                          item.availableForLunch
                              ? Text(
                                  '- Lunch',
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 5),
                          item.availableForDinner
                              ? Text(
                                  '- Dinner',
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 16),
                          Text(
                            'Delivery options',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item.pickupOption ? '- Pick-up available' : '',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 5),
                          item.deliveryOption
                              ? Text(
                                  '- Home delivery available',
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 16),
                          Text(
                            'Quantity Available: ${item.quantityAvailable}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              TextButton(
                                child: const Text('Edit'),
                                onPressed: () {
                                  _openEditDialog(index);
                                },
                              ),
                              TextButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  _deleteMenuItem(index);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appTheme.colorScheme.primary,
        foregroundColor: appTheme.colorScheme.onPrimary,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => _openAddDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  StatefulBuilder _openAddDialog() {
    selectedMenuItemIndex = null;
    _clearFormFields();
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          title: const Text(
            'Add Food Item',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  style: secondaryStyle,
                  onPressed: _selectImage,
                  child: const Text('Select Image'),
                ),
                const SizedBox(height: 16),
                if (_image != null)
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.file(_image!),
                  ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: nameController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: descriptionController,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: priceController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Quantity Available',
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 22),
                const Text(
                  'Availability',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text('Everytime'),
                  value: availableAllTime,
                  onChanged: (bool? value) {
                    setState(() {
                      availableAllTime = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Breakfast'),
                  value: availableForBreakfast,
                  onChanged: (bool? value) {
                    setState(() {
                      availableForBreakfast = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Lunch'),
                  value: availableForLunch,
                  onChanged: (bool? value) {
                    setState(() {
                      availableForLunch = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Dinner'),
                  value: availableForDinner,
                  onChanged: (bool? value) {
                    setState(() {
                      availableForDinner = value!;
                    });
                  },
                ),
                const SizedBox(height: 22),
                const Text(
                  'Delivery options',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text('Pick-up'),
                  value: pickupOption,
                  onChanged: (bool? value) {
                    setState(() {
                      pickupOption = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Home delivery'),
                  value: deliveryOption,
                  onChanged: (bool? value) {
                    setState(() {
                      deliveryOption = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                _clearFormFields();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                try {
                  final price = double.parse(priceController.text);
                  final quantity = int.parse(quantityController.text);

                  final newItem = FoodMenuItem(
                    imageUrl: _image != null ? _image!.path : null,
                    name: nameController.text,
                    description: descriptionController.text,
                    price: price,
                    availableAllTime: availableAllTime,
                    availableForBreakfast: availableForBreakfast,
                    availableForLunch: availableForLunch,
                    availableForDinner: availableForDinner,
                    pickupOption: pickupOption,
                    deliveryOption: deliveryOption,
                    quantityAvailable: quantity,
                  );

                  setState(() {
                    _menuScreenController.menuItems.add(newItem);
                  });

                  _clearFormFields();
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }
}
