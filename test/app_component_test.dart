@TestOn('browser')

import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';
import 'package:Shopby/app_component.dart';
import 'package:Shopby/app_component.template.dart' as ng;
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:test/test.dart';

import 'app_component_test.template.dart' as self;
import 'app_component_po.dart';
import 'utils.dart';

@GenerateInjector([
  routerProvidersHash,
  ClassProvider(DatabaseHandlerService, useClass: MockDatabase),
  ClassProvider(Router, useClass: MockRouter),
  ClassProvider(Client, useClass: BrowserClient),
])
final InjectorFactory rootInjector = self.rootInjector$Injector;

void main() {
  final injector = InjectorProbe(rootInjector);
  final testBed =
  NgTestBed.forComponent<AppComponent>(ng.AppComponentNgFactory, rootInjector: injector.factory);
  NgTestFixture<AppComponent> fixture;
  AppComponentPO appComponentPO;

  setUp(() async {
    fixture = await testBed.create();
    final context =
      HtmlPageLoaderElement.createFromElement(fixture.rootElement);
    appComponentPO = AppComponentPO.create(context);
  });

  tearDown(disposeAnyRunningTest);

  group('grant access', () {
    setUp(() async {
      final db = injector.get<MockDatabase>(DatabaseHandlerService);
      await db.removeUser();
      await fixture.update();
      final context =
      HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      appComponentPO = AppComponentPO.create(context);
    });

    test('Login appears', () {
      expect(appComponentPO.loginButtonText, 'Login');
      expect(appComponentPO.registerButtonText, 'Register');
    });
  });

  group('correct login credentials', () {
    setUp(() async {
      final db = injector.get<MockDatabase>(DatabaseHandlerService);
      await db.removeUser();
      await db.login('a', 'a');
      await fixture.update();
      final context =
        HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      appComponentPO = AppComponentPO.create(context);
    });

    test('Logged user', () {
      expect(appComponentPO.productsButtonText, isNotNull);
    });
  });

  group('incorrect login credentials', () {
    setUp(() async {
      final db = injector.get<MockDatabase>(DatabaseHandlerService);
      await db.removeUser();
      await db.login('a', 'b');
      await fixture.update();
      final context =
      HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      appComponentPO = AppComponentPO.create(context);
    });

    test('Logged user', () {
      expect(appComponentPO.registerButtonText, isNotNull);
    });
  });
}