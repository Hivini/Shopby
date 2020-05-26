import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:angular_router/angular_router.dart';
import 'package:pq_toast/pq_toast.dart';

@Component(
  selector: 'register-product',
  templateUrl: 'register_product.html',
  directives: [
    coreDirectives,
    formDirectives,
    materialInputDirectives,
    materialNumberInputDirectives,
    MaterialButtonComponent,
    MaterialInputComponent,
  ],
  styleUrls: [
    '../../app_component.css',
    'package:angular_components/css/mdc_web/card/mdc-card.scss.css',
  ],
)
class RegisterProduct {
  final DatabaseHandlerService _dbService;
  final Router _router;

  String title = '';
  String description = '';
  num price = 0.0;
  String imageUrl = '';

  RegisterProduct(this._dbService, this._router);

  void onSubmit() async {
    if (isValid()) {
      var response = await _dbService.registerProduct(_dbService.currentUser.getEmail(), title, description, price, imageUrl);
      if (response) {
        Toast.showSuccessToast('Product has been registered');
        await _router.navigate('/userProducts');
      } else {
        Toast.showErrorToast('An error has occurred when registering product.');
      }
    } else {
      Toast.showWarningToast('Complete all the fields');
    }
  }

  bool isValid() {
    if (title == '' && description == '' && price < 1 && imageUrl == '') {
      return false;
    }
    return true;
  }
}
