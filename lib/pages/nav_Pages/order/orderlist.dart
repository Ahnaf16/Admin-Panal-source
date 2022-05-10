// ignore_for_file: prefer_const_constructors

import 'dart:developer' as d;
import 'dart:math';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gngm_web/misc/export.dart';
import 'package:gngm_web/pages/nav_Pages/order/edit_order.dart';

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
      header: PageHeader(
        title: Text('Orders'),
      ),
      content: Stack(
        children: [
          SingleChildScrollView(
            physics: ScrollPhysics(),
            controller: scrollController,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
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
                            SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(height: 20),
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
                        SizedBox(height: 20),
                        Divider(),
                        SizedBox(height: 20),
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
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        ListView.separated(
                          // controller: scrollController,
                          shrinkWrap: true,
                          itemCount: 20,
                          separatorBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Divider(),
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${Random().nextInt(10000)}'),
                                Text(
                                  'Ahnaf Sakil',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('ahnafsakil9@gmail.com'),
                                Text('\$ ${Random().nextInt(10000)}'),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.green.lightest,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    allStatus[
                                        Random().nextInt(allStatus.length)],
                                    style: TextStyle(
                                      color: Colors.green.darkest,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text('12.04.22'),
                                Flyout(
                                  openMode: FlyoutOpenMode.press,
                                  content: (context) {
                                    return MenuFlyout(
                                      items: [
                                        MenuFlyoutItem(
                                          leading: Icon(FluentIcons.view),
                                          text: Text('View'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              FluentPageRoute(
                                                builder: (context) =>
                                                    OrderDetails(),
                                              ),
                                            );
                                          },
                                        ),
                                        MenuFlyoutSeparator(),
                                        MenuFlyoutItem(
                                          leading: Icon(FluentIcons.edit),
                                          text: Text('Edit'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              FluentPageRoute(
                                                builder: (context) =>
                                                    EditOrders(),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  },
                                  child: Icon(
                                    FluentIcons.more,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                        d.log('scroll to top');
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
