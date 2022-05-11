// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gngm_web/Classes/body_base.dart';
import 'package:gngm_web/model/product_model.dart';

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

  late ScrollController scrollController;
  bool showScrollButton = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (scrollController.offset >= 1) {
            showScrollButton = true;
          } else {
            showScrollButton = false;
          }
        });
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text('Products'),
      ),
      content: Stack(
        children: [
          BaseBody(
            scrollController: scrollController,
            widthfactor: 1.3,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextBox(
                      padding: EdgeInsets.all(8),
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(FluentIcons.search),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[10],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey[100],
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[10],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey[100],
                          width: 1,
                        ),
                      ),
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
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              StaggeredGrid.count(
                crossAxisCount: 5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(
                  20,
                  (index) => ProductModel(
                    name: 'Product $index',
                    image: //random img genaretor
                        'https://picsum.photos/200/300?random=${index + 1}',
                    price: index * 10,
                  ).productWidget(context),
                ),
              )
            ],
          ),
          showScrollButton == true
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(FluentIcons.chevron_up),
                      style: ButtonStyle(
                        padding: ButtonState.all(EdgeInsets.all(15)),
                        shape: ButtonState.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        iconSize: ButtonState.all(25),
                        foregroundColor: ButtonState.all(Colors.white),
                        backgroundColor: ButtonState.all(Colors.blue),
                      ),
                      onPressed: () {
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
