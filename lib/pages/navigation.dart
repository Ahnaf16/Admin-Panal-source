// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import '../misc/export.dart';

// import 'package:flutter/material.dart' as m;

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

int index = 1;

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: Text('GNG Merchent'),
      ),
      pane: NavigationPane(
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
        index: index,
        children: [
          Dash(),
          Products(),
          AddProduct(),
          Flash(),
          Settings(),
        ],
      ),
    );
  }
}
