import 'dart:io';

class FoodMenuItem {
  final File? imageUrl;
  final String name;
  final String description;
  final String price;
  final bool availableAllTime;
  final bool availableForBreakfast;
  final bool availableForLunch;
  final bool availableForEveningTea;
  final bool availableForDinner;
  final List categories;
  final bool pickupOption;
  final bool deliveryOption;
  final String quantityAvailable;

  bool isDetailsVisible = false;

  FoodMenuItem({
    this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.availableAllTime,
    required this.availableForBreakfast,
    required this.availableForLunch,
    required this.availableForEveningTea,
    required this.availableForDinner,
    required this.categories,
    required this.pickupOption,
    required this.deliveryOption,
    required this.quantityAvailable,
  });
}
