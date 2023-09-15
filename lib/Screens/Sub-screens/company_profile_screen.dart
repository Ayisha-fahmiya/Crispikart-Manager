import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/Sub-screens/profile_settings_screen.dart';
import 'package:restaurant_app/responsive/responsive.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Profile"),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              SizedBox(
                width: R.sw(200, context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Owner Name",
                    ),
                    Text(
                      "Owner's Contact Number",
                    ),
                    Text(
                      "Owner's WhatsApp Number",
                    ),
                    Text(
                      "Owner's Email",
                    ),
                    Text(
                      "Established Year",
                    ),
                    Text(
                      "Number of Employees",
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name"),
                  Text("Contact Number"),
                  Text("WhatsApp Number"),
                  Text("Email"),
                  Text("Year"),
                  Text("Employees"),
                ],
              ),
            ],
          ),
          ProfileHeaddingStyle(
            title: "Hotel Manager Details",
          ),
          Row(
            children: [
              SizedBox(
                width: R.sw(200, context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Manager's Name"),
                    Text("Manager's Contact Number"),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name"),
                  Text("Contact Namber"),
                ],
              ),
            ],
          ),
          ProfileHeaddingStyle(
            title: "Payment Options",
          ),
          Text("- Cash on Delivery"),
          Text("- Online Payment"),
          Text("- UPI Payment"),
          ProfileHeaddingStyle(
            title: "Settlement",
          ),
          Row(
            children: [
              SizedBox(
                width: R.sw(200, context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Settlement type"),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Daily / Weekly"),
                ],
              ),
            ],
          ),
          Text("Settlement mode"),
          Text("- Cash"),
          Text("- Bank Transfer"),
        ],
      ),
    );
  }
}
