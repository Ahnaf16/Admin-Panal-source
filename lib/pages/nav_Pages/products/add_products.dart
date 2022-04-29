// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fluent_ui/fluent_ui.dart';

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

  @override
  void dispose() {
    flyoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Add Product'),
        commandBar: FilledButton(
          child: const Text('Publish Product'),
          onPressed: () {},
          style: FluentTheme.of(context).buttonTheme.filledButtonStyle,
        ),
      ),
      content: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Card(
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
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
                              SizedBox(height: 20),
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
                      SizedBox(height: 20),
                      Card(
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
                      SizedBox(height: 20),
                      Card(
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          children: [
                            IconButton(
                                icon: Icon(FluentIcons.file_image),
                                onPressed: () {},
                                style: ButtonStyle(
                                  padding: ButtonState.all<EdgeInsets>(
                                    EdgeInsets.all(20),
                                  ),
                                  iconSize: ButtonState.all(30),
                                )),
                            SizedBox(width: 20),
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
                                              leading: Icon(FluentIcons.view),
                                              text: Text('View'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            MenuFlyoutItem(
                                              leading: Icon(FluentIcons.remove),
                                              text: Text('Remove'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      },
                                      child: Image.network(
                                        //rendom image generator
                                        'https://picsum.photos/200/300?random=${index + 1}',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
        TextBox(
          header: 'Price',
          decoration: BoxDecoration(
            color: Colors.grey[10],
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey[100],
              width: 1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Default Discount'),
            ToggleSwitch(
              checked: discountSwitch,
              onChanged: (value) {
                setState(() {
                  discountSwitch = !discountSwitch;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 10),
        discountSwitch
            ? TextBox(
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
            : SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category',
              style: FluentTheme.of(context).typography.bodyLarge,
            ),
            cIndex == -1
                ? Text('')
                : IconButton(
                    icon: Icon(FluentIcons.cancel),
                    onPressed: () {
                      cIndex == -1
                          ? null
                          : setState(() {
                              cIndex = -1;
                            });
                    },
                  )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categorys.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RadioButton(
                  checked: cIndex == index,
                  onChanged: (value) => setState(() => cIndex = index),
                  content: Text(categorys[index]),
                ),
              );
            },
          ),
        ),
        // Text(cIndex == -1 ? '' : categorys[cIndex]),
      ],
    );
  }
}
