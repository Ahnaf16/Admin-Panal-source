// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gngm_web/pages/nav_Pages/order/orderlist.dart';
import '../misc/export.dart';

// import 'package:flutter/material.dart' as m;

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

int index = 3;

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: Text('GNG Merchent'),
      ),
      pane: NavigationPane(
        size: NavigationPaneSize(
          openMaxWidth: 200,
        ),
        selected: index,
        onChanged: (int newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        displayMode: PaneDisplayMode.auto,
        indicator: StickyNavigationIndicator(),
        items: [
          PaneItem(
            icon: Icon(FluentIcons.view_dashboard),
            title: Text('Dashboard'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: Icon(FluentIcons.product_list),
            title: Text('Product'),
          ),
          PaneItem(
            icon: Icon(FluentIcons.add_in),
            title: Text('Add Product'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: Icon(FluentIcons.activate_orders),
            title: Text('Orders'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: Icon(FluentIcons.lightning_bolt),
            title: Text('Flash'),
          ),
        ],
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: Icon(FluentIcons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
      content: NavigationBody(
        transitionBuilder: (child, animation) =>
            EntrancePageTransition(child: child, animation: animation),
        index: index,
        children: [
          Dash(),
          Products(),
          AddProduct(),
          OrderList(),
          Flash(),
          Settings(),
        ],
      ),
    );
  }
}
