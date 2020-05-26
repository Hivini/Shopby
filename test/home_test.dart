@TestOn('browser')

import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/home/home.dart';
import 'package:Shopby/src/home/home.template.dart' as ng;
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:test/test.dart';

import 'home_po.dart';
import 'home_test.template.dart' as self;
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
  NgTestFixture<HomeComponent> fixture;
  HomePO homePO;

  setUp(() async {
    final db = injector.get<MockDatabase>(DatabaseHandlerService);
    await db.login('a', 'a');
    final testBed =
    NgTestBed.forComponent<HomeComponent>(ng.HomeComponentNgFactory, rootInjector: injector.factory);
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  group('search products', () {
    setUp(() async {
      final context =
      HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      homePO = HomePO.create(context);
      await homePO.typeSearch('cheap');
      await homePO.clickSearch();
      await fixture.update();
    });

    test('product shows up', () {
      expect(homePO.productInfoTitle, isNotNull);
    });
  });
}