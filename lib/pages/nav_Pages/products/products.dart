// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gngm_web/model/product_model.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../../../misc/export.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List categorys = [
    'phone',
    'laptop',
    'camera',
    'headphone',
    'speaker',
    'watch',
    'charger',
  ];
  String? category;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text('Products'),
      ),
      content: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            height: MediaQuery.of(context).size.height / 1.3,
            child: Card(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextBox(
                          padding: EdgeInsets.all(8),
                          prefix: Icon(FluentIcons.search),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Combobox<String>(
                          placeholder: const Text('Catagory'),
                          isExpanded: true,
                          items: categorys
                              .map((e) => ComboboxItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          value: category,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => category = value);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                  ResponsiveGridListBuilder(
                      minItemWidth: 100,
                      minItemsPerRow: 2,
                      maxItemsPerRow: 5,
                      gridItems: [
                        for (var i = 1; i < 11; i++)
                          ProductModel(
                            name: 'Product $i',
                            image: 'img/lp.png',
                            price: i * 100,
                          ).productWidget(context),
                      ],
                      builder: (context, item) => ListView(
                            shrinkWrap: true,
                            children: item,
                          )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
