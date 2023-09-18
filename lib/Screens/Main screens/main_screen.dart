import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:restaurant_app/Screens/Main%20screens/chat_screen.dart';
import 'package:restaurant_app/Screens/Main%20screens/home_screen.dart';
import 'package:restaurant_app/Screens/Main%20screens/settings.dart';
import 'package:restaurant_app/Screens/Main%20screens/menu_screen2.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final controller = TextEditingController();
  // late PageController _pageController;

  List<Widget> pages = [
    HomeScreen(),
    ChatScreen(),
    MenuScreen2(),
    SettingsScreen(),
  ];
  int navBarIndex = 0;

  @override
  void initState() {
    super.initState();
    // _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    var colour = themeMode == ThemeMode.dark
        ? Colors.white
        : appTheme.colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Center(
          child: Image.asset(
            'assets/logos/Logo_color-01.png',
            height: 36,
            color: themeMode == ThemeMode.dark
                ? Colors.white
                : appTheme.colorScheme.primary,
          ),
        ),
        actions: [
          Icon(
            Icons.notifications,
          ),
        ],
      ),
      // body: PageView(
      //   controller: _pageController,
      //   onPageChanged: (index) {
      //     setState(() {
      //       navBarIndex = index;
      //     });
      //   },
      //   children: const [
      //     HomeScreen(),
      //     ChatScreen(),
      //     MenuScreen2(),
      //     SettingsScreen(),
      //   ],
      // ),
      body: pages[navBarIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(31, 158, 158, 158),
              blurRadius: 6,
              spreadRadius: 6,
            ),
          ],
          color: themeMode == ThemeMode.dark
              ? Color.fromARGB(255, 20, 20, 20)
              : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: GNav(
              padding: const EdgeInsets.all(16),
              haptic: true,
              backgroundColor: themeMode == ThemeMode.dark
                  ? Color.fromARGB(255, 20, 20, 20)
                  : Colors.white,
              gap: 8,
              activeColor: themeMode == ThemeMode.dark
                  ? Colors.white
                  : appTheme.colorScheme.primary,
              // tabActiveBorder: Border.all(
              //   color: themeMode == ThemeMode.dark
              //       ? Colors.grey
              //       : Colors.transparent,
              //   width: 2,
              // ),

              tabBackgroundColor: themeMode == ThemeMode.light
                  ? appTheme.colorScheme.primaryContainer
                  : Color.fromARGB(255, 48, 48, 48),
              selectedIndex: navBarIndex,
              onTabChange: (index) {
                setState(() {
                  navBarIndex = index;
                });
              },
              tabs: [
                GButton(
                  text: 'Home',
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeMode == ThemeMode.light
                        ? appTheme.colorScheme.primary
                        : Colors.white,
                  ),
                  icon: Icons.home,
                  iconColor: colour,
                ),
                GButton(
                  text: 'Chat',
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeMode == ThemeMode.light
                        ? appTheme.colorScheme.primary
                        : Colors.white,
                  ),
                  icon: Icons.chat,
                  iconColor: colour,
                ),
                GButton(
                  text: 'Food Menu',
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeMode == ThemeMode.light
                        ? appTheme.colorScheme.primary
                        : Colors.white,
                  ),
                  icon: Icons.restaurant,
                  iconColor: colour,
                ),
                GButton(
                  text: 'Settings',
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeMode == ThemeMode.light
                        ? appTheme.colorScheme.primary
                        : Colors.white,
                  ),
                  icon: Icons.settings,
                  iconColor: colour,
                ),
              ]),
        ),
      ),
    );
  }
}
