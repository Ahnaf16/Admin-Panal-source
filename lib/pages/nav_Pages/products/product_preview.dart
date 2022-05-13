import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';
import '../../../misc/export.dart';

class ProductPreview extends StatelessWidget {
  const ProductPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typetheme = FluentTheme.of(context).typography;
    return ScaffoldPage(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BaseBody(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------------------Product images
            Row(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: 'image$index',
                      child: Image.network(
                        //rendom image generator
                        'https://picsum.photos/200/300?random=${index + 1}',
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
              'Iphone 13 Pro Max',
              style: typetheme.title,
            ),
            DualText(
              typetheme1:
                  typetheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              typetheme2: typetheme.bodyLarge,
              text1: 'Product ID : ',
              text2: '38odzpssRIxEi8XRtxCXg',
            ),
            //------------------price
            DualText(
              typetheme1:
                  typetheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              typetheme2: typetheme.bodyLarge,
              text1: 'Price : \$ ',
              text2: NumberFormat().format(76000),
            ),
            //------------------Discount
            DualText(
              typetheme1:
                  typetheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              typetheme2: typetheme.bodyLarge,
              text1: 'Discount Price : \$ ',
              text2: NumberFormat().format(75000),
            ),
            //------------------brand
            DualText(
              typetheme1:
                  typetheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              typetheme2: typetheme.bodyLarge,
              text1: 'Brand : ',
              text2: 'Apple',
            ),
            //------------------category
            DualText(
              typetheme1:
                  typetheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              typetheme2: typetheme.bodyLarge,
              text1: 'Category : ',
              text2: 'Phone',
            ),
            //------------------description
            Text(
              'Description :',
              style: typetheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              r'''
Equipped with high-end specifications, iPhone 13 Pro Max is the newly launched
smartphone amongst iPhone 13 series that includes iPhone 13, iPhone 13 mini,
and iPhone 13 Pro. The mobile comes with 5G connectivity support and is 
available at a starting price of Rs 1,29,900 in Graphite, Gold, Silver,
Sierra Blue color variants.
''',
              style: typetheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
