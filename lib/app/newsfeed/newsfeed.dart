import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gngm_web/services/database.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/widget_export.dart';

class Newsfeed extends StatefulWidget {
  const Newsfeed({Key? key}) : super(key: key);

  @override
  State<Newsfeed> createState() => _NewsfeedState();
}

class _NewsfeedState extends State<Newsfeed> {
  final FlyoutController flyoutController = FlyoutController();

  final fireStorage = StorageProvider(storage: FirebaseStorage.instance);

  final pickImg = ImgSelector(imagePicker: ImagePicker());

  XFile selectedImg = XFile('');

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Newsfeed'),
        commandBar: Row(
          children: [
            //------------------publish button
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: FilledButton(
                child: const Text('Publish'),
                onPressed: () {
                  fireStorage.uploadSingelImage(
                    path: 'test',
                    fileName: Random(2).toString(),
                    img: selectedImg,
                  );
                  log(fireStorage.getProgres);
                },
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
                    onPressed: () async {
                      await pickImg
                          .getImg(
                            path: 'Path',
                            fileName: 'fileName',
                          )
                          .then(
                            (img) => setState(() {
                              selectedImg = img!;
                            }),
                          );
                    },
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
                  child: selectedImg.name == ''
                      ? Container(
                          color: Colors.grey[50],
                          width: 500,
                          height: 200,
                        )
                      : Image.network(
                          selectedImg.path,
                          width: 500,
                          height: 200,
                          fit: BoxFit.cover,
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
