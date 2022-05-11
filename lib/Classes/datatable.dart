import 'package:flutter/material.dart';

class OrderDataTable extends StatelessWidget {
  const OrderDataTable({
    Key? key,
    required this.rowlength,
    required this.data,
  }) : super(key: key);

  final int rowlength;

  final List data;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      showBottomBorder: true,
      dividerThickness: 2,
      dataRowHeight: 70,
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
        rowlength,
        (inx) {
          return DataRow(
            cells: [
              DataCell(
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        data[inx]['img'], //product image
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      data[inx]['name'], // 'Product Name',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(
                Text(data[inx]['quantity'].toString()), // 'Quantity',
              ),
              DataCell(
                Text('\$ ${data[inx]['price']}'), // 'Price',
              ),
              DataCell(
                Text('\$ ${data[inx]['total']}'), // 'Total',
              ),
            ],
          );
        },
      ),
    );
  }
}
