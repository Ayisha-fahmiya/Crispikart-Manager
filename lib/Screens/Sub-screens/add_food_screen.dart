import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  File? _image;
  bool _isAvailable = true;
  bool _deliveryOptionCashOnDelivery = false;
  bool _deliveryOptionOnlinePayment = false;
  bool _deliveryOptionUPI = false;
  bool _isVeg = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 0,
        title: const Text(
          'Add Food',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ),
      body: BlocProvider(
        create: (_) => ExpansionTileBloc(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildImagePicker(),
                const SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Quantity'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a quantity';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid quantity';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Original Price'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an original price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid original price';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Discounted Price'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a discounted price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid discounted price';
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Group'),
                        hint: const Text('Select Group'),
                        items: ['Group 1', 'Group 2', 'Group 3']
                            .map((group) => DropdownMenuItem(
                                  value: group,
                                  child: Text(group),
                                ))
                            .toList(),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a group';
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration(labelText: 'Category'),
                        hint: const Text('Select Category'),
                        items: ['Category 1', 'Category 2', 'Category 3']
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Delivery Options',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          CheckboxListTile(
                            title: const Text('Cash on Delivery'),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: _deliveryOptionCashOnDelivery,
                            onChanged: (value) {
                              setState(() {
                                _deliveryOptionCashOnDelivery = value ?? false;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Online Payment'),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: _deliveryOptionOnlinePayment,
                            onChanged: (value) {
                              setState(() {
                                _deliveryOptionOnlinePayment = value ?? false;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('UPI ID'),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: _deliveryOptionUPI,
                            onChanged: (value) {
                              setState(() {
                                _deliveryOptionUPI = value ?? false;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Food type',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: _isVeg,
                            onChanged: (value) {
                              setState(() {
                                _isVeg = value ?? true;
                              });
                            },
                          ),
                          const Text('Veg'),
                          Radio<bool>(
                            value: false,
                            groupValue: _isVeg,
                            onChanged: (value) {
                              setState(() {
                                _isVeg = value ?? true;
                              });
                            },
                          ),
                          const Text('Non-Veg'),
                        ],
                      ),
                      SwitchListTile(
                        title: const Text(
                          'Availability',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        value: _isAvailable,
                        onChanged: (value) {
                          setState(() {
                            _isAvailable = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save the food details
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return InkWell(
      onTap: () async {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        setState(() {
          _image = image != null ? File(image.path) : null;
        });
      },
      child: _image != null
          ? Image.file(_image!, height: 150)
          : CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.add_a_photo, size: 50),
            ),
    );
  }
}

class ExpansionTileBloc extends Cubit<bool> {
  ExpansionTileBloc() : super(false);

  void toggleExpansion() {
    emit(!state);
  }
}
