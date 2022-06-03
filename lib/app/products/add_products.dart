import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gngm_web/app/products/product_preview.dart';
import 'package:nanoid/nanoid.dart';
import '../../widgets/widget_export.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool discountSwitch = false;
  int cIndex = -1;
  final List<String> categorys = [
    'Phone',
    'Wired Earphone',
    'Wireless Earphone',
    'Addapter',
    'Others',
  ];
  FlyoutController flyoutController = FlyoutController();

  final TextEditingController pIDController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pIDController.text = nanoid();
  }

  @override
  void dispose() {
    flyoutController.dispose();
    pIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Add Product'),
        commandBar: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: FilledButton(
            child: const Text('Publish Product'),
            onPressed: () {
              //-------------------------------publish dialog button
              showDialog(
                context: context,
                builder: (_) => ContentDialog(
                  title: PageHeader(
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        icon: const Icon(FluentIcons.back, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    title: const Text('Preview'),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 1.3,
                  ),
                  content: const ProductPreview(),
                  actions: [
                    FilledButton(
                      child: const Text('Confirm Update'),
                      onPressed: () {
                        EasyLoading.showToast(
                          'Product Updated',
                          toastPosition: EasyLoadingToastPosition.bottom,
                        );
                        Navigator.pop(context);
                      },
                      style:
                          FluentTheme.of(context).buttonTheme.filledButtonStyle,
                    ),
                  ],
                ),
              );
            },
            style: FluentTheme.of(context).buttonTheme.filledButtonStyle,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            //---main row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  //-------------left side
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Card(
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          //------------- name and brand
                          child: Column(
                            children: [
                              TextBox(
                                header: 'Name',
                                decoration: BoxDecoration(
                                  color: Colors.grey[10],
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey[100],
                                    width: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextBox(
                                header: 'Brand',
                                decoration: BoxDecoration(
                                  color: Colors.grey[10],
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey[100],
                                    width: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //-------------Description
                      const SizedBox(height: 20),
                      MouseRegion(
                        cursor: SystemMouseCursors.text,
                        child: Card(
                          borderRadius: BorderRadius.circular(10),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: 200,
                            ),
                            child: TextBox(
                              maxLines: null,
                              minHeight: 150,
                              expands: true,
                              header: 'Description',
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
                        ),
                      ),
                      const SizedBox(height: 20),
                      //-------------img selection
                      Card(
                        borderRadius: BorderRadius.circular(10),
                        child: InfoLabel(
                          label: 'Add Image',
                          child: Row(
                            children: [
                              //-------------add img button
                              IconButton(
                                icon: const Icon(FluentIcons.file_image),
                                onPressed: () {},
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
                              const SizedBox(width: 20),
                              //-------------img preview
                              Row(
                                children: List.generate(
                                  3,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Flyout(
                                        openMode: FlyoutOpenMode.press,
                                        content: (context) {
                                          return MenuFlyout(
                                            items: [
                                              MenuFlyoutItem(
                                                leading: const Icon(
                                                    FluentIcons.view),
                                                text: const Text('View'),
                                                onPressed: () {
                                                  flyoutController.close();
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        //-------------------------------img view dialog
                                                        ContentDialog(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                      ),
                                                      content: ImgView(
                                                        tag: index.toString(),
                                                        url:
                                                            'https://picsum.photos/id/${index + 2 * 11}/600/300',
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              MenuFlyoutItem(
                                                leading: const Icon(
                                                    FluentIcons.remove),
                                                text: const Text('Remove'),
                                                onPressed: () {
                                                  flyoutController.close();
                                                },
                                              )
                                            ],
                                          );
                                        },
                                        child: Hero(
                                          tag: 'image$index',
                                          child: CachedNetImg(
                                            url:
                                                'https://picsum.photos/id/${index + 2 * 11}/600/300',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //--------------------------right side
                const SizedBox(width: 20),
                Expanded(
                  child: Card(
                    borderRadius: BorderRadius.circular(10),
                    child: sidePanal(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column sidePanal(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //-------------price
        TextBox(
          header: 'Price',
          inputFormatters: [
            FilteringTextInputFormatter(
              RegExp(r'[0-9]'),
              allow: true,
            )
          ],
          decoration: BoxDecoration(
            color: Colors.grey[10],
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey[100],
              width: 1,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Default Discount'),
            //----------------------discount switch
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ToggleSwitch(
                checked: discountSwitch,
                onChanged: (value) {
                  setState(() {
                    discountSwitch = !discountSwitch;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        //-----------------duscount box
        discountSwitch
            ? TextBox(
                inputFormatters: [
                  FilteringTextInputFormatter(
                    RegExp(r'[0-9]'),
                    allow: true,
                  )
                ],
                enabled: discountSwitch,
                header: 'Discount Price',
                decoration: BoxDecoration(
                  color: Colors.grey[10],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey[100],
                    width: 1,
                  ),
                ),
              )
            : const SizedBox(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Divider(),
        ),
        //----------------categorys
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category',
              style: FluentTheme.of(context).typography.bodyLarge,
            ),
            //-----------------clear categorys button
            cIndex == -1
                ? const Text('')
                : MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: IconButton(
                      icon: const Icon(FluentIcons.cancel),
                      onPressed: () {
                        cIndex == -1
                            ? null
                            : setState(() {
                                cIndex = -1;
                              });
                      },
                    ),
                  )
          ],
        ),
        //-------------------categorys radio button
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categorys.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: RadioButton(
                    checked: cIndex == index,
                    onChanged: (value) => setState(() => cIndex = index),
                    content: Text(categorys[index]),
                  ),
                ),
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Divider(),
        ),
        //-----------------product id
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: TextBox(
                controller: pIDController,
                readOnly: true,
                focusNode: FocusNode(
                  canRequestFocus: false,
                ),
                header: 'Product ID',
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
            //-----------------generate id button
            const SizedBox(width: 10),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: OutlinedButton(
                child: const Text('Generate ID'),
                onPressed: () {
                  pIDController.text = nanoid();
                },
              ),
            )
          ],
        ),
        // Text(cIndex == -1 ? '' : categorys[cIndex]),
      ],
    );
  }
}
