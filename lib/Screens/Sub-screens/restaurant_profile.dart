import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/Sub-screens/profile_settings_screen.dart';

class RestaurantProfileInfo extends StatelessWidget {
  const RestaurantProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Profile"),
      ),
      body: ListView(
        children: [
          ProfileHeaddingStyle(
            title: "Restaurant Name",
          ),
          Text("Name"),
          ProfileHeaddingStyle(
            title: "Restaurant Images",
          ),
          ProfileHeaddingStyle(
            title: "Address",
          ),
          ProfileHeaddingStyle(
            title: "Location",
          ),
          ProfileHeaddingStyle(
            title: "Working Hours",
          ),
          Text("- Start Time : "),
          Text("- End Time : "),
          ProfileHeaddingStyle(
            title: "Order Accepted",
          ),
          Text("- Delivery"),
          Text("- Pick-Up"),
          ProfileHeaddingStyle(
            title: "Contact Details",
          ),
          Text("- Phone Number : "),
          Text("- WhatsApp Number : "),
          Text("- Email : "),
        ],
      ),
    );
  }
}
