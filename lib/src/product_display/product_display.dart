import 'package:Shopby/src/database_handler/product.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'product-display',
  templateUrl: 'product_display.html',
)
class ProductDisplay {
  @Input()
  Product product;
}
