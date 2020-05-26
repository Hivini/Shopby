@TestOn('browser')

import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/user_product/user_product.dart';
import 'package:Shopby/src/user_product/user_product.template.dart' as ng;
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/html.dart';
import 'package:test/test.dart';

import 'user_product_po.dart';
import 'user_product_test.template.dart' as self;
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
  NgTestFixture<UserProduct> fixture;
  UserProductPO userProductPO;

  setUp(() async {
    final db = injector.get<MockDatabase>(DatabaseHandlerService);
    await db.login('a', 'a');
    final testBed =
    NgTestBed.forComponent<UserProduct>(ng.UserProductNgFactory, rootInjector: injector.factory);
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  group('show user products', () {
    setUp(() async {
      final context =
        HtmlPageLoaderElement.createFromElement(fixture.rootElement);
      userProductPO = UserProductPO.create(context);
    });

    test('user products', () {
      expect(userProductPO.productInfoTitle, isNotNull);
    });
  });
}