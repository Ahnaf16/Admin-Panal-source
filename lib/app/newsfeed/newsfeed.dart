import 'package:fluent_ui/fluent_ui.dart';
import '../../widgets/widget_export.dart';

class Newsfeed extends StatelessWidget {
  Newsfeed({Key? key}) : super(key: key);

  final FlyoutController flyoutController = FlyoutController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Newsfeed'),
        commandBar: Row(
          children: [
            //------------------add button
            // OutlinedButton(
            //   child: Row(
            //     children: const [
            //       Icon(FluentIcons.add),
            //       SizedBox(width: 10),
            //       Text('Add Newsfeed'),
            //     ],
            //   ),
            //   onPressed: () {},
            // ),
            // const SizedBox(width: 10),
            //------------------publish button
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: FilledButton(
                child: const Text('Publish'),
                onPressed: () {},
                style: FluentTheme.of(context).buttonTheme.filledButtonStyle,
              ),
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
                    icon: const Icon(FluentIcons.file_image),
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: ButtonState.all<EdgeInsets>(
                        const EdgeInsets.all(20),
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
                          text: const Text('View'),
                          onPressed: () {},
                        ),
                        MenuFlyoutItem(
                          text: const Text('Remove'),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                  child: const CachedNetImg(
                    url: 'https://picsum.photos/id/112/500/200',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
