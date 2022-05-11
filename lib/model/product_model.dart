import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gngm_web/pages/nav_Pages/products/edit_product.dart';

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
      backgroundColor: Colors.grey[30],
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  // width: 100,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$$price',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(FluentIcons.edit_solid12),
                  onPressed: () {
                    Navigator.push(
                      context,
                      FluentPageRoute(
                        builder: (_) => const EditProduct(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    iconSize: ButtonState.all(20),
                    shape: ButtonState.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    foregroundColor: ButtonState.all(Colors.grey[140]),
                    border:
                        ButtonState.all(BorderSide(color: Colors.grey[140])),
                  ),
                ),
                IconButton(
                  style: ButtonStyle(
                    iconSize: ButtonState.all(20),
                    shape: ButtonState.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    foregroundColor:
                        ButtonState.all(Colors.warningPrimaryColor),
                    border: ButtonState.all(
                        const BorderSide(color: Colors.warningPrimaryColor)),
                  ),
                  icon: const Icon(FluentIcons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => ContentDialog(
                        title: const Text('Delete Product'),
                        content: const Text(
                            'Are you sure you want to delete this product?'),
                        actions: [
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  ButtonState.all(Colors.warningPrimaryColor),
                            ),
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
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
