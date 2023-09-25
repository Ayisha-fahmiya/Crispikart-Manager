import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/Screens/Sub-screens/help_and_support_screen.dart';
import 'package:restaurant_app/Screens/Sub-screens/profile_settings_screen.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/providers/language_provider.dart';
import 'package:restaurant_app/responsive/responsive.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> languages = ref.watch(languagesProvider);
    String language = ref.watch(selectedLanguageProvider);
    final themeMode = ref.watch(themeModeProvider);
    Color colour =
        themeMode == ThemeMode.dark ? Colors.white70 : Colors.black87;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(
              Icons.manage_accounts,
              size: 26,
              color: colour,
            ),
            title: Text(
              'Profile Settings',
              style: TextStyle(
                color: colour,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileSettings(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.translate,
              size: 26,
              color: colour,
            ),
            title: Text(
              'Language',
              style: TextStyle(
                color: colour,
              ),
            ),
            subtitle: Text(language),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Select Language',
                    ),
                    content: SizedBox(
                      height: R.sh(180, context),
                      width: R.sw(500, context),
                      child: ListView.builder(
                        itemCount: languages.length,
                        itemBuilder: (context, index) {
                          final lng = languages[index];
                          return ListTile(
                            title: Text(lng),
                            onTap: () {
                              setState(() {
                                ref
                                    .read(selectedLanguageProvider.notifier)
                                    .state = lng;
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SwitchListTile(
            secondary: Icon(
              themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
              size: 26,
              color: colour,
            ),
            title: Text(
              'App Theme',
              style: TextStyle(
                color: colour,
              ),
            ),
            subtitle: Text(
                themeMode == ThemeMode.dark ? 'Dark Theme' : 'Light Theme'),
            value: themeMode == ThemeMode.dark ? true : false,
            onChanged: (value) {
              if (value) {
                ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
              } else {
                ref.read(themeModeProvider.notifier).state = ThemeMode.light;
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              size: 26,
              color: colour,
            ),
            title: Text(
              'Help & Support',
              style: TextStyle(
                color: colour,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpAndSupport(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
