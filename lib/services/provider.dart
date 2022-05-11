import 'package:flutter_riverpod/flutter_riverpod.dart';

final enableEditProvider = StateProvider<bool>((ref) {
  return false;
});

final allStatusProvider = StateProvider<List>((ref) {
  return [
    'Pending',
    'Prossecing',
    'Picked',
    'Shiped',
    'Delivered',
    'Cancelled',
  ];
});

final orderStstusChangeerProvider = StateProvider<String?>((ref) {
  return null;
});

final categoryListProvider = StateProvider<List>((ref) {
  return [
    'Phone',
    'Wired Earphone',
    'Wireless Earphone',
    'Addapter',
    'Others',
  ];
});

final obscureTextProvider = StateProvider<bool>((ref) {
  return true;
});
