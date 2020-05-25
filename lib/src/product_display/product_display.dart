import 'dart:async';

import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/database_handler/product.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:pq_toast/pq_toast.dart';

@Component(
  selector: 'product-display',
  templateUrl: 'product_display.html',
  directives: [
    coreDirectives,
    MaterialButtonComponent,
  ],
)
class ProductDisplay {
  final DatabaseHandlerService _dbService;
  final _deleteRequest = StreamController<String>();

  @Input()
  Product product;

  @Input()
  bool showRemoveButton = false;

  @Output()
  Stream<String> get reload => _deleteRequest.stream;

  ProductDisplay(this._dbService);

  void removeProduct() async {
    var response = await _dbService.deleteProduct(product.getProductId());
    if (response) {
      Toast.showInfoToast('Deleted product');
      _deleteRequest.add('reload');
    } else {
      Toast.showErrorToast('An error encountered when deleting the product');
    }
  }
}
