// ignore_for_file: prefer_const_constructors

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gngm_web/Classes/body_base.dart';
import 'package:gngm_web/misc/export.dart';

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
        commandBar: FilledButton(
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
        title: Text('Campaign'),
      ),
      content: BaseBody(children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 100,
              height: 100,
              child: Card(
                //random color generator,

                child: Center(
                  //random image generator,
                  child: Image.network(
                    'https://picsum.photos/id/$index/100/100',
                  ),
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
