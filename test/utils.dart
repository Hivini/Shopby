import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/database_handler/product.dart';
import 'package:Shopby/src/database_handler/user.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:mockito/mockito.dart';

class InjectorProbe {
  InjectorFactory _parent;
  Injector _injector;

  InjectorProbe(this._parent);

  InjectorFactory get factory => _factory;
  Injector get injector => _injector ??= _factory();

  Injector _factory([Injector parent]) => _injector = _parent(parent);
  T get<T>(dynamic token) => injector?.get(token);
}

class MockRouter extends Mock implements Router {
  String url = '';

  @override
  Future<NavigationResult> navigate(String path, [NavigationParams navigationParams]) {
    url = path;
    return null;
  }

  String toUrl() {
    return url;
  }
}

class MockDatabase extends Mock implements DatabaseHandlerService {
  @override
  User currentUser = User('test', 'te', 0, 'a', 'a');

  @override
  Future<bool> login(String email, String password) {
    if (password == 'a') {
      currentUser = User('test', 'te', 0, 'a', 'a');
      return Future(() => true);
    }
    return Future(() => false);
  }

  void removeUser() {
    currentUser = null;
  }

  @override
  Future<List<Product>> getProductsByUser(String email) {
    return Future(() => [Product('1', 'Product', 'Desc', 2, 'url', User('test', 'te', 0, 'a', 'a'), 2, 1)]);
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    return Future(() => [Product('1', 'Product', 'Cheap', 2, 'url', User('test', 'te', 0, 'a', 'a'), 2, 1)]);
  }
}