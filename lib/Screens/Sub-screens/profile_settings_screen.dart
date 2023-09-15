import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/Screens/Sub-screens/company_profile_screen.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/responsive/responsive.dart';

class ProfileSettings extends ConsumerWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    Color colour =
        themeMode == ThemeMode.dark ? Colors.white70 : Colors.black87;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: colour),
        ),
      ),
      body: ListView(
        children: [
          ProfileHeaddingStyle(
            title: "Restaurant Name",
          ),
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
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompanyProfile(),
                ),
              );
            },
            child: Text("Company Profile"),
          )
        ],
      ),
    );
  }
}

class ProfileHeaddingStyle extends StatelessWidget {
  final String title;
  const ProfileHeaddingStyle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        // fontSize: R.sw(18, context),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
