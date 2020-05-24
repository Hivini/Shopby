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

  @Input()
  Product product;

  ProductDisplay(this._dbService);

  void removeProduct() async {
    var response = await _dbService.deleteProduct(product.productId);
    if (response) {
      Toast.showInfoToast('Deleted product');
    } else {
      Toast.showErrorToast('An error encountered when deleting the product');
    }
  }
}
