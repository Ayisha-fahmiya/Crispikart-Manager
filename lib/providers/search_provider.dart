import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

class SearchNotifier extends StateNotifier<List<String>> {
  SearchNotifier() : super([]);

  addCategory(String item) {
    return state = [...state, item];
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, List<String>>(
  (ref) => SearchNotifier(),
);
