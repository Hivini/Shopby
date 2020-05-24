import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/route_paths.dart';
import 'package:Shopby/src/routes.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/app_layout/material_persistent_drawer.dart';
import 'package:angular_components/content/deferred_content.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'package:angular_components/material_list/material_list.dart';
import 'package:angular_components/material_list/material_list_item.dart';
import 'package:angular_components/material_toggle/material_toggle.dart';
import 'package:angular_router/angular_router.dart';

import 'src/home/home.dart';

@Component(
  selector: 'my-app',
  styleUrls: [
    'package:angular_components/app_layout/layout.scss.css',
    'app_component.css',
  ],
  templateUrl: 'app_component.html',
  directives: [
    HomeComponent,
    DeferredContentDirective,
    MaterialButtonComponent,
    MaterialIconComponent,
    MaterialPersistentDrawerDirective,
    MaterialToggleComponent,
    MaterialListComponent,
    MaterialListItemComponent,
    routerDirectives,
    coreDirectives,
  ],
  exports: [RoutePaths, Routes],
)
class AppComponent {
  final DatabaseHandlerService dbService;
  final Router _router;

  AppComponent(this.dbService, this._router);

  void signOut() {
    dbService.currentUser = null;
    _router.navigate('/home');
  }
}
