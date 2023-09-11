import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryTextEditingController =
    Provider((ref) => TextEditingController());
final categoryProvider = Provider((ref) => null);

class CategoriesNotifier extends StateNotifier<List<String>> {
  CategoriesNotifier() : super([]); // Initialize with an empty list

  // Add a category to the list
  addCategory(String category) {
    state = [...state, category];
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<String>>(
  (ref) => CategoriesNotifier(),
);
