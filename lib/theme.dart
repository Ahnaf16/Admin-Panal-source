import 'package:fluent_ui/fluent_ui.dart';

Color boxColor = Colors.grey[10];
Color boxColorDark = Colors.grey[10];

BoxDecoration boxDecoration = BoxDecoration(
  color: boxColorDark,
  borderRadius: BorderRadius.circular(5),
  border: Border.all(
    color: Colors.grey[100],
    width: 1,
  ),
);

class Themes {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
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

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[190],
    accentColor: Colors.blue,
    cardColor: Colors.grey[160],
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
}
