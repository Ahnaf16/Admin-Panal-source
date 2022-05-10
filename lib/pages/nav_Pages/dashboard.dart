// // ignore_for_file: prefer_const_constructors

// import 'package:fluent_ui/fluent_ui.dart';

// class Dash extends StatelessWidget {
//   const Dash({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldPage(
//       header: Text('DASHBOARD'),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Dash extends StatelessWidget {
  Dash({Key? key}) : super(key: key);

  final List products = [
    {
      'img': 'https://picsum.photos/200/300?random=1',
      'name': 'Product 1',
      'quantity': 1,
      'price': 220,
      'total': 220,
    },
    {
      'img': 'https://picsum.photos/200/300?random=2',
      'name': 'Product 2',
      'quantity': 2,
      'price': 150,
      'total': 300,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DataTable(
          dataRowHeight: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          columns: const [
            DataColumn(
              label: Text('Product'),
            ),
            DataColumn(
              numeric: true,
              label: Text('Quantity'),
            ),
            DataColumn(
              numeric: true,
              label: Text('Price'),
            ),
            DataColumn(
              numeric: true,
              label: Text('Total'),
            ),
          ],
          rows: List.generate(
            products.length,
            (index) => DataRow(
              cells: [
                DataCell(
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          products[index]['img'],
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        products[index]['name'],
                      ),
                    ],
                  ),
                ),
                DataCell(
                  Text(products[index]['quantity'].toString()),
                ),
                DataCell(
                  Text(products[index]['price'].toString()),
                ),
                DataCell(
                  Text(products[index]['total'].toString()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
