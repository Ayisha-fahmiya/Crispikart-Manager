import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Screens/Main%20screens/main_screen.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

void main() {
  runApp(const RestaurantManagerApp());
}

class ThemeCubit extends ChangeNotifier {
  bool _state = false;

  bool get state => _state;

  void toggleTheme() {
    _state = !_state;
    notifyListeners();
  }
}

class RestaurantManagerApp extends StatelessWidget {
  const RestaurantManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: Consumer<ThemeCubit>(
        builder: (context, themeCubit, _) {
          final themeMode = themeCubit.state ? ThemeMode.dark : ThemeMode.light;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant App',
            theme: appTheme,
            darkTheme: ThemeData.dark().copyWith(
              textTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: 'Poppins',
                  ),
            ),
            themeMode: themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
