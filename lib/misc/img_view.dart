import 'package:fluent_ui/fluent_ui.dart';

class ImgView extends StatelessWidget {
  const ImgView({
    Key? key,
    required this.tag,
    required this.url,
  }) : super(key: key);
  final String tag;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Hero(
        tag: tag,
        child: Image.network(url),
      ),
    );
  }
}
