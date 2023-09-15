import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/providers/category_provider.dart';
import 'package:restaurant_app/providers/form_field_controller_provider.dart';
import 'package:restaurant_app/utilities/menu_screen_open_add_dialog.dart';

void clearFormFields(BuildContext context, WidgetRef ref) {
  ref.watch(nameControllerProvider).clear();
  ref.watch(descriptionControllerProvider).clear();
  ref.watch(priceControllerProvider).clear();
  ref.watch(quantityControllerProvider).clear();
  ref.read(categoriesProvider.notifier).state = [];
  // selectedImage = null;
  availablAllTime = false;
  breakfst = false;
  lnch = false;
  evngT = false;
  dnnr = false;
  pickUp = false;
  homeDelivery = false;
  categoryController!.clear();
}
