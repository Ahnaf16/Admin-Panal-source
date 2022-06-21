import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:gngm_web/app/products/prodact_tile.dart';
import 'package:gngm_web/app/products/upload_model.dart';
import 'package:gngm_web/services/provider.dart';

import '../../services/database.dart';
import '../../theme.dart';
import '../../widgets/widget_export.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final categorys = catagoryListProvider;
  String? category;
  ScrollController scrollController = ScrollController();
  bool showScrollButton = false;
  final fireProvider = FirestoreProvider(firestore: FirebaseFirestore.instance);

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Products'),
      ),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Row(
                  children: [
                    searchBox(),
                    const SizedBox(width: 20),
                    categotyBox(),
                    if (category != null)
                      IconButton(
                        icon: const Icon(FluentIcons.reset),
                        onPressed: () {
                          setState(() {
                            category = null;
                          });
                        },
                      ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: BaseBody(
              scrollController: scrollController,
              widthfactor: 1.3,
              children: [
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                //------------------------------------all products

                FirestoreQueryBuilder<ProductModel>(
                  query: category == null
                      ? fireProvider.getAppProducts()
                      : fireProvider.filteSingelProdut(
                          filterWith: category!,
                          matchingField: Fields.category,
                        ),
                  builder: (context, snapshot, _) {
                    if (snapshot.isFetching) {
                      return const ProgressRing();
                    }

                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    }

                    return StaggeredGrid.count(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(
                        snapshot.docs.length,
                        (index) {
                          final data = snapshot.docs[index].data();
                          return ProductTiles(data: data);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          //---------------------------- scrool to top

          // if (showScrollButton == true) goToTop(),
        ],
      ),
    );
  }

  Padding goToTop() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: IconButton(
            icon: const Icon(FluentIcons.chevron_up),
            style: ButtonStyle(
              padding: ButtonState.all(const EdgeInsets.all(15)),
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
      ),
    );
  }

  Expanded categotyBox() {
    return Expanded(
      //---------------------category box
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[10],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey[100],
            width: 1,
          ),
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
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
    );
  }

  Expanded searchBox() {
    return Expanded(
      flex: 2,
      //---------------------search box
      child: TextBox(
        padding: const EdgeInsets.all(8),
        prefix: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(FluentIcons.search),
        ),
        decoration: boxDecoration,
      ),
    );
  }
}
