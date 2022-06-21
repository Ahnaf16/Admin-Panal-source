import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gngm_web/app/products/product_preview.dart';
import 'package:gngm_web/app/products/upload_model.dart';
import 'package:intl/intl.dart';
import '../../widgets/cached_net_img.dart';
import 'edit_product.dart';

class ProductTiles extends StatelessWidget {
  const ProductTiles({Key? key, required this.data}) : super(key: key);
  final ProductModel data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetImg(
                url: data.imgUrls![0],
                width: 100,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            data.name,
          ),
          const SizedBox(
            height: 10,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: TextButton(
              style: ButtonStyle(
                padding: ButtonState.all(EdgeInsets.zero),
                foregroundColor: ButtonState.all(Colors.blue),
                textStyle: ButtonState.all(
                  const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              child: const Text(
                'Copy PID',
                textAlign: TextAlign.left,
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: data.pID));
                EasyLoading.showToast(
                  'PID copied to clipboard\n\n${data.pID}',
                  toastPosition: EasyLoadingToastPosition.bottom,
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                '\$${NumberFormat('##,##,###').format(data.price)}',
                style: TextStyle(
                  decoration: data.haveDiscount
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              if (data.haveDiscount)
                Text(
                  '  \$${NumberFormat('##,##,###').format(data.discountPrice)}',
                ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Flyout(
              openMode: FlyoutOpenMode.press,
              content: (context) => MenuFlyout(
                items: [
                  MenuFlyoutItem(
                    leading: const Icon(FluentIcons.view),
                    text: const Text('View'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        FluentPageRoute(
                          builder: (_) => ProductPreview(
                            model: data,
                            showPublishButton: false,
                          ),
                        ),
                      );
                    },
                  ),
                  MenuFlyoutItem(
                    leading: const Icon(FluentIcons.edit),
                    text: const Text('Edit'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        FluentPageRoute(
                          builder: (_) => const EditProduct(),
                        ),
                      );
                    },
                  ),
                  MenuFlyoutItem(
                    leading: const Icon(
                      FluentIcons.delete,
                      color: Colors.warningPrimaryColor,
                    ),
                    text: const Text(
                      'Remove',
                      style: TextStyle(
                        color: Colors.warningPrimaryColor,
                      ),
                    ),
                    onPressed: () {
                      deleteButtonDialog(context);
                    },
                  ),
                ],
              ),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Icon(FluentIcons.more),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Object?> deleteButtonDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            style: deleteButtonStyle(),
            child: const Text('Delete'),
            onPressed: () {
              EasyLoading.showToast(
                'Product Deleted',
                toastPosition: EasyLoadingToastPosition.bottom,
              );

              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  ButtonStyle deleteButtonStyle() {
    return ButtonStyle(
      backgroundColor: ButtonState.resolveWith(
        (states) =>
            states.isHovering ? Colors.warningPrimaryColor : Colors.transparent,
      ),
      foregroundColor: ButtonState.resolveWith(
        (states) =>
            states.isHovering ? Colors.white : Colors.warningPrimaryColor,
      ),
    );
  }
}
