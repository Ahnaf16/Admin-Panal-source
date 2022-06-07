import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../widgets/widget_export.dart';
import 'edit_product.dart';

class ProductModel {
  final String name;
  final String image;
  final double price;

  ProductModel({
    required this.name,
    required this.image,
    required this.price,
  });

  productWidget(BuildContext context) {
    return Card(
      // backgroundColor: Colors.grey[30],
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              //-------------------image
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetImg(
                  url: image,
                  // width: 100,
                ),
              ),
            ),
            const SizedBox(height: 10),
            //-------------------name
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            //-------------------price
            Text(
              '\$$price',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            //-------------------actions
            Align(
              alignment: Alignment.bottomRight,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Flyout(
                  openMode: FlyoutOpenMode.press,
                  content: (context) => MenuFlyout(
                    items: [
                      //-------------------Edit
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
                      //-------------------delete
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
                          showDialog(
                            context: context,
                            builder: (_) => ContentDialog(
                              title: const Text('Delete Product'),
                              content: const Text(
                                  'Are you sure you want to delete this product?'),
                              actions: [
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: ButtonState.resolveWith(
                                        (states) => states.isHovering
                                            ? Colors.warningPrimaryColor
                                            : Colors.transparent,
                                      ),
                                      foregroundColor: ButtonState.resolveWith(
                                        (states) => states.isHovering
                                            ? Colors.white
                                            : Colors.warningPrimaryColor,
                                      ),
                                    ),
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      EasyLoading.showToast(
                                        'Product Deleted',
                                        toastPosition:
                                            EasyLoadingToastPosition.bottom,
                                      );

                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
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
                        // vertical: 3,
                      ),
                      child: Icon(FluentIcons.more),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
