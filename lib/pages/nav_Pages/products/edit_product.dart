// ignore_for_file: prefer_const_constructors

import 'package:fluent_ui/fluent_ui.dart';

class EditProduct extends StatelessWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Text('Edit Product'),
    );
  }
}
