import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/utilities/theme_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(
              Icons.manage_accounts,
              size: 26,
            ),
            title: const Text('Profile Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.translate,
              size: 26,
            ),
            title: const Text('Language'),
            subtitle: const Text('English'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text('Select Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('English'),
                          onTap: null,
                        ),
                        ListTile(
                          title: Text('Hindi'),
                          onTap: null,
                        ),
                        ListTile(
                          title: Text('Malayalam'),
                          onTap: null,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Consumer<ThemeCubit>(
            builder: (context, themeCubit, _) {
              final themeState = themeCubit.state;
              return SwitchListTile(
                secondary: themeState
                    ? const Icon(
                        Icons.dark_mode,
                        size: 26,
                      )
                    : const Icon(
                        Icons.light_mode,
                        size: 26,
                      ),
                title: const Text('App Theme'),
                subtitle: themeState
                    ? const Text('Dark Theme')
                    : const Text('Light Theme'),
                value: themeState,
                onChanged: (value) {
                  themeCubit.toggleTheme();
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help,
              size: 26,
            ),
            title: const Text('Help & Support'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
