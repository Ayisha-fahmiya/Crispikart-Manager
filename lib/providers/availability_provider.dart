import 'package:flutter_riverpod/flutter_riverpod.dart';

final everyTime = StateProvider<bool>((ref) => false);
final breakfast = StateProvider<bool>((ref) => false);
final lunch = StateProvider<bool>((ref) => false);
final eveningTea = StateProvider<bool>((ref) => false);
final dinner = StateProvider<bool>((ref) => false);
