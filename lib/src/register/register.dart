import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_router/angular_router.dart';

import '../route_paths.dart';
import '../routes.dart';

@Component(
  selector: 'register',
  templateUrl: 'register.html',
  directives: [
    coreDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialButtonComponent,
    MaterialInputComponent,
  ],
  exports: [RoutePaths, Routes],
)
class Register {
  final DatabaseHandlerService _dbService;
  final Location _location;

  String email = '';
  String password = '';
  String name = '';
  String phoneNumber = '';
  String deliveryDirection = '';

  Register(this._dbService, this._location);

  void onSubmit() async {
    if (isValid()) {
      var success = await _dbService.registerUser(email, password, name, phoneNumber, deliveryDirection);
      print(success);
      clear();
      _location.back();
    }
  }

  void clear() {
    email = '';
    password = '';
    name = '';
    phoneNumber = '';
    deliveryDirection = '';
  }

  bool isValid() {
    if (email == '' && password == '' && name == '' && phoneNumber == '' && deliveryDirection == '') {
      return false;
    }
    return true;
  }
}
