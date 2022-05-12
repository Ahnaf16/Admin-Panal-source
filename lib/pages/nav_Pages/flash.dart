// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:gngm_web/Classes/body_base.dart';

class Flash extends StatefulWidget {
  const Flash({Key? key}) : super(key: key);

  @override
  State<Flash> createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  List<Map> selectedNames = [];

  final searchcontroller = TextEditingController();
  final flashcontroller = TextEditingController();

  @override
  void dispose() {
    searchcontroller.dispose();
    flashcontroller.dispose();
    super.dispose();
  }

  Map tt = {};

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        commandBar: FilledButton(
          child: Text('Submit'),
          onPressed: () {},
          style: FluentTheme.of(context).buttonTheme.filledButtonStyle,
        ),
        title: Text('Flash'),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseBody(
              crossAxisAlignment: CrossAxisAlignment.start,
              widthfactor: 1.9,
              children: [
                TextBox(
                  controller: searchcontroller,
                  onChanged: (value) => setState(() {}),
                  header: 'Search',
                  prefix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(FluentIcons.search),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView(
                  shrinkWrap: true,
                  children:
                      // searchcontroller.text.isEmpty
                      //     ? [
                      //         Text('No results found'),
                      //       ]
                      //     :
                      damiItems
                          .where(
                            (element) => element['name'].toLowerCase().contains(
                                  searchcontroller.text.toLowerCase(),
                                ),
                          )
                          .map(
                            (element) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Card(
                                elevation: 2,
                                child: Checkbox(
                                  checked: selectedNames.contains(element),
                                  onChanged: (value) {
                                    log(element['name'], name: 'element');
                                    if (value == true) {
                                      selectedNames.add(element);
                                      showDialog(
                                        context: context,
                                        builder: (_) => ContentDialog(
                                          constraints: BoxConstraints(
                                            maxWidth: 300,
                                          ),
                                          title: Text('Flash Price'),
                                          actions: [
                                            OutlinedButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                          content: SizedBox(
                                            width: 250,
                                            child: TextBox(
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              autofocus: true,
                                              controller: flashcontroller,
                                              enabled: selectedNames
                                                  .contains(element),
                                              outsideSuffix: MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: IconButton(
                                                  icon: Icon(
                                                    FluentIcons.accept,
                                                    size: 18,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      element['flashPrice'] =
                                                          flashcontroller.text;
                                                      flashcontroller.clear();
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: selectedNames
                                                        .contains(element)
                                                    ? Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      )
                                                    : Border.all(
                                                        color: Colors.grey[50],
                                                        width: 1,
                                                      ),
                                              ),
                                              header: 'Flesh Price',
                                            ),
                                          ),
                                        ),
                                      );

                                      setState(() {});
                                    } else {
                                      selectedNames.remove(element);
                                      setState(() {});
                                    }
                                  },
                                  content: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          element['image'],
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            element['name'].length > 20
                                                ? element['name']
                                                        .substring(0, 20) +
                                                    '...'
                                                : element['name'],
                                            style: FluentTheme.of(context)
                                                .typography
                                                .bodyLarge,
                                          ),
                                          Text(
                                            element['price'],
                                            style: FluentTheme.of(context)
                                                .typography
                                                .bodyLarge,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                )
              ],
            ),
            SizedBox(width: 10),
            Expanded(
              child: BaseBody(
                mainAxisAlignment: MainAxisAlignment.start,
                // height: 400,
                scrollController: ScrollController(),
                children: [
                  Text(
                    'Selected Proucts',
                    style: FluentTheme.of(context).typography.title,
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                  ListView.builder(
                    controller: ScrollController(),
                    itemCount: selectedNames.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          elevation: 2,
                          child: Checkbox(
                            checked: selectedNames.contains(
                              selectedNames[index],
                            ),
                            onChanged: (value) {
                              if (value == true) {
                                selectedNames.add(selectedNames[index]);
                                setState(() {});
                              } else {
                                selectedNames.remove(selectedNames[index]);
                                setState(() {});
                              }
                            },
                            content: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    selectedNames[index]['image'],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedNames[index]['name'].length > 20
                                          ? selectedNames[index]['name']
                                                  .substring(0, 20) +
                                              '...'
                                          : selectedNames[index]['name'],
                                      style: FluentTheme.of(context)
                                          .typography
                                          .bodyLarge,
                                    ),
                                    Text(
                                      selectedNames[index]['price'],
                                      style: FluentTheme.of(context)
                                          .typography
                                          .bodyLarge,
                                    ),
                                    Text(
                                      selectedNames[index]['flashPrice'].isEmpty
                                          ? 'Add Flash Price'
                                          : '\$${selectedNames[index]['flashPrice']}',
                                      style: selectedNames[index]['flashPrice']
                                              .isEmpty
                                          ? FluentTheme.of(context)
                                              .typography
                                              .bodyLarge!
                                              .copyWith(
                                                color:
                                                    Colors.warningPrimaryColor,
                                              )
                                          : FluentTheme.of(context)
                                              .typography
                                              .bodyLarge,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox flashPriceBox(element) {
    return SizedBox(
      width: 170,
      child: TextBox(
        controller: flashcontroller,
        enabled: selectedNames.contains(element),
        outsideSuffix: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: IconButton(
            icon: Icon(
              FluentIcons.accept,
              size: 18,
            ),
            onPressed: () {
              setState(() {
                element['flashPrice'] = flashcontroller.text;
                flashcontroller.clear();
              });
            },
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: selectedNames.contains(element)
              ? Border.all(
                  color: Colors.grey,
                  width: 1,
                )
              : Border.all(
                  color: Colors.grey[50],
                  width: 1,
                ),
        ),
        header: 'Flesh Price',
      ),
    );
  }
} //random image
//https://picsum.photos/200/300?random

List damiItems = [
  {
    'name': 'Item 1',
    'price': '\$10',
    'flashPrice': '',
    'image': 'https://picsum.photos/200/300?random=2',
  },
  {
    'name': 'Item 2',
    'price': '\$20',
    'flashPrice': '',
    'image': 'https://picsum.photos/200/300?random=4',
  },
  {
    'name': 'Item 3',
    'price': '\$30',
    'flashPrice': '',
    'image': 'https://picsum.photos/200/300?random=6',
  },
  {
    'name': 'Item 4',
    'price': '\$40',
    'flashPrice': '',
    'image': 'https://picsum.photos/200/300?random=12',
  },
  {
    'name': 'Item 5',
    'price': '\$50',
    'flashPrice': '',
    'image': 'https://picsum.photos/200/300?random=9',
  },
  {
    'name': 'Item 6',
    'price': '\$60',
    'flashPrice': '',
    'image': 'https://picsum.photos/200/300?random=10',
  },
  {
    'name': 'Item 7',
    'price': '\$70',
    'flashPrice': '',
    'image': 'https://picsum.photos/200/300?random=11',
  },
  {
    'name': 'Item 8',
    'price': '\$80',
    'flashPrice': '',
    'image': 'https://picsum.photos/200/300?random=22',
  },
  {
    'name': 'Item 9',
    'price': '\$90',
    'flashPrice': '',
    'image': 'https://picsum.photos/200/300?random=7',
  },
  {
    'name': 'Item 10',
    'price': '\$100',
    'flashPrice': '',
    'image': 'https://picsum.photos/200/300?random=8',
  },
];
