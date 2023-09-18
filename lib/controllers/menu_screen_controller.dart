import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/models/food_menu_model.dart';

class MenuScreenController extends StateNotifier<List<FoodMenuItem>> {
  MenuScreenController() : super([]);
  addFoodItem(FoodMenuItem item) {
    state = [...state, item];
  }

  // List<FoodMenuItem> menuItems = [];
}

final menuItemsProvider =
    StateNotifierProvider<MenuScreenController, List<FoodMenuItem>>(
  (ref) => MenuScreenController(),
);
