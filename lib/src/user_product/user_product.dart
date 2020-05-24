import 'package:Shopby/src/database_handler/database_handler_service.dart';
import 'package:Shopby/src/database_handler/product.dart';
import 'package:Shopby/src/product_display/product_display.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'user-product',
  templateUrl: 'user_product.html',
  directives: [
    coreDirectives,
    ProductDisplay
  ],
)
class UserProduct implements OnInit {
  final DatabaseHandlerService _dbService;
  List<Product> userProducts;

  UserProduct(this._dbService);

  @override
  void ngOnInit() async {
    userProducts = await _dbService.getProductsByUser(_dbService.currentUser.getEmail());
  }
}
