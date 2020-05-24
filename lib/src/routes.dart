import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'home/home.template.dart' as home_template;
import 'login/login.template.dart' as login_template;
import 'register/register.template.dart' as register_template;
import 'user_product/user_product.template.dart' as user_product_template;
import 'register_product/register_product.template.dart' as register_product_template;

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

  static final userProducts = RouteDefinition(
    routePath: RoutePaths.userProducts,
    component: user_product_template.UserProductNgFactory,
  );

  static final registerProduct = RouteDefinition(
    routePath: RoutePaths.registerProduct,
    component: register_product_template.RegisterProductNgFactory,
  );

  static final all = <RouteDefinition>[
    home,
    login,
    register,
    userProducts,
    registerProduct,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.home.toUrl()
    )
  ];
}