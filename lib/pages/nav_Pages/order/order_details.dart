// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:gngm_web/misc/export.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Typography typeTheme = FluentTheme.of(context).typography;
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
                //------------------------ main colume
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      //------------------------ header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(FluentIcons.calendar),
                          SizedBox(width: 10),
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
                          //----------------------------status

                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.green.lightest,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Pickup',
                              style: TextStyle(
                                color: Colors.green.darkest,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),

                          FilledButton(
                            child: Text('Edit'),
                            onPressed: () => Navigator.push(
                              context,
                              FluentPageRoute(
                                builder: (_) => EditOrders(),
                              ),
                            ),
                            style: FluentTheme.of(context)
                                .buttonTheme
                                .filledButtonStyle,
                          ),
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
                            onPressed: () {},
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
                          Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[50],
                            ),
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
                          Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[50],
                            ),
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
                          Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[50],
                            ),
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
                              m.DataTable(
                                showBottomBorder: true,
                                dividerThickness: 2,
                                dataRowHeight: 70,
                                columns: [
                                  m.DataColumn(
                                    label: Text('Product'),
                                  ),
                                  m.DataColumn(
                                    numeric: true,
                                    label: Text('Quantity'),
                                  ),
                                  m.DataColumn(
                                    numeric: true,
                                    label: Text('Price'),
                                  ),
                                  m.DataColumn(
                                    numeric: true,
                                    label: Text('Total'),
                                  ),
                                ],
                                rows: List.generate(
                                  products.length,
                                  (index) => m.DataRow(
                                    cells: [
                                      m.DataCell(
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                products[index]['img'],
                                                height: 60,
                                                width: 60,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              products[index]['name'],
                                            ),
                                          ],
                                        ),
                                      ),
                                      m.DataCell(
                                        Text(products[index]['quantity']
                                            .toString()),
                                      ),
                                      m.DataCell(
                                        Text('\$ ${products[index]['price']}'),
                                      ),
                                      m.DataCell(
                                        Text('\$ ${products[index]['total']}'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Subtotal :',
                                        style: typeTheme.bodyStrong,
                                      ),
                                      Text(
                                        'Delivary charge :',
                                        style: typeTheme.bodyStrong,
                                      ),
                                      Text(
                                        'Total :',
                                        style: typeTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Padi Ammount :',
                                        style: typeTheme.bodyStrong,
                                      ),
                                      Text(
                                        'Due :',
                                        style: typeTheme.bodyStrong,
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$ ' +
                                            products
                                                .fold<num>(
                                                  0,
                                                  (a, b) => a + b['total'],
                                                )
                                                .toString(),
                                        style: typeTheme.bodyStrong,
                                      ),
                                      Text(
                                        ' \$ 60',
                                        style: typeTheme.bodyStrong,
                                      ),
                                      Text(
                                        '\$ ' +
                                            products
                                                .fold<num>(
                                                  60,
                                                  (a, b) => a + b['total'],
                                                )
                                                .toString(),
                                        style: typeTheme.bodyStrong!.copyWith(
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '\$ 500',
                                        style: typeTheme.bodyStrong,
                                      ),
                                      Text(
                                        '\$ 80',
                                        style: typeTheme.bodyStrong,
                                      )
                                    ],
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
