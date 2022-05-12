// ignore_for_file: prefer_const_constructors

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gngm_web/Classes/body_base.dart';

class Newsfeed extends StatelessWidget {
  Newsfeed({Key? key}) : super(key: key);

  final FlyoutController flyoutController = FlyoutController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text('Newsfeed'),
        commandBar: Row(
          children: [
            //------------------add button
            OutlinedButton(
              child: Row(
                children: const [
                  Icon(FluentIcons.add),
                  SizedBox(width: 10),
                  Text('Add Newsfeed'),
                ],
              ),
              onPressed: () {},
            ),
            SizedBox(width: 10),
            //------------------publish button
            FilledButton(
              child: Text('Publish'),
              onPressed: () {},
              style: FluentTheme.of(context).buttonTheme.filledButtonStyle,
            ),
          ],
        ),
      ),
      content: BaseBody(
        widthfactor: 1.3,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //------------------add image button
              InfoLabel(
                label: 'Add Image',
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: IconButton(
                    icon: Icon(FluentIcons.file_image),
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: ButtonState.all<EdgeInsets>(
                        EdgeInsets.all(20),
                      ),
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
                      iconSize: ButtonState.all(30),
                    ),
                  ),
                ),
              ),
              //------------------img preview
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Flyout(
                  position: FlyoutPosition.below,
                  placement: FlyoutPlacement.end,
                  controller: flyoutController,
                  openMode: FlyoutOpenMode.press,
                  content: (context) {
                    return MenuFlyout(
                      items: [
                        MenuFlyoutItem(
                          text: Text('View'),
                          onPressed: () {},
                        ),
                        MenuFlyoutItem(
                          text: Text('Remove'),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                  child: Image.network(
                    'https://picsum.photos/250?image=9',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          //------------------newsfeed
          TextBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            header: 'Newsfeed',
            maxLines: null,
            minHeight: 150,
            expands: true,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
