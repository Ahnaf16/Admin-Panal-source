import 'package:fluent_ui/fluent_ui.dart';

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
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                image,
                width: 100,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Text(
              '\$$price',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(FluentIcons.edit_solid12),
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: ButtonState.all(Colors.grey[140]),
                    border:
                        ButtonState.all(BorderSide(color: Colors.grey[140])),
                  ),
                ),
                IconButton(
                  style: ButtonStyle(
                    foregroundColor:
                        ButtonState.all(Colors.warningPrimaryColor),
                    border: ButtonState.all(
                        BorderSide(color: Colors.warningPrimaryColor)),
                  ),
                  icon: const Icon(FluentIcons.delete),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
