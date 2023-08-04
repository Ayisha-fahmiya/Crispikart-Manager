// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/Main%20screens/main_screen.dart';
import 'package:restaurant_app/utilities/app_theme.dart';
import 'package:image_picker/image_picker.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({Key? key}) : super(key: key);

  @override
  CompanyProfileScreenState createState() => CompanyProfileScreenState();
}

class CompanyProfileScreenState extends State<CompanyProfileScreen> {
  late TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerContactNumberController = TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController establishedYearController = TextEditingController();
  TextEditingController numberOfEmployeesController = TextEditingController();
  TextEditingController managerNameController = TextEditingController();
  TextEditingController managerContactNumberController =
      TextEditingController();

  List<bool> selectedPaymentOptions = [false, false, false];
  List<bool> selectedSettlementModes = [false, false];

  List<bool> selectedSettlementTypes = [false, false];
  String? selectedSettlementType;
  List<String> settlementTypes = ['Daily', 'Weekly'];

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        Color;
      }
    });
  }

  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          title: const Text(
            'Choose Image',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(Icons.camera_alt_rounded),
                      SizedBox(width: 8),
                      Text(
                        'Take a photo',
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(Icons.photo),
                      SizedBox(width: 8),
                      Text('Choose from gallery'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      backgroundColor: appTheme.colorScheme.primary,
      foregroundColor: appTheme.colorScheme.onPrimary,
    );

    final ButtonStyle secondaryStyle = ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: const Color(0xFF4F5252),
        foregroundColor: appTheme.colorScheme.onPrimary);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(
          'Company Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[500],
              radius: 60,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: const Icon(
                Icons.camera_alt,
                size: 36,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: secondaryStyle,
              onPressed: () {
                setState(() {
                  _showImageSourceDialog();
                });
              },
              child: const Center(
                child: Text('Set profile picture'),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: ownerNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1),
                ),
                hintText: 'Owner Name',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ownerContactNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1),
                ),
                hintText: 'Owner Contact Number',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: whatsappNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1),
                ),
                hintText: 'Whatsapp Number',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1),
                ),
                hintText: 'Email ID',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: establishedYearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1),
                ),
                hintText: 'Established Year',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numberOfEmployeesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1),
                ),
                hintText: 'Number of Employees',
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Hotel Manager Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: managerNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1),
                ),
                hintText: 'Manager Name',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: managerContactNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1),
                ),
                hintText: 'Manager Contact Number',
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Payment Options',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10.0),
            CheckboxListTile(
              title: const Text('Cash on Delivery'),
              value: selectedPaymentOptions[0],
              onChanged: (value) {
                setState(() {
                  selectedPaymentOptions[0] = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Online Payment'),
              value: selectedPaymentOptions[1],
              onChanged: (value) {
                setState(() {
                  selectedPaymentOptions[1] = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('UPI Payment'),
              value: selectedPaymentOptions[2],
              onChanged: (value) {
                setState(() {
                  selectedPaymentOptions[2] = value!;
                });
              },
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Settlement',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Settlement type',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            Column(
              children: settlementTypes
                  .map(
                    (type) => RadioListTile(
                      title: Text(type),
                      value: type,
                      groupValue: selectedSettlementType,
                      onChanged: (value) {
                        setState(() {
                          selectedSettlementType = value.toString();
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Settlement mode',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10.0),
            CheckboxListTile(
              title: const Text('Cash'),
              value: selectedSettlementModes[0],
              onChanged: (value) {
                setState(() {
                  selectedSettlementModes[0] = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Bank Transfer'),
              value: selectedSettlementModes[1],
              onChanged: (value) {
                setState(() {
                  selectedSettlementModes[1] = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: style,
              onPressed: () {
                saveCompanyCredentials();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    'Save profile',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveCompanyCredentials() {
    // Fetch the entered values from the text fields and checkbox values
    String ownerName = ownerNameController.text;
    String ownerContactNumber = ownerContactNumberController.text;
    String whatsappNumber = whatsappNumberController.text;
    String email = emailController.text;
    String establishedYear = establishedYearController.text;
    String numberOfEmployees = numberOfEmployeesController.text;
    String managerName = managerNameController.text;
    String managerContactNumber = managerContactNumberController.text;

    // Show a success message or navigate to another screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Profile Saved',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          content: const Text('Your profile has been saved successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    List<String> selectedPaymentOptionsList = [];
    if (selectedPaymentOptions[0]) {
      selectedPaymentOptionsList.add('Cash on Delivery');
    }
    if (selectedPaymentOptions[1]) {
      selectedPaymentOptionsList.add('Online Payment');
    }
    if (selectedPaymentOptions[2]) {
      selectedPaymentOptionsList.add('UPI Payment');
    }

    List<String> selectedSettlementTypesList = [];
    if (selectedSettlementTypes[0]) {
      selectedSettlementTypesList.add('Daily');
    }
    if (selectedSettlementTypes[1]) {
      selectedSettlementTypesList.add('Weekly');
    }

    // Use the values as needed
    print('Owner Name: $ownerName');
    print('Owner Contact Number: $ownerContactNumber');
    print('Whatsapp Number: $whatsappNumber');
    print('Email: $email');
    print('Established Year: $establishedYear');
    print('Number of Employees: $numberOfEmployees');
    print('Manager Name: $managerName');
    print('Manager Contact Number: $managerContactNumber');
    print('Selected Payment Options: $selectedPaymentOptionsList');
    print('Selected Settlement Type: $selectedSettlementType');
    print('Selected Settlement Modes: $selectedSettlementModes');
  }
}
