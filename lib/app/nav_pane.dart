import 'package:fluent_ui/fluent_ui.dart';

import 'auth/login.dart';
import 'campaign/campaign.dart';
import 'dash/dashboard.dart';
import 'flash/flash.dart';
import 'newsfeed/newsfeed.dart';
import 'order/orderlist.dart';
import 'products/add_products.dart';
import 'products/products_list.dart';
import 'setting/settings.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

int index = 2;

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin Panal'),
        actions: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('Debug'),
            Wrap(
              children: [
                Text(
                  'Height: ' + MediaQuery.of(context).size.height.toString(),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Width: ' + MediaQuery.of(context).size.width.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
      pane: NavigationPane(
        size: const NavigationPaneSize(
          openMaxWidth: 200,
        ),
        selected: index,
        onChanged: (int newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        header: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        displayMode: PaneDisplayMode.auto,
        indicator: const StickyNavigationIndicator(),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.view_dashboard),
            title: const Text('Dashboard'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.product_list),
            title: const Text('Product'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.add_in),
            title: const Text('Add Product'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.activate_orders),
            title: const Text('Orders'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.campaign_template),
            title: const Text('Campaign'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.lightning_bolt),
            title: const Text('Flash'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.news),
            title: const Text('Newsfeed'),
          ),
        ],
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.signin),
            title: const Text('LogIn'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
        ],
      ),
      content: FocusTraversalGroup(
        child: NavigationBody(
          transitionBuilder: (child, animation) =>
              EntrancePageTransition(child: child, animation: animation),
          index: index,
          children: [
            const Dash(),
            const Products(),
            const AddProduct(),
            const OrderList(),
            const Campaign(),
            const Flash(),
            Newsfeed(),
            const LoginPage(),
            const Settings(),
          ],
        ),
      ),
    );
  }
}
