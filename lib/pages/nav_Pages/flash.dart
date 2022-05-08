// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fluent_ui/fluent_ui.dart';

class Flash extends StatefulWidget {
  const Flash({Key? key}) : super(key: key);

  @override
  State<Flash> createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Flash Sell'),
        commandBar: FilledButton(
          child: const Text('Publish'),
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
                  width: MediaQuery.of(context).size.width / 2,
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
                                header: 'Search',
                                prefix: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                              // Padding(
                              //   padding: const EdgeInsets.all(10),
                              //   child: Divider(),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: damiItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              checked: false,
                                              onChanged: (v) {},
                                            ),
                                            SizedBox(width: 10),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                'https://picsum.photos/200/300?random=$index',
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              damiItems[index]['name'],
                                              style: FluentTheme.of(context)
                                                  .typography
                                                  .title,
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          damiItems[index]['price'],
                                          style: FluentTheme.of(context)
                                              .typography
                                              .title,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
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

  InfoLabel sidePanal(BuildContext context) {
    return InfoLabel(
      label: 'Added Products',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}

List damiItems = [
  {
    'name': 'Item 1',
    'price': '\$10',
    'image': 'https://picsum.photos/200/300',
  },
  {
    'name': 'Item 2',
    'price': '\$20',
    'image': 'https://picsum.photos/200/300',
  },
  {
    'name': 'Item 3',
    'price': '\$30',
    'image': 'https://picsum.photos/200/300',
  },
  {
    'name': 'Item 4',
    'price': '\$40',
    'image': 'https://picsum.photos/200/300',
  },
  {
    'name': 'Item 5',
    'price': '\$50',
    'image': 'https://picsum.photos/200/300',
  },
  {
    'name': 'Item 6',
    'price': '\$60',
    'image': 'https://picsum.photos/200/300',
  },
  {
    'name': 'Item 7',
    'price': '\$70',
    'image': 'https://picsum.photos/200/300',
  },
  {
    'name': 'Item 8',
    'price': '\$80',
    'image': 'https://picsum.photos/200/300',
  },
  {
    'name': 'Item 9',
    'price': '\$90',
    'image': 'https://picsum.photos/200/300',
  },
  {
    'name': 'Item 10',
    'price': '\$100',
    'image': 'https://picsum.photos/200/300',
  },
];
