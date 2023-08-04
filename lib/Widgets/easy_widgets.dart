import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/Main%20screens/settings.dart';
import 'package:restaurant_app/Screens/signin_screen.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class MyElevatedButton extends StatelessWidget {
  MyElevatedButton(
      {super.key, required this.buttonName, required this.onPressed});

  final VoidCallback? onPressed;
  final String buttonName;
  final ButtonStyle style = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(14),
      backgroundColor: appTheme.colorScheme.primary,
      foregroundColor: appTheme.colorScheme.onPrimary);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            buttonName,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor:
          isDarkMode ? const Color(0xFF202020) : appTheme.colorScheme.onPrimary,
      child: Material(
        color: isDarkMode
            ? const Color(0xFF202020)
            : appTheme.colorScheme.onPrimary,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: appTheme.colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  const SearchFieldDrawer(),
                  const SizedBox(height: 12),
                  MenuItem(
                    text: 'Profile',
                    icon: Icons.person,
                    onTap: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 5),
                  MenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onTap: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 5),
                  MenuItem(
                    text: 'Menu',
                    icon: Icons.book,
                    onTap: () => selectedItem(context, 2),
                  ),
                  MenuItem(
                    text: 'Orders',
                    icon: Icons.list_alt_rounded,
                    onTap: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    thickness: 2,
                    color: isDarkMode ? Colors.grey[750] : Colors.grey[350],
                    endIndent: 30,
                    indent: 30,
                  ),
                  const SizedBox(height: 8),
                  MenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Scaffold(), // Page 1
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SettingsScreen(), // Page 2
        ));
        break;
    }
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  const MenuItem({
    required this.text,
    required this.icon,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(icon, color: appTheme.colorScheme.primary),
      title: Text(
        text,
        style: TextStyle(
            color: isDarkMode ? Colors.grey : const Color(0xFF4F5252),
            fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}

class SearchFieldDrawer extends StatelessWidget {
  const SearchFieldDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      style: TextStyle(color: appTheme.colorScheme.primary, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          Icons.search,
          color: isDarkMode ? Colors.white : const Color(0xFF4F5252),
          size: 20,
        ),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: appTheme.colorScheme.primary.withOpacity(0.7), width: 2),
        ),
      ),
    );
  }
}
