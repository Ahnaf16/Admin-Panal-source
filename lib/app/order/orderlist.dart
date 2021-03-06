import 'dart:developer' as d;
import 'dart:math';
import 'package:fluent_ui/fluent_ui.dart';
import '../../widgets/widget_export.dart';
import 'order_details.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List allStatus = [
    'Pending',
    'Prossecing',
    'Picked',
    'Shiped',
    'Delivered',
    'Cancelled',
  ];
  String? status;

  List payMethod = [
    'All',
    'Not Selected',
    'Bkash',
    'Nagad',
    'COD',
  ];
  int payIndex = 0;

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
      header: const PageHeader(
        title: Text('Orders'),
      ),
      content: Stack(
        children: [
          //----------------------main

          BaseBody(
            scrollController: scrollController,
            widthfactor: 1.3,
            children: [
              Row(
                children: [
                  //-----------------search
                  Expanded(
                    flex: 2,
                    child: TextBox(
                      padding: const EdgeInsets.all(8),
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 10),
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
                  const SizedBox(width: 20),
                  //-----------------status
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
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Combobox<String>(
                          placeholder: const Text('Status'),
                          isExpanded: true,
                          items: allStatus
                              .map((e) => ComboboxItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          value: status,
                          onChanged: (value) {
                            status = value;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              //-----------------pay method
              PillButtonBar(
                selected: payIndex,
                onChanged: (value) {
                  setState(() => payIndex = value);
                },
                items: payMethod
                    .map(
                      (e) => PillButtonBarItem(
                        text: Text(e),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              //-----------------order list row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('ID'),
                  Text('Name'),
                  Text('Contact'),
                  SizedBox(),
                  Text('Total'),
                  Text('Status'),
                  Text('Date'),
                  Text('Action'),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              //-----------------order list
              ListView.separated(
                shrinkWrap: true,
                itemCount: 20,
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.all(10),
                    child: Divider(),
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //-----------------id
                      Text('${Random().nextInt(10000)}'),
                      //-----------------name
                      const Text(
                        'Ahnaf Sakil',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //-----------------contact
                      const Text('ahnafsakil9@gmail.com'),
                      //-----------------total
                      Text('\$ ${Random().nextInt(10000)}'),
                      //-----------------status
                      Chip2(
                        text: allStatus[Random().nextInt(allStatus.length)],
                        backgroundColor:
                            const Color.fromARGB(255, 188, 243, 201),
                        textcolor: Colors.green.darkest,
                      ),
                      //-----------------date
                      const Text('12.04.22'),
                      //-----------------action
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: IconButton(
                          icon: const Icon(FluentIcons.view),
                          onPressed: () {
                            Navigator.push(
                              context,
                              FluentPageRoute(
                                builder: (context) => OrderDetails(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          //------------------scroll to top button
          showScrollButton == true
              ? Padding(
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
                          backgroundColor: ButtonState.resolveWith(
                            (states) => states.isHovering
                                ? Colors.blue.light
                                : Colors.blue,
                          ),
                        ),
                        onPressed: () {
                          scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          d.log('scroll to top');
                        },
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

// Flyout(
//   openMode: FlyoutOpenMode.press,
//   content: (context) {
//     return MenuFlyout(
//       items: [
//         MenuFlyoutItem(
//           leading: Icon(FluentIcons.view),
//           text: Text('View'),
//           onPressed: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               FluentPageRoute(
//                 builder: (context) =>
//                     OrderDetails(),
//               ),
//             );
//           },
//         ),
//         MenuFlyoutSeparator(),
//         MenuFlyoutItem(
//           leading: Icon(FluentIcons.edit),
//           text: Text('Edit'),
//           onPressed: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               FluentPageRoute(
//                 builder: (context) =>
//                     EditOrders(),
//               ),
//             );
//           },
//         )
//       ],
//     );
//   },
//   child: Icon(
//     FluentIcons.more,
//   ),
// ),
