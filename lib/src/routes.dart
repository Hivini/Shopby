import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'home/home.template.dart' as home_template;
import 'login/login.template.dart' as login_template;
import 'register/register.template.dart' as register_template;
import 'user_product/user_product.template.dart' as user_product_template;
import 'register_product/register_product.template.dart' as register_product_template;
import 'chat_window/chat_window.template.dart' as chat_window_template;
import 'statistics_page/statistics_page.template.dart' as statistics_page_template;
import 'register_moderator/register_moderator.template.dart' as register_moderator_template;
import 'user_history/user_history.template.dart' as user_history_template;

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

  static final chatWindow = RouteDefinition(
    routePath: RoutePaths.chatWindow,
    component: chat_window_template.ChatWindowNgFactory,
  );

  static final statisticsPage = RouteDefinition(
    routePath: RoutePaths.statistics,
    component: statistics_page_template.StatisticsPageNgFactory,
  );

  static final registerModerator = RouteDefinition(
    routePath: RoutePaths.registerModerator,
    component: register_moderator_template.RegisterModeratorNgFactory,
  );

  static final userHistory = RouteDefinition(
    routePath: RoutePaths.userHistory,
    component: user_history_template.UserHistoryNgFactory,
  );

  static final all = <RouteDefinition>[
    home,
    login,
    register,
    userProducts,
    registerProduct,
    chatWindow,
    statisticsPage,
    registerModerator,
    userHistory,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.home.toUrl()
    )
  ];
}