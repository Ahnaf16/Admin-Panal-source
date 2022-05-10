import 'package:auto_route/annotations.dart';

import '../misc/export.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: NavigationPage,
    ),
  ],
)
class $Router {}
