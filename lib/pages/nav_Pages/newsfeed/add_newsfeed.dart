// ignore_for_file: prefer_const_constructors

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gngm_web/Classes/body_base.dart';

class AddNewsfeed extends StatelessWidget {
  const AddNewsfeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text('Add Newsfeed'),
      ),
      content: BaseBody(
        widthfactor: 1.3,
        children: [],
      ),
    );
  }
}
