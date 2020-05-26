import 'package:Shopby/src/database_handler/database_handler_service.dart';
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

class MockRouter extends Mock implements Router {}

class MockDatabase extends Mock implements DatabaseHandlerService {
  @override
  User currentUser;

  @override
  Future<bool> login(String email, String password) {
    currentUser = User('test', 'te', 0, 'a', 'a');
    return Future(() => true);
  }
}