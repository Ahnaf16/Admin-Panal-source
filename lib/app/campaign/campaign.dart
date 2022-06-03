// ignore_for_file: prefer_const_constructors

import 'package:fluent_ui/fluent_ui.dart';
import '../../widgets/widget_export.dart';
import 'add_campaign.dart';

class Campaign extends StatefulWidget {
  const Campaign({Key? key}) : super(key: key);

  @override
  State<Campaign> createState() => _CampaignState();
}

class _CampaignState extends State<Campaign> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        commandBar: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: FilledButton(
            child: Text('Add Campaign'),
            onPressed: () {
              Navigator.push(
                context,
                FluentPageRoute(
                  builder: (_) => AddCampaign(),
                ),
              );
            },
            style: FluentTheme.of(context).buttonTheme.filledButtonStyle,
          ),
        ),
        title: Text('Campaign'),
      ),
      content: BaseBody(
        widthfactor: 1.3,
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Flyout(
                  openMode: FlyoutOpenMode.press,
                  content: (context) => MenuFlyout(
                    items: [
                      MenuFlyoutItem(
                        text: Text('Remove'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  child: Card(
                    backgroundColor: Colors.grey[30],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetImg(
                            url: 'https://picsum.photos/id/$index/500/200',
                          ),
                        ),
                        Text(
                          'Campaign $index',
                          style: FluentTheme.of(context).typography.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
