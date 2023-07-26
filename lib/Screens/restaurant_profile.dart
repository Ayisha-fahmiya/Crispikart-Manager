// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:restaurant_app/Screens/company_profile.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class RestaurantProfile extends StatefulWidget {
  const RestaurantProfile({super.key});

  @override
  RestaurantProfileState createState() => RestaurantProfileState();
}

class RestaurantProfileState extends State<RestaurantProfile> {
  List<String> _restaurantImages = [];
  LatLng? _restaurantLocation;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  TimeOfDay breakfastTime = const TimeOfDay(
      hour: TimeOfDay.hoursPerDay, minute: TimeOfDay.minutesPerHour);
  TimeOfDay lunchTime = const TimeOfDay(
      hour: TimeOfDay.hoursPerDay, minute: TimeOfDay.minutesPerHour);
  TimeOfDay dinnerTime = const TimeOfDay(
      hour: TimeOfDay.hoursPerDay, minute: TimeOfDay.minutesPerHour);

  List<String> orderTypes = [];

  final ImagePicker _imagePicker = ImagePicker();
  final ButtonStyle style = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      backgroundColor: appTheme.colorScheme.primary,
      foregroundColor: appTheme.colorScheme.onPrimary);

  final ButtonStyle secondaryStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      backgroundColor: const Color(0xFF4F5252),
      foregroundColor: appTheme.colorScheme.onPrimary);

  Future<void> _selectTime(BuildContext context, TimeOfDay onTimeSelected,
      Function(TimeOfDay) setTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: onTimeSelected,
    );

    if (pickedTime != null && pickedTime != onTimeSelected) {
      setState(() {
        setTime(pickedTime);
      });
    }
  }

  Future<void> _selectImages() async {
    List<XFile>? imageFiles = await _imagePicker.pickMultiImage();
    setState(() {
      _restaurantImages = imageFiles.map((image) => image.path).toList();
    });
  }

  Future<void> _getLocation() async {
    LocationPermission permission;

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    // Get current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _restaurantLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void _showTimePicker(BuildContext context, bool isStartTime) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((selectedTime) {
      if (selectedTime != null) {
        setState(() {
          if (isStartTime) {
            _startTime = selectedTime;
          } else {
            _endTime = selectedTime;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
        ),
        scrolledUnderElevation: 0,
        title: const Text(
          'Restaurant Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Restaurant Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter restaurant name',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Restaurant Images',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount:
                  _restaurantImages.length > 3 ? 3 : _restaurantImages.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: FileImage(File(_restaurantImages[index])),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              label: const Text('Add images'),
              icon: const Icon(Icons.add),
              style: secondaryStyle,
              onPressed: _selectImages,
            ),
            const SizedBox(height: 16),
            const Text(
              'Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter restaurant address',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              label: const Text('Add location'),
              icon: const Icon(Icons.location_on),
              style: secondaryStyle,
              onPressed: _getLocation,
            ),
            const SizedBox(
              height: 10,
            ),
            if (_restaurantLocation != null)
              SizedBox(
                height: 200,
                child: FlutterMap(
                  options: MapOptions(
                    center: _restaurantLocation!,
                    zoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: _restaurantLocation!,
                          builder: (ctx) => const Icon(Icons.location_on,
                              size: 50, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Working Hours',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  style: secondaryStyle,
                  onPressed: () => _showTimePicker(context, true),
                  child: const Text('Select Start Time'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: secondaryStyle,
                  onPressed: () => _showTimePicker(context, false),
                  child: const Text('Select End Time'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_startTime != null && _endTime != null)
              Column(
                children: [
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText:
                          '${_startTime!.format(context)}  to  ${_endTime!.format(context)}',
                      hintStyle: const TextStyle(fontSize: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(
                Icons.free_breakfast_rounded,
                size: 32,
              ),
              title: const Text(
                'Breakfast',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(breakfastTime != null
                  ? breakfastTime.format(context)
                  : 'Not set'),
              onTap: () {
                _selectTime(context, breakfastTime, (TimeOfDay time) {
                  setState(() {
                    breakfastTime = time;
                  });
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.lunch_dining_rounded,
                size: 32,
              ),
              title: const Text(
                'Lunch',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                  lunchTime != null ? lunchTime.format(context) : 'Not set'),
              onTap: () {
                _selectTime(context, lunchTime, (TimeOfDay time) {
                  setState(() {
                    lunchTime = time;
                  });
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.restaurant_menu_rounded,
                size: 34,
              ),
              title: const Text(
                'Dinner',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                  dinnerTime != null ? dinnerTime.format(context) : 'Not set'),
              onTap: () {
                _selectTime(context, dinnerTime, (TimeOfDay time) {
                  setState(() {
                    dinnerTime = time;
                  });
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Order Accepted',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              value: orderTypes.contains('Delivery'),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    orderTypes.add('Delivery');
                  } else {
                    orderTypes.remove('Delivery');
                  }
                });
              },
              title: const Text('Delivery'),
            ),
            CheckboxListTile(
              value: orderTypes.contains('Pick-up'),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    orderTypes.add('Pick-up');
                  } else {
                    orderTypes.remove('Pick-up');
                  }
                });
              },
              title: const Text('Pick-up'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter phone number',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter WhatsApp number',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter email ID',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyProfileScreen()),
                );
              },
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                      child: Text(
                    'Save Profile',
                    style: TextStyle(fontSize: 16),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
