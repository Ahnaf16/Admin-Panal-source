// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gngm_web/misc/export.dart';
import 'package:intl/intl.dart';

import '../../../services/provider.dart';

class OrderDetails extends ConsumerWidget {
  OrderDetails({Key? key}) : super(key: key);
  final flyoutController = FlyoutController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Typography typeTheme = FluentTheme.of(context).typography;

    final enableEdit = ref.watch(enableEditProvider);
    final status = ref.watch(orderStstusChangeerProvider);
    final allStatus = ref.watch(allStatusProvider);

    changeEnableEdit() {
      return ref.read(enableEditProvider.state).state =
          !ref.read(enableEditProvider.state).state;
    }

    return NavigationView(
      appBar: NavigationAppBar(
        leading: IconButton(
          icon: Icon(FluentIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        title: PageHeader(
          title: Text('Order Details'),
        ),
      ),
      content: ScaffoldPage(
        content: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height,
              child: Card(
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  //------------------------ main colume
                  child: Column(
                    children: [
                      //------------------------ header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(FluentIcons.calendar),
                          const SizedBox(width: 10),
                          Text(
                            DateFormat('EEE, LLL d. y, h:mm a')
                                .format(DateTime.now()),
                            style: FluentTheme.of(context)
                                .typography
                                .bodyStrong!
                                .merge(
                                  typeTheme.bodyLarge,
                                ),
                          ),

                          Spacer(
                            flex: 2,
                          ),
                          // ----------------------------status

                          enableEdit
                              ? Expanded(
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
                                      placeholder: const Text('Change Status'),
                                      isExpanded: true,
                                      items: allStatus
                                          .map((e) => ComboboxItem<String>(
                                                value: e,
                                                child: Text(e),
                                              ))
                                          .toList(),
                                      value: status,
                                      onChanged: (value) {
                                        ref
                                            .read(orderStstusChangeerProvider
                                                .state)
                                            .state = value;
                                      },
                                    ),
                                  ),
                                )
                              : Chip2(
                                  text: 'Pending',
                                  backgroundColor:
                                      Color.fromARGB(255, 188, 243, 201),
                                  textcolor: Colors.green.darkest,
                                ),

                          SizedBox(width: 10),

                          //----------------------------edit button
                          OutlinedButton(
                            child: Text(enableEdit ? 'Cancel' : 'Edit'),
                            onPressed: () {
                              changeEnableEdit();
                            },
                            style: FluentTheme.of(context)
                                .buttonTheme
                                .outlinedButtonStyle,
                          ),
                          SizedBox(width: 10),
                          //----------------------------save button
                          enableEdit
                              ? OutlinedButton(
                                  child: Text('Save Edits'),
                                  onPressed: () {
                                    changeEnableEdit();
                                  },
                                  style: FluentTheme.of(context)
                                      .buttonTheme
                                      .outlinedButtonStyle,
                                )
                              : SizedBox(),
                        ],
                      ),
                      //-------------------------invoice number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Invoice: GnG47545726523',
                            style: FluentTheme.of(context)
                                .typography
                                .bodyStrong!
                                .copyWith(fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            icon: Icon(FluentIcons.copy),
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: 'GnG47545726523',
                                ),
                              ).whenComplete(
                                () => EasyLoading.showToast(
                                  'Copied to Clipboard',
                                  toastPosition:
                                      EasyLoadingToastPosition.bottom,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 15),
                      //-------------------------customer info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[50],
                            child: Icon(FluentIcons.contact),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer Info',
                                style: FluentTheme.of(context)
                                    .typography
                                    .bodyLarge,
                              ),
                              Text('Ahnaf Sakil'),
                              Text('ahnafsakil9@gmail.com'),
                              Text('01xxxxxxxxx'),
                            ],
                          ),
                          //-------------------------order info
                          Spacer(
                            flex: 1,
                          ),
                          CircleAvatar(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[50],
                            child: Icon(FluentIcons.delivery_truck),
                          ),

                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Info',
                                style: FluentTheme.of(context)
                                    .typography
                                    .bodyLarge,
                              ),
                              Text('Payment Method: Cash'),
                              Text('Status: Picked'),
                            ],
                          ),
                          //-------------------------delivery info
                          Spacer(
                            flex: 1,
                          ),
                          CircleAvatar(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[50],
                            child: Icon(FluentIcons.p_b_i_anomalies_marker),
                          ),

                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deliver To',
                                style: FluentTheme.of(context)
                                    .typography
                                    .bodyLarge,
                              ),
                              Text('Region: Dhaka'),
                              Text('District: Dhaka'),
                              Text('Address: Mirpur 10'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //-------------------------Data table
                              OrderDataTable(
                                rowlength: products.length,
                                data: products,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  cashInfo(
                                    CrossAxisAlignment.start,
                                    typeTheme,
                                    'Subtotal :',
                                    'Delivary charge :',
                                    'Total :',
                                    'Padi Ammount :  ',
                                    'Due :',
                                    false,
                                    enableEdit,
                                  ),
                                  cashInfo(
                                    CrossAxisAlignment.end,
                                    typeTheme,
                                    '\$ ${products.fold<num>(
                                      0,
                                      (a, b) => a + b['total'],
                                    )}',
                                    ' \$ 60',
                                    '\$ ${products.fold<num>(
                                      60,
                                      (a, b) => a + b['total'],
                                    )}',
                                    '\$ 500',
                                    '\$ 80',
                                    true,
                                    enableEdit,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column cashInfo(
    CrossAxisAlignment crossAxisAlignment,
    Typography typeTheme,
    String t1,
    String t2,
    String t3,
    String t4,
    String t5,
    bool isEditable,
    bool enableEdit,
  ) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          t1,
          style: typeTheme.bodyStrong,
        ),
        Text(
          t2,
          style: typeTheme.bodyStrong,
        ),
        Text(
          t3,
          style: typeTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        isEditable
            ? SizedBox(
                width: 100,
                child: TextBox(
                  padding: kTextBoxPadding.copyWith(right: 0),
                  textAlign: TextAlign.end,
                  enabled: enableEdit,
                  placeholder: t4,
                  placeholderStyle: typeTheme.bodyStrong,
                ),
              )
            : Text(
                t4,
                style: typeTheme.bodyStrong,
              ),
        Text(
          t5,
          style: typeTheme.bodyStrong,
        )
      ],
    );
  }
}

List products = [
  {
    //random network img
    'img': 'https://picsum.photos/200/300?random=1',
    'name': 'Product 1',
    'quantity': 1,
    'price': 220,
    'total': 220,
  },
  {
    //random network img
    'img': 'https://picsum.photos/200/300?random=2',
    'name': 'Product 2',
    'quantity': 2,
    'price': 150,
    'total': 300,
  },
];
