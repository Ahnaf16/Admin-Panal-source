// ignore_for_file: prefer_const_constructors

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gngm_web/Classes/body_base.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text('Settings'),
      ),
      content: BaseBody(
        widthfactor: 1.3,
        children: [],
      ),
    );
  }
}
