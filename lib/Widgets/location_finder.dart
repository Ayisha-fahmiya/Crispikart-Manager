import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationFinder extends StatefulWidget {
  const LocationFinder({super.key});

  @override
  LocationFinderState createState() => LocationFinderState();
}

class LocationFinderState extends State<LocationFinder> {
  String _locationMessage = '';

  void _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _locationMessage =
            'Latitude: ${position.latitude}\nLongitude: ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _locationMessage,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getLocation,
                child: const Text('Get Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
