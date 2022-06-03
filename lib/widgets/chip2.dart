import 'package:fluent_ui/fluent_ui.dart';

class Chip2 extends StatelessWidget {
  const Chip2({
    Key? key,
    required this.text,
    required this.textcolor,
    required this.backgroundColor,
  }) : super(key: key);

  final String text;
  final Color textcolor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textcolor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
