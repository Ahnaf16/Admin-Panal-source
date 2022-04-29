// ignore_for_file: prefer_const_constructors

// import 'package:fluent_ui/fluent_ui.dart';

// class EditProduct extends StatelessWidget {
//   const EditProduct({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldPage(
//       header: Text('Edit Product'),
//     );
//   }
// }

import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  List<String> citys = [
    'dhaka',
    'chittagong',
    'rajshahi',
  ];

  String? city;

  Map<String, List<String>> dists = {
    'dhaka': ['Gajipur', 'Farmgate', 'Mirpur'],
    'chittagong': ['Coxs Bazar', 'Chandgaon', 'Brahmanbaria'],
    'rajshahi': ['sirajganj', 'dinajpur', 'pabna'],
  };

  String? dist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              elevation: 8,
              hint: Text('City'),
              isExpanded: true,
              value: city,
              items: citys.map(
                (e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) => setState(() {
                dist = null;
                city = value!;
              }),
            ),
            SizedBox(
              height: 10,
            ),
            city == null
                ? Container()
                : DropdownButton<String>(
                    elevation: 8,
                    hint: Text('District'),
                    isExpanded: true,
                    value: dist,
                    items: dists[city]!.map(
                      (e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) => setState(() {
                      dist = value!;
                    }),
                  ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Address',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'City : $city',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'District : $dist',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              city == 'dhaka'
                  ? 'Delivary charge : 60'
                  : 'Delivary charge : 100',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
