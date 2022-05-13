import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CachedNetImg extends StatelessWidget {
  const CachedNetImg({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: url,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Container(
          color: Colors.grey[30],
          height: height,
          width: width,
          child: const Center(
            child: ProgressRing(),
          ),
        );
      },
      // placeholder: (context, url) => const SizedBox(
      //   height: 200,
      //   width: 500,
      //   child: Center(
      //     child: ProgressBar(
      //       value: 2,
      //     ),
      //   ),
      // ),
    );
  }
}
