// ignore_for_file: prefer_const_constructors

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text('Oders'),
      ),
      content: SingleChildScrollView(
        child: StaggeredGrid.count(
          crossAxisCount: 5,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          children: List.generate(
            20,
            (index) => Card(
              child: Column(
                children: [
                  Image.network(
                    //rendom image genaretor
                    'https://picsum.photos/250?image=${(index * 10) + 1}',
                  ),
                  Text('$index'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
