import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryTextEditingController =
    StateProvider((ref) => TextEditingController());

class CategoriesNotifier extends StateNotifier<List<String>> {
  CategoriesNotifier() : super([]);

  addCategory(String category) {
    return state = [...state, category];
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<String>>(
  (ref) => CategoriesNotifier(),
);

final editCategoryController = StateProvider((ref) => TextEditingController());
