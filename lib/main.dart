import 'package:fluent_ui/fluent_ui.dart';

import 'misc/export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: const NavigationPage(),
      routes: {
        '/': (context) => const NavigationPage(),
        '/dash': (context) => const Dash(),
        '/flash': (context) => const Flash(),
        '/product': (context) => const Products(),
        '/add_products': (context) => const AddProduct(),
        '/settings': (context) => const Settings(),
        '/edit_product': (context) => const EditProduct(),
      },
    );
  }
}
