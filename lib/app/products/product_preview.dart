import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gngm_web/app/products/upload_model.dart';
import 'package:intl/intl.dart';
import '../../services/database.dart';
import '../../widgets/widget_export.dart';

class ProductPreview extends StatelessWidget {
  ProductPreview({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ProductUploadModel model;

  final List<String> imgUrls = [];

  final fireProvider = FirestoreProvider(firestore: FirebaseFirestore.instance);
  final fireStorage = StorageProvider(storage: FirebaseStorage.instance);

  @override
  Widget build(BuildContext context) {
    final typetheme = FluentTheme.of(context).typography;
    return ScaffoldPage(
      header: PageHeader(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(
            icon: const Icon(FluentIcons.back, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        commandBar: Expanded(
          child: CommandBarCard(
            child: CommandBar(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              primaryItems: [
                CommandBarButton(
                  onPressed: () async {
                    await fireStorage
                        .uploadImage(
                          path: 'itemList',
                          fileName: model.name,
                          imgs: model.images,
                        )
                        .then((urls) => imgUrls.addAll(urls));

                    await fireProvider.addData(
                      path: 'itemsList',
                      fromModel: model,
                      imgUrls: imgUrls,
                    );
                  },
                  icon: const Icon(FluentIcons.upload),
                  label: const Text('Publish'),
                ),
              ],
            ),
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BaseBody(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------------------Product images
            Wrap(
              children: List.generate(
                model.images.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: '$index',
                      child: model.images.isEmpty
                          ? Container(
                              height: 200,
                              width: 200,
                              color: Colors.grey,
                            )
                          : Image.network(
                              model.images[index].path,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(),
            ),
            //------------------name
            Text(
              model.name,
              style: typetheme.display,
            ),
            DualText(
              typetheme1: typetheme.title,
              typetheme2:
                  typetheme.title!.copyWith(fontWeight: FontWeight.normal),
              text1: 'Product ID : ',
              text2: model.pID,
            ),
            //------------------price
            DualText(
              typetheme1: typetheme.title,
              typetheme2:
                  typetheme.title!.copyWith(fontWeight: FontWeight.normal),
              text1: 'Price : \$ ',
              text2: NumberFormat().format(model.price),
            ),
            //------------------Discount
            DualText(
              typetheme1: typetheme.title,
              typetheme2:
                  typetheme.title!.copyWith(fontWeight: FontWeight.normal),
              text1: 'Discount Price : \$ ',
              text2: NumberFormat().format(model.discountPrice),
            ),
            //------------------brand
            DualText(
              typetheme1: typetheme.title,
              typetheme2:
                  typetheme.title!.copyWith(fontWeight: FontWeight.normal),
              text1: 'Brand : ',
              text2: model.brand,
            ),
            //------------------category
            DualText(
              typetheme1: typetheme.title,
              typetheme2:
                  typetheme.title!.copyWith(fontWeight: FontWeight.normal),
              text1: 'Category : ',
              text2: model.category,
            ),
            //------------------description
            Text(
              'Description :',
              style: typetheme.title,
            ),
            Text(
              '''
${model.description}
              
''',
              style: typetheme.title!.copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
