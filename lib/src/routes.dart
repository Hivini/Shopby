import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'home/home.template.dart' as home_template;
import 'login/login.template.dart' as login_template;
import 'register/register.template.dart' as register_template;

export 'route_paths.dart';

class Routes {
  static final home = RouteDefinition(
    routePath: RoutePaths.home,
    component: home_template.HomeComponentNgFactory,
    useAsDefault: true
  );

  static final login = RouteDefinition(
    routePath: RoutePaths.login,
    component: login_template.LoginNgFactory,
  );

  static final register = RouteDefinition(
    routePath: RoutePaths.register,
    component: register_template.RegisterNgFactory,
  );

  static final all = <RouteDefinition>[
    home,
    login,
    register,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.home.toUrl()
    )
  ];
}