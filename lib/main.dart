import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/Screens/Main%20screens/main_screen.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: RestaurantManagerApp(),
    ),
  );
}

class RestaurantManagerApp extends ConsumerWidget {
  const RestaurantManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const MainScreen(),
    );
  }
}

class DarkModeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: false,
      onChanged: (enabled) {
        if (enabled) {
          AppTheme.darkTheme;
        } else {
          AppTheme.lightTheme;
        }
      },
    );
  }
}
