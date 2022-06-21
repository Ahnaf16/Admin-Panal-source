import 'package:fluent_ui/fluent_ui.dart';

class DualText extends StatelessWidget {
  const DualText({
    Key? key,
    required this.text1,
    required this.text2,
    this.typetheme1,
    this.typetheme2,
  }) : super(key: key);

  final String text1;
  final String text2;
  final TextStyle? typetheme1;
  final TextStyle? typetheme2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text1,
          style: typetheme1,
        ),
        SelectableText(
          text2,
          style: typetheme2,
        ),
      ],
    );
  }
}
