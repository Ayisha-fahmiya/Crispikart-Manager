import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/providers/app_theme_provider.dart';
import 'package:restaurant_app/utilities/app_theme.dart';

class SearchInput extends ConsumerStatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<SearchInput> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return TextField(
      cursorColor: themeMode == ThemeMode.dark ? Colors.white : Colors.black,
      onChanged: (value) {},
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: themeMode == ThemeMode.dark ? Colors.white : Colors.black,
        ),
        filled: true,
        fillColor: Colors.transparent,
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.all(20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: appTheme.colorScheme.primary, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
