// ignore_for_file: prefer_const_constructors

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
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[30],
        accentColor: Colors.blue,
        cardColor: Colors.grey[10],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: buttonTheme(),
        pillButtonBarTheme: PillButtonBarThemeData(
          backgroundColor: Colors.transparent,
          selectedColor: ButtonState.all(Colors.blue),
          selectedTextStyle: TextStyle(color: Colors.white),
          unselectedColor: ButtonState.all(Colors.grey[50]),
          unselectedTextStyle: TextStyle(color: Colors.black),
        ),
        chipTheme: ChipThemeData(
          decoration: ButtonState.all(
            BoxDecoration(
              color: Colors.grey[40],
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
      home: const NavigationPage(),
      // routes: {
      //   '/': (context) => const NavigationPage(),
      //   '/dash': (context) => const Dash(),
      //   '/flash': (context) => const Flash(),
      //   '/product': (context) => const Products(),
      //   '/add_products': (context) => const AddProduct(),
      //   '/settings': (context) => const Settings(),
      //   '/edit_product': (context) => const EditProduct(),
      //   '/order_details': (context) => const OrderDetails(),
      // },
    );
  }
}

ButtonThemeData buttonTheme() {
  return ButtonThemeData(
    outlinedButtonStyle: ButtonStyle(
      shape: ButtonState.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      border: ButtonState.all(
        BorderSide(
          color: Colors.grey[100],
          width: 2,
        ),
      ),
    ),
    filledButtonStyle: ButtonStyle(
      padding: ButtonState.all<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      ),
      shape: ButtonState.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
