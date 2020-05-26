import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_router/angular_router.dart';
import 'package:pq_toast/pq_toast.dart';

@Component(
  selector: 'register-moderator',
  templateUrl: 'register_moderator.html',
  directives: [
    coreDirectives,
    formDirectives,
    materialInputDirectives,
    MaterialButtonComponent,
    MaterialInputComponent,
  ],
  styleUrls: [
    'register_moderator.css',
    'package:angular_components/app_layout/layout.scss.css',
    '../../app_component.css',
    'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
  ],
)
class RegisterModerator {
  final DatabaseHandlerService _dbService;
  final Router _router;

  String email = '';
  String password = '';
  String name = '';

  RegisterModerator(this._dbService, this._router);

  void onSubmit() async {
    if (isValid()) {
      var success = await _dbService.registerModerator(email, password, name);
      clear();
      if (success) {
        Toast.showSuccessToast('Successful register');
        await _router.navigate('/statistics');
      } else {
        Toast.showErrorToast('Account already exists');
      }
    }
  }

  void clear() {
    email = '';
    password = '';
    name = '';
  }

  bool isValid() {
    if (email == '' && password == '' && name == '') {
      return false;
    }
    return true;
  }
}
