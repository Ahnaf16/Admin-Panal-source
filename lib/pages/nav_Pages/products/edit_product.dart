//ignore_for_file: prefer_const_constructors

import 'package:fluent_ui/fluent_ui.dart';

class EditProduct extends StatelessWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        leading: IconButton(
          icon: Icon(FluentIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        title: PageHeader(
          title: Text('Edit Product'),
        ),
      ),
      content: ScaffoldPage(),
    );
  }
}
