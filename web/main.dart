import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:Shopby/app_component.template.dart' as ng;

import 'main.template.dart' as self;

@GenerateInjector([
  routerProvidersHash,
  ClassProvider(DatabaseHandlerService),
  ClassProvider(Client, useClass: BrowserClient),
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
