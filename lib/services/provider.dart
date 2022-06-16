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

final obscureTextProvider = StateProvider<bool>((ref) {
  return true;
});

List<String> get catagoryListProvider {
  return [
    'Official Phone',
    'Unofficial Phone',
    'Used Phone',
    'Power Bank',
    'Wired Earphone',
    'Wireless Earphone',
    'Headphone',
    'Sound Box',
    'Smart Watch',
    'Analog Watch',
    'Addapter & Cable',
    'TV',
    'Others',
  ];
}
