import 'package:fluent_ui/fluent_ui.dart';
import '../../../Classes/cached_net_img.dart';
import '../../../misc/export.dart';

class AddCampaign extends StatefulWidget {
  const AddCampaign({Key? key}) : super(key: key);

  @override
  State<AddCampaign> createState() => _AddCampaignState();
}

class _AddCampaignState extends State<AddCampaign> {
  List<Map> names = [
    {'name': 'Ahnaf', 'id': 1},
    {'name': 'Sakil', 'id': 2},
    {'name': 'Jakir', 'id': 3},
    {'name': 'Ahmad', 'id': 4},
    {'name': 'Mehedy', 'id': 5},
    {'name': 'Raju', 'id': 6},
    {'name': 'Zaynab', 'id': 7},
    {'name': 'Rahim', 'id': 8},
    {'name': 'Hossain', 'id': 9},
    {'name': 'Tamim', 'id': 10},
  ];
  List<Map> selectedNames = [];

  final searchcontroller = TextEditingController();
  FlyoutController flyoutController = FlyoutController();

  @override
  void dispose() {
    searchcontroller.dispose();
    flyoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        commandBar: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: FilledButton(
            child: const Text('Publish'),
            onPressed: () {},
            style: FluentTheme.of(context).buttonTheme.filledButtonStyle,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IconButton(
              icon: const Icon(
                FluentIcons.back,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: const Text('Add Campaign'),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseBody(
              //-----------------left side
              crossAxisAlignment: CrossAxisAlignment.start,
              widthfactor: 1.8,
              children: [
                //-----------------search box
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
                //-----------------search results
                ListView(
                  shrinkWrap: true,
                  children:
                      // searchcontroller.text.isEmpty
                      //     ? [
                      //         Text('No results found'),
                      //       ]
                      //     :
                      names
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
                                      // log(element['name'], name: 'element');
                                      if (value == true) {
                                        selectedNames.add(element);
                                        setState(() {});
                                      } else {
                                        selectedNames.remove(element);
                                        setState(() {});
                                      }
                                    },
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(element['name']),
                                        Text(element['id'].toString()),
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
                //-----------------right side
                mainAxisAlignment: MainAxisAlignment.start,
                // height: 400,
                scrollController: ScrollController(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //-----------------selecte img button
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: IconButton(
                            icon: const Icon(FluentIcons.file_image),
                            onPressed: () {},
                            style: ButtonStyle(
                              padding: ButtonState.all<EdgeInsets>(
                                const EdgeInsets.all(15),
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
                            )),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        //-----------------selected img
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Flyout(
                              openMode: FlyoutOpenMode.press,
                              content: (context) {
                                return MenuFlyout(
                                  items: [
                                    MenuFlyoutItem(
                                      leading: const Icon(FluentIcons.view),
                                      text: const Text('View'),
                                      onPressed: () {
                                        flyoutController.close();
                                        showDialog(
                                            context: context,
                                            builder: (_) => ContentDialog(
                                                  constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                  ),
                                                  content: ImgView(
                                                    tag: index.toString(),
                                                    url:
                                                        'https://picsum.photos/600/300?random=${index + 3}',
                                                  ),
                                                ));
                                      },
                                    ),
                                    MenuFlyoutItem(
                                      leading: const Icon(FluentIcons.remove),
                                      text: const Text('Remove'),
                                      onPressed: () {
                                        flyoutController.close();
                                      },
                                    )
                                  ],
                                );
                              },
                              //-----------------selected img preview
                              child: Hero(
                                tag: 'image',
                                child: CachedNetImg(
                                  //rendom image generator
                                  url: 'https://picsum.photos/200/300?random=1',
                                  height: 100,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //-----------------campaign name
                  TextBox(
                    header: 'Title',
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Selected Proucts',
                    style: FluentTheme.of(context).typography.title,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  //-----------------selected products
                  ListView.builder(
                    controller: ScrollController(),
                    itemCount: selectedNames.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          elevation: 2,
                          backgroundColor: Colors.grey[30],
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
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedNames[index]['name'],
                                  ),
                                  Text(
                                    selectedNames[index]['id'].toString(),
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
