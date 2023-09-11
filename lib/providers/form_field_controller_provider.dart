import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

final descriptionControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final priceControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final quantityControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
