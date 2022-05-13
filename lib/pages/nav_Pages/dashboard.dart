import 'package:fluent_ui/fluent_ui.dart';

import '../../misc/export.dart';

class Dash extends StatelessWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(
        title: Text('DASHBOARD'),
      ),
      content: BaseBody(
        widthfactor: 1.4,
        children: [
          Center(
            child: FlutterLogo(
              style: FlutterLogoStyle.horizontal,
              size: 200,
            ),
          ),
        ],
      ),
    );
  }
}
