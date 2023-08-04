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

// class ThemeCubit extends ChangeNotifier {
//   bool _state = false;

//   bool get state => _state;

//   void toggleTheme() {
//     _state = !_state;
//     notifyListeners();
//   }
// }

class RestaurantManagerApp extends ConsumerWidget {
  const RestaurantManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(selectedTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: isDarkTheme ? darkTheme : lightTheme,
      // darkTheme: ThemeData.dark().copyWith(
      //   textTheme: ThemeData.dark().textTheme.apply(
      //         fontFamily: 'Poppins',
      //       ),
      // ),
      // themeMode: themeMode,
      home: const MainScreen(),
    );
    // child: Consumer<ThemeCubit>(
    //   builder: (context, themeCubit, _) {
    //     final themeMode = themeCubit.state ? ThemeMode.dark : ThemeMode.light;

    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: 'Restaurant App',
    //       theme: appTheme,
    //       darkTheme: ThemeData.dark().copyWith(
    //         textTheme: ThemeData.dark().textTheme.apply(
    //               fontFamily: 'Poppins',
    //             ),
    //       ),
    //       themeMode: themeMode,
    //       home: const MainScreen(),
    //     );
    //   },
    // ),
  }
}
