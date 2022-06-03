import 'package:firebase_core/firebase_core.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gngm_web/firebase_options.dart';
import 'app/nav_pane.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panal',
      themeMode: ThemeMode.light,
      theme: Themes.light,
      builder: EasyLoading.init(),
      home: const NavigationPage(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 15.0
    ..userInteractions = true
    ..dismissOnTap = false
    ..maskColor = Colors.blue.withOpacity(0.5);
}

class Themes {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[170],
    accentColor: Colors.blue,
    cardColor: Colors.grey[150],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonTheme: ButtonThemeData(
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
          const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        ),
        shape: ButtonState.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
    pillButtonBarTheme: PillButtonBarThemeData(
      backgroundColor: Colors.transparent,
      selectedColor: ButtonState.resolveWith(
        (states) => states.isHovering ? Colors.blue : Colors.red,
      ),
      selectedTextStyle: const TextStyle(color: Colors.white),
      unselectedColor: ButtonState.all(Colors.grey[50]),
      unselectedTextStyle: const TextStyle(color: Colors.black),
    ),
    chipTheme: ChipThemeData(
      decoration: ButtonState.all(
        BoxDecoration(
          color: Colors.grey[40],
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );

  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.grey[30],
    accentColor: Colors.blue,
    cardColor: Colors.grey[10],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    focusTheme: FocusThemeData(
      borderRadius: BorderRadius.circular(10),
      primaryBorder: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1,
      ),
    ),
    buttonTheme: ButtonThemeData(
      outlinedButtonStyle: ButtonStyle(
        shape: ButtonState.all(
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
          const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        ),
        shape: ButtonState.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
    pillButtonBarTheme: PillButtonBarThemeData(
      backgroundColor: Colors.transparent,
      selectedColor: ButtonState.resolveWith(
        (states) => states.isHovering ? Colors.blue.light : Colors.blue,
      ),
      selectedTextStyle: const TextStyle(color: Colors.white),
      unselectedColor: ButtonState.resolveWith(
        (states) => states.isHovering ? Colors.grey[40] : Colors.grey[50],
      ),
      unselectedTextStyle: const TextStyle(color: Colors.black),
    ),
    chipTheme: ChipThemeData(
      decoration: ButtonState.all(
        BoxDecoration(
          color: Colors.grey[40],
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );
}
