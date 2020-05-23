import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_router/angular_router.dart';

import '../route_paths.dart';
import '../routes.dart';

@Component(
  selector: 'login',
  templateUrl: 'login.html',
  directives: [
    coreDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialButtonComponent,
    MaterialInputComponent,
  ],
  exports: [RoutePaths, Routes],
)
class Login {
  final DatabaseHandlerService _dbService;
  final Location _location;

  String email = '';
  String password = '';

  Login(this._dbService, this._location);

  void onSubmit() async {
    var success = await _dbService.login(email, password);
    print(success);
    clear();
    _location.back();
  }

  void clear() {
    email = '';
    password = '';
  }

  bool isValid() {
    if (email == '' && password == '') {
      return false;
    }
    return true;
  }
}
