import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gngm_web/Classes/body_base.dart';

import '../../Classes/cached_net_img.dart';

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
        commandBar: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: FilledButton(
            child: const Text('Submit'),
            onPressed: () {},
            style: FluentTheme.of(context).buttonTheme.filledButtonStyle,
          ),
        ),
        title: const Text('Flash'),
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
                //-------------------------searchbox
                TextBox(
                  controller: searchcontroller,
                  onChanged: (value) => setState(() {}),
                  header: 'Search',
                  prefix: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(FluentIcons.search),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                //-------------------------search results
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
                                backgroundColor: Colors.grey[30],
                                elevation: 2,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Checkbox(
                                    checked: selectedNames.contains(element),
                                    onChanged: (value) {
                                      if (value == true) {
                                        showDialog(
                                          context: context,
                                          //---------------------add flash price dialog
                                          builder: (_) => ContentDialog(
                                            constraints: const BoxConstraints(
                                              maxWidth: 300,
                                            ),
                                            title: const Text('Flash Price'),
                                            actions: [
                                              OutlinedButton(
                                                child: const Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                            content: SizedBox(
                                              width: 250,
                                              //---------------------flash box
                                              child: TextBox(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(r'[0-9]'),
                                                  ),
                                                ],
                                                autofocus: true,
                                                controller: flashcontroller,
                                                onChanged: (v) {
                                                  setState(() {});
                                                },
                                                outsideSuffix: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                  ),
                                                  //---------------------done button
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      FluentIcons.accept,
                                                      size: 20,
                                                    ),
                                                    onPressed: () {
                                                      if (flashcontroller
                                                          .text.isNotEmpty) {
                                                        setState(() {
                                                          selectedNames
                                                              .add(element);
                                                          element['flashPrice'] =
                                                              flashcontroller
                                                                  .text;
                                                          flashcontroller
                                                              .clear();
                                                        });
                                                        Navigator.pop(context);
                                                      } else {
                                                        EasyLoading.showToast(
                                                          'Please enter a price',
                                                          toastPosition:
                                                              EasyLoadingToastPosition
                                                                  .bottom,
                                                        );
                                                      }
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
                                                          color:
                                                              Colors.grey[50],
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
                                        //---------------------image
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetImg(
                                            url: element['image'],
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        //---------------------other info
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
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                )
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: BaseBody(
                mainAxisAlignment: MainAxisAlignment.start,
                scrollController: ScrollController(),
                children: [
                  Text(
                    'Selected Proucts',
                    style: FluentTheme.of(context).typography.title,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  ListView.builder(
                    controller: ScrollController(),
                    itemCount: selectedNames.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          backgroundColor: Colors.grey[30],
                          elevation: 2,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
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
                                  //---------------------image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetImg(
                                      url: selectedNames[index]['image'],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //---------------------other info
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
                                        selectedNames[index]['flashPrice']
                                                .isEmpty
                                            ? 'Add Flash Price'
                                            : '\$${selectedNames[index]['flashPrice']}',
                                        style: selectedNames[index]
                                                    ['flashPrice']
                                                .isEmpty
                                            ? FluentTheme.of(context)
                                                .typography
                                                .bodyLarge!
                                                .copyWith(
                                                  color: Colors
                                                      .warningPrimaryColor,
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
}

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
