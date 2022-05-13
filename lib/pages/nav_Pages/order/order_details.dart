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

    return ScaffoldPage(
      header: PageHeader(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IconButton(
              icon: const Icon(
                FluentIcons.back,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text('Order Details'),
      ),
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
                        const Icon(FluentIcons.calendar),
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

                        const Spacer(
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
                                          .read(
                                              orderStstusChangeerProvider.state)
                                          .state = value;
                                    },
                                  ),
                                ),
                              )
                            : Chip2(
                                text: 'Pending',
                                backgroundColor:
                                    const Color.fromARGB(255, 188, 243, 201),
                                textcolor: Colors.green.darkest,
                              ),

                        const SizedBox(width: 10),

                        //----------------------------edit button
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: OutlinedButton(
                            child: Text(enableEdit ? 'Cancel' : 'Edit'),
                            onPressed: () {
                              changeEnableEdit();
                            },
                            style: FluentTheme.of(context)
                                .buttonTheme
                                .outlinedButtonStyle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        //----------------------------save button
                        enableEdit
                            ? MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: FilledButton(
                                  child: const Text('Save Edits'),
                                  onPressed: () {
                                    changeEnableEdit();
                                  },
                                  style: ButtonStyle(
                                    padding: ButtonState.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 8,
                                      ),
                                    ),
                                    shape: ButtonState.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
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
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(FluentIcons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              const ClipboardData(
                                text: 'GnG47545726523',
                              ),
                            ).whenComplete(
                              () => EasyLoading.showToast(
                                'Copied to Clipboard',
                                toastPosition: EasyLoadingToastPosition.bottom,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 15),
                    //-------------------------customer info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[50],
                          child: const Icon(FluentIcons.contact),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Customer Info',
                              style:
                                  FluentTheme.of(context).typography.bodyLarge,
                            ),
                            const Text('Ahnaf Sakil'),
                            const Text('ahnafsakil9@gmail.com'),
                            const Text('01xxxxxxxxx'),
                          ],
                        ),
                        //-------------------------order info
                        const Spacer(
                          flex: 1,
                        ),
                        CircleAvatar(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[50],
                          child: const Icon(FluentIcons.delivery_truck),
                        ),

                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Info',
                              style:
                                  FluentTheme.of(context).typography.bodyLarge,
                            ),
                            const Text('Payment Method: Cash'),
                            const Text('Status: Picked'),
                          ],
                        ),
                        //-------------------------delivery info
                        const Spacer(
                          flex: 1,
                        ),
                        CircleAvatar(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[50],
                          child: const Icon(FluentIcons.p_b_i_anomalies_marker),
                        ),

                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deliver To',
                              style:
                                  FluentTheme.of(context).typography.bodyLarge,
                            ),
                            const Text('Region: Dhaka'),
                            const Text('District: Dhaka'),
                            const Text('Address: Mirpur 10'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

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
                            const SizedBox(height: 10),
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
    );
  }

  Column cashInfo(
    CrossAxisAlignment crossAxisAlignment,
    Typography typeTheme,
    String subtotle,
    String delivary,
    String total,
    String paid,
    String due,
    bool isEditable,
    bool enableEdit,
  ) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          subtotle,
          style: typeTheme.bodyLarge,
        ),
        Text(
          delivary,
          style: typeTheme.bodyLarge,
        ),
        Text(
          total,
          style: typeTheme.bodyLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        isEditable
            ? SizedBox(
                width: 100,
                child: TextBox(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'),
                    ),
                  ],
                  controller: TextEditingController(
                    text: paid,
                  ),
                  padding: kTextBoxPadding.copyWith(right: 0),
                  textAlign: enableEdit ? TextAlign.start : TextAlign.end,
                  enabled: enableEdit,
                  style: typeTheme.bodyLarge,
                  decoration: enableEdit
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        )
                      : null,
                ),
              )
            : Text(
                paid,
                style: typeTheme.bodyLarge,
              ),
        Text(
          due,
          style: typeTheme.bodyLarge,
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
