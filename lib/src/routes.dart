import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'home/home.template.dart' as home_template;

export 'route_paths.dart';

class Routes {
  static final home = RouteDefinition(
    routePath: RoutePaths.home,
    component: home_template.HomeNgFactory,
    useAsDefault: true
  );

  static final all = <RouteDefinition>[
    home,
  ];
}