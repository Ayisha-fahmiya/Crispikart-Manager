import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/Screens/Main%20screens/home_screen.dart';
import 'package:restaurant_app/Screens/Main%20screens/settings.dart';
import 'package:restaurant_app/Screens/Sub-screens/menu_screen.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = TextEditingController();
  int _navIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeCubit(),
      child: Scaffold(
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
              color:
                  Provider.of<ThemeCubit>(context).brightness == Brightness.dark
                      ? appTheme.colorScheme.onPrimary
                      : null,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<ThemeCubit>(context, listen: false).toggleTheme();
              },
              icon: Icon(
                Provider.of<ThemeCubit>(context).brightness == Brightness.dark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                size: 30,
              ),
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _navIndex = index;
            });
          },
          children: const [
            HomeScreen(),
            Center(child: Text('Chat')),
            MenuScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          margin:
              const EdgeInsets.only(bottom: 16, right: 16, left: 16, top: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: appTheme.colorScheme.primary,
          ),
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _navIndex = 0;
                    });
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Image.asset(
                    'assets/icons/home.png',
                    color: _navIndex == 0 ? Colors.white : Colors.white38,
                    height: _navIndex == 0 ? 26 : 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _navIndex = 1;
                    });
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Image.asset(
                    'assets/icons/messages.png',
                    color: _navIndex == 1 ? Colors.white : Colors.white38,
                    height: _navIndex == 1 ? 26 : 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _navIndex = 2;
                    });
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Image.asset(
                    'assets/icons/restaurant.png',
                    color: _navIndex == 2 ? Colors.white : Colors.white38,
                    height: _navIndex == 2 ? 28 : 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _navIndex = 3;
                    });
                    _pageController.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Image.asset(
                    'assets/icons/settings.png',
                    color: _navIndex == 3 ? Colors.white : Colors.white38,
                    height: _navIndex == 3 ? 26 : 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeCubit extends ChangeNotifier {
  Brightness _brightness = Brightness.light;

  Brightness get brightness => _brightness;

  void toggleTheme() {
    _brightness =
        _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    notifyListeners();
  }
}
