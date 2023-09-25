import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/Screens/Sub-screens/company_profile_screen.dart';
import 'package:restaurant_app/Screens/Sub-screens/restaurant_profile.dart';
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
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(color: colour),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: ListView(
          children: [
            ListTileWidget(
              themeMode: themeMode,
              title: "Restaurant Profile",
              icon: Icons.restaurant_menu,
              page: RestaurantProfileInfo(),
            ),
            SizedBox(
              height: R.sh(12, context),
            ),
            ListTileWidget(
              themeMode: themeMode,
              title: "Company Profile",
              icon: Icons.business,
              page: CompanyProfile(),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.themeMode,
    required this.title,
    required this.icon,
    required this.page,
  });

  final ThemeMode themeMode;
  final String title;
  final IconData icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: R.sh(80, context),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        tileColor:
            themeMode == ThemeMode.dark ? Colors.grey[900] : Colors.white,
        leading: Icon(
          icon,
          color: themeMode == ThemeMode.dark ? Colors.white70 : Colors.black54,
        ),
        title: Text(title),
        trailing: Icon(
          Icons.arrow_forward,
          color: themeMode == ThemeMode.dark ? Colors.white70 : Colors.black54,
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        ),
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
