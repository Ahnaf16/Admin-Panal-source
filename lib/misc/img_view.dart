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
      header: PageHeader(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
            icon: const Icon(
              FluentIcons.back_to_window,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('Image Preview'),
      ),
      content: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Hero(
              tag: tag,
              child: Image.network(
                url,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
